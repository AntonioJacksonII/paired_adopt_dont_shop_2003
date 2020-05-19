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
    pet = shelter.pets.new(pet_params)
    unless pet.save
      flash[:notice] = "Please fill in all fields, including #{missing_params}"
      redirect_to "/shelters/#{shelter.id}/pets/new"
    else
      redirect_to "/shelters/#{shelter.id}/pets"
    end
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update(pet_params)
    if pet.save
      redirect_to "/pets/#{pet.id}"
    else
      flash[:notice] = "Please fill in #{missing_params}"
      redirect_to "/pets/#{pet.id}/edit"
    end
  end

  def destroy
    all_fav = session[:favorites]
    if all_fav != nil
      fav_session = all_fav.find {|favorite| favorite["id"] == params[:id].to_i}
      session[:favorites].delete(fav_session)
    end
    Pet.destroy(params[:id])
    redirect_to "/pets"
  end

  private

  def pet_params
    defaults = {adoption_status: 'adoptable'}
    params.permit(:image, :name, :description, :approximate_age, :sex, :shelter_id).reverse_merge(defaults)
  end

  def missing_params
    missing = []
    if params["image"] == ""
      missing << "image"
    end
    if params["name"] == ""
      missing << "name"
    end
    if params["description"] == ""
      missing << "description"
    end
    if params["approximate_age"] == ""
      missing << "approximate age"
    end
    if params["sex"] == ""
      missing << "sex"
    end
    missing.join(", ")
  end
end
