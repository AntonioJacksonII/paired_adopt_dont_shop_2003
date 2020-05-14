class FavoritesController < ApplicationController
  include ActionView::Helpers::TextHelper

  def update
    pet = Pet.find(params[:pet_id])
    @favorites = Favorite.new(session[:favorites])
    @favorites.add_pet(pet)
    session[:favorites] = @favorites.contents
    flash[:notice] = "You have added #{pet.name} to your favorites!"
    redirect_to "/pets/#{pet.id}"
  end

  def destroy

    favorite_pet = favorites.contents.find do |pet_entry|
      pet_entry["id"] == params[:pet_id].to_i
    end

    flash[:notice] = "You have removed #{favorite_pet["name"]} from your favorites!"
    favorites.contents.delete(favorite_pet)
    binding.pry
    redirect_to "/pets/#{params[:pet_id]}"

  end
end
