class Api::NewsController < Api::ApplicationController
  def index
    @page = (params[:page] || 1).to_i
    @per = (params[:per] || 10).to_i

    news_klass =
      if params[:category]
        News.where(category: params[:category])
      else
        News
      end

    @finished = news_klass.count <= @page * 10
    @news = news_klass.page(@page).per(@per)
  end
end
