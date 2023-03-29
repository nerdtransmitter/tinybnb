class ListingsController < ApplicationController
  before_action :set_listing, only: %i[show edit update destroy approve]

  def index
    @listings = Listing.all
  end

  def show
  end

  def new
    @home = Home.find(params[:home_id])
    @listing = Listing.new
    authorize @listing
  end

  def create
    @listing = Listing.new(listing_params)
    @home = Home.find(params[:home_id])
    @listing.home = @home
    @listing.user = current_user
    @listing.status = "listed"
    authorize @listing
    if @listing.save
      redirect_to listing_path(@listing)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
    authorize @listing
  end

  def update
    @listing.update(listing_params)
    authorize @listing
    if @listing.save
      redirect_to home_path(@home)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @listing
    @listing.destroy
    redirect_to root_path
  end

  def approve
    @listing.update(state: "approved")
    authorize @listing
    if @listing.state == "approved"
      flash[:success] = "Listing successfully approved"
    else
      flash[:error] = "Listing not approved"
    end
    redirect_to home_path(@listing.home)
  end

  private

  def set_listing
    @listing = Listing.find(params(:id))
  end

  def listing_params
    params.require(:listing).permit(:start_date, :end_date)
  end
end
