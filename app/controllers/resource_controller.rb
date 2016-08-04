class ResourceController < ApplicationController
  before_action :find_resource, only: [:show, :edit, :update, :destroy]
  helper_method :human_resource_name

  # GET /resources
  def index
    @resources = resource_class.all
  end

  # GET /resources/1
  def show
  end

  # GET /resources/new
  def new
    @resource = resource_class.new
  end

  # GET /resources/1/edit
  def edit
  end

  # POST /resources
  def create
    @resource = resource_class.new(resource_params)

    if @resource.save
      redirect_to resources_path, notice: "成功创建 #{human_resource_name} ##{@resource.id}"
    else
      render :new
    end
  end

  # PATCH/PUT /resources/1
  def update
    if @resource.update(resource_params)
      redirect_to resources_path, notice: "成功更新 #{human_resource_name} ##{@resource.id}"
    else
      render :edit
    end
  end

  # DELETE /resources/1
  def destroy
    @resource.destroy
    redirect_to resources_path, notice: "成功删除 #{human_resource_name} ##{@resource.id}"
  end

  private
    def resource_class
      raise NotImplementedError
    end

    def resources_path
      { action: :index }
    end

    def human_resource_name
      resource_class.model_name.human
    end

    # Use callbacks to share common setup or constraints between actions.
    def find_resource
      @resource = resource_class.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      raise NotImplementedError
    end
end
