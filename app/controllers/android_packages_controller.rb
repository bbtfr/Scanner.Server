class AndroidPackagesController < ResourceController

  private
    def resource_class
      AndroidPackage
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      params.require(:android_package).permit(:version, :file)
    end
end
