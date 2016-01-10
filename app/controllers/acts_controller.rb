class ActsController < ApplicationController
  def index
    @acts = Act.all
  end

  def new
    @act = Act.new
  end

  def create
    Act.create(act_params)
    redirect_to acts_path
  end

  def show
    @act = Act.find(params[:id])
  end

  def edit
    @act = Act.find(params[:id])
  end

  def update
    act = Act.find(params[:id])
    act.update(act_params)
    redirect_to act_path(act)
  end

  def destroy
    act = Act.find(params[:id])
    act.destroy
    redirect_to acts_path
  end

  private
  def act_params
    params.require(:act).permit(:name, :description, :image)
  end
end