class ApplicationsController < ApplicationController

  def new
  end

  def create

    new_app = Application.new(application_params)
    if new_app.save
      pets.each do |pet|
        if params.has_key?("#{pet.id}")
          new_app.pets << pet
          app_fav = session[:favorites].find{ |favorite| favorite["id"] == pet.id}
          session[:favorites].delete(app_fav)
        end
      end


    flash[:notice] = "Your application was submitted for the pets you selected!"
    redirect_to "/favorites"

    else
      flash[:notice] = "Please, fill in all the forms below to submit"
      redirect_to "/applications/new"
    end
  end

  def show
    @application = Application.find(params[:application_id])

  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone, :description)
  end
end
