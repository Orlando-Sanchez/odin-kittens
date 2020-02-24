class KittensController < ApplicationController
  before_action :correct_user,   only: [:edit, :update]

  def index
    @kittens = Kitten.all
    respond_to do |format|
        format.html
        format.json { render json: @kittens }
    end
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)
    if @kitten.save   
        flash[:info] = "Kitten created."
        redirect_to root_url
    else
        render 'new'
    end
  end

  def show
    @kitten = Kitten.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @kitten }
    end
  end

  def update
    if @kitten.update(kitten_params)
        flash[:success] = "Kitten updated"
        redirect_to @kitten
    else
        render 'edit'
    end
  end
 
  def edit
  end

  def destroy
    Kitten.find(params[:id]).destroy
    flash[:success] = "Kitten deleted"
    redirect_to kittens_url
  end

  private

  def kitten_params
    params.require(:kitten).permit(:name, :age, :cuteness,
                                 :softness)
  end

  def correct_user
    @kitten = Kitten.find(params[:id])
  end
end
