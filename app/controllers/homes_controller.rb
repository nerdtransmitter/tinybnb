class HomesController < ApplicationController
  before_action :set_home, only: [:show, :destroy]

  def index
    @homes = Home.all
  end

  def show
  end

  def new
    @home = Home.new
  end

  def create
    @home = Home.new(home_params)
    @home.user = current_user
    if @home.save
      redirect_to homes_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @home.destroy
    redirect_to homes_path, status: :see_other
  end

  private

  def set_home
    @home = Home.find(params[:id])
  end

  def home_params
    params.require(:home).permit(:name, :address, :price, :description, :photo)
  end
end
