class NewsController < ApplicationController
  before_action :set_news, only: [:show, :edit, :update, :destroy]

  # GET /news
  def index
    @news = News.all
  end

  # GET /news/1
  def show
    render :show, layout: false
  end

  # GET /news/new
  def new
    @news = News.new
  end

  # GET /news/1/edit
  def edit
  end

  # POST /news
  def create
    @news = News.new(news_params)

    if @news.save
      redirect_to news_index_url, notice: "成功创建 社保新闻 ##{@news.id}"
    else
      render :new
    end
  end

  # PATCH/PUT /news/1
  def update
    if @news.update(news_params)
      redirect_to news_index_url, notice: "成功更新 社保新闻 ##{@news.id}"
    else
      render :edit
    end
  end

  # DELETE /news/1
  def destroy
    @news.destroy
    redirect_to news_index_url, notice: "成功删除 社保新闻 ##{@news.id}"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news
      @news = News.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def news_params
      params.require(:news).permit(:title, :author, :source_content, :source_url,
        :thumbnail_url, :thumbnail_image)
    end
end
