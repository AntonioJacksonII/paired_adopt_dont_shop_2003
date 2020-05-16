class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :favorites, :pets

  def favorites
    @favorites ||= Favorite.new(session[:favorites])
  end

  def pets
    Pet.all
  end
end
