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
      if self.class.logging <= Logger::DEBUG
        @request_start_at = Time.now

        method = env[Rack::REQUEST_METHOD]
        path = env[Rack::PATH_INFO]
        query = env[Rack::QUERY_STRING]
        path << "?#{query}" unless query.empty?
        remote = env['HTTP_X_FORWARDED_FOR'] || env["REMOTE_ADDR"] || "-"

        logger.debug "Started #{method} \"#{path}\" for #{remote} at #{@request_start_at}"
        logger.debug "  Params: #{params}"
      end

      @unique_id = params[:uniqueId]
      error_json 400, '请求参数错误' unless @unique_id

      @ability = Ability.find(unique_id: @unique_id) || Ability.create(unique_id: @unique_id, use_counts: {})
    end

    after do
      duration = ((Time.now - @request_start_at) * 1000).to_i
      logger.debug "Completed #{status} #{Rack::Utils::HTTP_STATUS_CODES[status]} in #{duration}ms" if @request_start_at
    end

    helpers do
      def check_ability feature
        if @ability.has_ability? feature
          @ability.increase_use_count! feature
        else
          logger.debug "  UID #{@unique_id} reach limit: #{feature}"
          error_json 200, '接口使用超过限制次数'
        end
      end
    end

    set :logging, development? ? ::Logger::DEBUG : ::Logger::INFO
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
      logger.debug "  UID #{@unique_id} abilities: #{@ability.abilities}."
      render_json abilities: @ability.abilities
    end

    post '/use_count' do
      @feature = params['feature']
      error_json 400, '请求参数错误' unless @feature

      logger.debug "  UID #{unique_id} increase use count: #{feature} => #{use_counts[feature]}."
      @ability.increase_use_count! @feature
      render_json
    end

  end
end
