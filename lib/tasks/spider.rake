namespace :spider do
  desc 'http://www.heqhd.lss.gov.cn/'
  task :qinhuangdao => [:environment] do
    require 'mechanize'
    agent = Mechanize.new do |agent|
      agent.user_agent_alias = 'Mac Safari'
      agent.ignore_bad_chunking = true
      agent.keep_alive = false
      # agent.log = Logger.new $stderr
      # agent.agent.http.debug_output = $stderr
      # agent.agent.allowed_error_codes = [500]
    end

    base_url = 'http://www.heqhd.lss.gov.cn'
    url = base_url + '/ecdomain/portal/portlets/newslist/newslistcomponent.jsp?goPage=1&pageNum=1&siteID=qhdrsjweb&pageID=mmkkajmkmjdfbboaijdpmdnofbdbnllo&moduleID=mmkojnklmjdfbboaijdpmdnofbdbnllo&moreURI=/ecdomain/framework/qhdrsjweb/mmkkajmkmjdfbboaijdpmdnofbdbnllo/mmkojnklmjdfbboaijdpmdnofbdbnllo.do&var_temp=ebboaphggkcibboaiipppbdleccniclk'

    loop do
      page = agent.get(url)
      page.search('form.jspcCommand a.C404040').each do |link|
        created_at = Time.parse link.parent.parent.css('font').text
        title = link.attr('title')
        url = base_url + link.attr('href')
        detail_page = agent.get(url)
        url = base_url + detail_page.search('iframe').last.attr('src')
        puts title, url
        News.create(title: title, author: '秦皇岛市人力资源和社会保障局', category: 'policies', source_url: url, created_at: created_at)
      end

      link = page.search('a.jspcCommand').find do |link| link.text == '>>' end
      if link
        url = base_url + link.attr('href')
      else
        break
      end
    end
  end
end
