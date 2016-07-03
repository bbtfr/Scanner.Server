module Scanner
  module Routes
    class News < Scanner::Server

      set :root, File.expand_path("../../..", __FILE__)

      get '/page/:page' do
        page = (params[:page] || 1).to_i
        to = page * 10
        from = to - 9
        finished = page > 5

        base_url = "#{request.scheme}://#{request.host_with_port}"
        data = (from..to).map do |i|
          { title: "社保新闻 #{i}",
            subtitle: "#{Time.now.strftime("%Y年%-m月%-d日 %H:%M")} 李阳",
            url: "#{base_url}/news/sample.html",
            thumbnail: "#{base_url}/news/sample.jpg" }
        end

        render_json data: data, page: page, finished: finished
      end

    end
  end
end
