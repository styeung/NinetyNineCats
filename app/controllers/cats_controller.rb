class CatsController < ApplicationController
  before_action :require_owns_cat!, only: [:edit, :update]

  def index
    @cats = Cat.all

    render :index
  end


  def show
    @cat = Cat.find(params[:id])

    @rental_requests = CatRentalRequest.where(:cat_id => @cat.id).order(:start_date)

    render :show
  end

  def new
    @cat = Cat.new

    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id if signed_in?

    if @cat.save
      redirect_to cat_url(@cat)
    else
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])

    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      render :edit
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :age, :birth_date,
                                :color, :sex, :description)
  end
end
