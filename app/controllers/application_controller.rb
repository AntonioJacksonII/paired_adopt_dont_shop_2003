class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :favorites, :pets, :applications

  def favorites
    @favorites ||= Favorite.new(session[:favorites])
  end

  def pets
    Pet.all
  end

  def applications
    Application.all
  end
end
