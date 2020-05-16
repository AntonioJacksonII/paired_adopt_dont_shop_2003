class ApplicationsController < ApplicationController

  def new
  end

  def create
    new_app = Application.create!(application_params)
    pets.each do |pet|
      if params.has_key?("#{pet.id}")
        new_app.pets << pet
        app_fav = session[:favorites].find{ |favorite| favorite["id"] == pet.id}
        session[:favorites].delete(app_fav)
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
