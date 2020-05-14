class FavoritesController < ApplicationController
  include ActionView::Helpers::TextHelper

  def index

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

    redirect_to "/pets/#{params[:pet_id]}"

  end
end
