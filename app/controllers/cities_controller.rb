class CitiesController < ResourceController

  private
    def resource_class
      City
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      params.require(:city).permit(:name)
    end
end
