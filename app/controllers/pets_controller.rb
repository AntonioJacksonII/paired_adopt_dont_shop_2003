class PetsController < ApplicationController

  def index

    @shelter_id = params[:shelter_id]


    @pets = Pet.all

  end

  def show
  @pet = Pet.find(params[:pet_id])

  end

  def new

    @shelter_id = params[:id]
  end

  def create

    shelter = Shelter.find(params[:id])
    pet = shelter.pets.create!(pet_params)

    redirect_to "/shelters/#{shelter.id}/pets"
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update(pet_params)
    pet.save
    redirect_to "/pets/#{pet.id}"
  end

  def destroy

    Pet.destroy(params[:id])
    redirect_to "/pets"
  end

  private

  def pet_params
    defaults = {adoption_status: 'adoptable'}
    params.permit(:image, :name, :description, :approximate_age, :sex, :shelter_id).reverse_merge(defaults)
  end
end
