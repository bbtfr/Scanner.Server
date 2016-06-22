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
    end

    after do
      if @request_start_at
        duration = ((Time.now - @request_start_at) * 1000).to_i
        logger.debug "Completed #{status} #{Rack::Utils::HTTP_STATUS_CODES[status]} in #{duration}ms"
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

  end
end
