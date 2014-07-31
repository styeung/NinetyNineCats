class CatRentalRequestsController < ApplicationController
  before_action :require_owns_cat!, only: [:approve, :deny]

  def new
    @rental_request = CatRentalRequest.new

    render :new
  end

  def create
    @rental_request = CatRentalRequest.new(rental_request_params)
    @rental_request.user_id = current_user.id

    if @rental_request.save
      redirect_to cat_url(@rental_request.cat_id)
    else
      render :new
    end
  end

  def approve
    @rental_request = CatRentalRequest.find(params[:id])
    @rental_request.approve!

    redirect_to cat_url(@rental_request.cat_id)
  end

  def deny
    @rental_request = CatRentalRequest.find(params[:id])
    @rental_request.deny!

    redirect_to cat_url(@rental_request.cat_id)
  end

  private

  def rental_request_params
    params.require(:rental_request).permit(:cat_id, :start_date, :end_date)
  end

end
