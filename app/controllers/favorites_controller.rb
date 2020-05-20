class FavoritesController < ApplicationController
  include ActionView::Helpers::TextHelper

  def index
    app_pets = []
    applications.each do |application|
      application.pets.each do |pet|
        app_pets << pet
      end
    end
    @app_pets = app_pets.uniq
  end

  def update
    pet = Pet.find(params[:pet_id])
    @favorites = Favorite.new(session[:favorites])
    @favorites.add_pet(pet)
    session[:favorites] = @favorites.contents
    flash[:notice] = "You have added #{pet.name} to your favorites!"
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    current_favorites = session[:favorites]
    favorite_pet = current_favorites.find do |pet_entry|
      pet_entry["id"] == params[:pet_id].to_i
    end

    flash[:notice] = "You have removed #{favorite_pet["name"]} from your favorites!"
    session[:favorites].delete(favorite_pet)

    redirect_back(fallback_location:"/favorites")

  end

  def destroy_all
    session[:favorites].clear
    flash[:notice] = "You Have No More Favorite Pets"
    redirect_back(fallback_location:"/favorites")

  end
end
