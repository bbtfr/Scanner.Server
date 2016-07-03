module Scanner
  module Routes
    class Identity < Scanner::Server

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

      before do
        @unique_id = params[:uniqueId]
        error_json 400, '请求参数错误' unless @unique_id

        @ability = Ability.find(unique_id: @unique_id) || Ability.create(unique_id: @unique_id, use_counts: {})
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

        logger.debug "  UID #{@unique_id} increase use count: #{@feature} => #{@ability.use_count(@feature)}."
        @ability.increase_use_count! @feature
        render_json
      end

    end
  end
end
