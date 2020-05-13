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
end
