class NewsController < ResourceController
  def show
    render :show, layout: false
  end

  private
    def resource_class
      News
    end

    def resource_path
      resources_path
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      params.require(:news).permit(:title, :author, :raw_source_content, :source_content,
        :source_url, :thumbnail_url, :thumbnail_image, :category)
    end
end
