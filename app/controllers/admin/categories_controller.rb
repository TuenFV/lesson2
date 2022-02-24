class Admin::CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :show, :update, :destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new()
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category was successfully added!"
      redirect_to admin_category_path(@category)
    else
      flash[:alert] = @category.errors.full_messages
      render :new, status: 422
    end
  end

  def show
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "Category was sucessfully updated!"
      redirect_to admin_category_path(@category)
    else
      flash[:alert] = @category.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    flash[:notice] = "Category was sucessfully destroyed!"
    redirect_to admin_categories_path
  end

  private
    def category_params
      category_params = params.require(:category).permit(:name, :description)
    end

    def set_category
      @category = Category.find(params[:id])      
    end
end
