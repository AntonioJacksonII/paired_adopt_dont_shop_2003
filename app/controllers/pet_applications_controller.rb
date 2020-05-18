class PetApplicationsController < ApplicationController


  def index
    @pet = Pet.find(params[:pet_id])
  end

  def update
    pet = Pet.find(params[:pet_id])
    application = Application.find(params[:application_id])
    application.status = "approved"
    pet.adoption_status = "pending"
    pet.save
    application.save
    flash[:notice] = "Your application was approved for the pet you selected!"
    redirect_to "/pets/#{pet.id}"
  end



  # private
  #
  # def pet_params
  #
  # end
end
