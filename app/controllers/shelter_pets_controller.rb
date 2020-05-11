class ShelterPetsController < ApplicationController

  def index

    @shelter_id = params[:shelter_id]
    shelter = Shelter.find(params[:shelter_id])
    @pets = shelter.pets
  
  end

  def new
  end


end
