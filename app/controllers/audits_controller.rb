class AuditsController < ApplicationController
  def show
    redirect_to action: :identify
  end

  def identify
    @callings = IdentifyCalling.all
  end

  def people
    @people = Person.all
  end
end
