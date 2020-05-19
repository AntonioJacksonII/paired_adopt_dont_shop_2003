class SheltersController < ApplicationController

  def index

  @shelters = Shelter.all

  end

  def show
    @shelter = Shelter.find(params[:id])

  end

  def new
  end

  def create
    shelter = Shelter.new(shelter_params)
    unless shelter.save
      flash[:notice] = "Please fill in #{missing_params}"
      render "/shelters/new"
    else
      redirect_to '/shelters'
    end
  end


  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update(shelter_params)
    shelter.save
    redirect_to "/shelters/#{shelter.id}"
  end

  def destroy
    shelter = Shelter.find(params[:id])
    Review.destroy(shelter.reviews.map{|review| review.id})
    Pet.destroy(shelter.pets.map{|pet| pet.id})
    Shelter.destroy(params[:id])
    redirect_to '/shelters'
  end

  private

  def  shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end

  def missing_params
    missing = []
    if params["name"] == ""
      missing << "name"
    end
    if params["address"] == ""
      missing << "address"
    end
    if params["city"] == ""
      missing << "city"
    end
    if params["state"] == ""
      missing << "state"
    end
    if params["zip"] == ""
      missing << "zip"
    end
    missing.join(", ")
  end

end
