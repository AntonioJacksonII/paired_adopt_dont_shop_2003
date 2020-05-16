class ApplicationsController < ApplicationController

  def new
  end

  def create
    require "pry"; binding.pry
    flash[:notice] = "Your application was submitted!"
    redirect_to "/favorites"
  end
end
