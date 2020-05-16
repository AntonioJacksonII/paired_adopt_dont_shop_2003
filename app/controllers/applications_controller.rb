class ApplicationsController < ApplicationController

  def new
  end

  def create
    pets.each do |pet|
      if params.has_key?("#{pet.id}")
        pet.applications.create!(application_params)
        application_pet = session[:favorites].find{ |favorite| favorite["id"] == pet.id}
        session[:favorites].delete(application_pet)
      end
    end
    flash[:notice] = "Your application was submitted!"
    redirect_to "/favorites"
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone, :description)
  end
end
