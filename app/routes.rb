require 'sinatra/base'

module Scanner
  class Server < Sinatra::Base
    helpers SensetimeAPI

    helpers do
      def error_json code, message
        halt code, { status: :failed, message: message }.to_json
      end

      def render_json data = {}
        { status: :success }.merge(data).to_json
      end
    end

    before do
      puts "  Params: #{params}"

      @unique_id = params[:uniqueId]
      error_json 400, '请求参数错误' unless @unique_id

      @ability = Ability.find(unique_id: @unique_id) || Ability.create(unique_id: @unique_id, use_counts: {})
    end

    helpers do
      def check_ability feature
        if @ability.has_ability? feature
          @ability.increase_use_count! feature
        else
          puts "  UID #{@unique_id} reach limit: #{feature}"
          error_json 200, '接口使用超过限制次数'
        end
      end
    end

    set :environment, RACK_ENV
    set :show_exceptions, false

    error 404 do
      error_json 404, '请求页面不存在'
    end

    error 500 do
      error_json 500, '服务器内部错误'
    end

    post '/identify' do
      check_ability 'livenessTest'

      result = selfie_idnumber_verification params[:image][:tempfile], params[:id], params[:name]
      error_json 500, '服务器内部错误' unless result

      validity = result['identity']['validity'] && result['confidence'] > 0.75
      if validity
        render_json validity: validity
      else
        message = result['identity']['validity'] ? '脸谱信息验证失败' : '身份证信息验证失败'
        error_json 200, message
      end
    end

    post '/abilities' do
      render_json abilities: @ability.abilities
    end

    post '/use_count' do
      @feature = params['feature']
      error_json 400, '请求参数错误' unless @feature

      @ability.increase_use_count! @feature
      render_json
    end

  end
end
