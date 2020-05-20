class ReviewsController < ApplicationController

  def index
    @reviews = Review.all
  end

  def new
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    review = shelter.reviews.new(review_params)
    
    if review.rating.nil?
      flash[:notice] = "Please enter a rating between 1 and 5"
      redirect_to "/shelters/#{shelter.id}/reviews/new"
    elsif review.rating < 1 || review.rating > 5
      flash[:notice] = "Please select a rating between 1 and 5"
      redirect_to "/shelters/#{shelter.id}/reviews/new"
    elsif review.save
      redirect_to "/shelters/#{shelter.id}"
    else
      flash[:notice] = "Please Fill In Title, Rating, and Content"
      redirect_to "/shelters/#{shelter.id}/reviews/new"
    end
  end



  def edit
    @review = Review.find(params[:review_id])

  end

  def update
    review = Review.find(params[:review_id])
    review.update(review_params)

    if review.rating == nil || review.title == nil
      flash[:notice] = "Please Fill In Title, Rating, and Content"
      redirect_to "/shelters/#{review.shelter.id}/reviews/#{review.id}/edit"

    elsif review.rating.to_i < 1 || review.rating.to_i > 5
        flash[:notice] = "Please select a rating between 1 and 5"
        redirect_to "/shelters/#{review.shelter.id}/reviews/#{review.id}/edit"

    elsif review.update(review_params)
        redirect_to "/shelters/#{review.shelter.id}"
    end
  end

  def destroy
    review = Review.find(params[:id])
    Review.destroy(params[:id])
    redirect_to "/shelters/#{review.shelter_id}"
  end

  private

    def review_params
      params.permit(:title, :rating, :content, :picture)
    end

  end
