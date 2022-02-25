class Admin::ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all

    respond_to do |format|
      format.html
      format.csv { send_data @products.to_csv, filename: "products-#{Date.today}.csv" }
    end
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.product_category = @product.category.name
    if @product.save
      flash[:notice] = "Product was sucessfully added!"
      redirect_to admin_product_path(@product)
    else
      render :new, status: 422
    end
  end

  def show
  end

  def edit
  end

  def update
    if @product.update(product_params)
      flash[:notice] = "Product was sucessfully updated!"
      redirect_to admin_product_path(@product)
    else
      render :edit, status: 422
    end    
  end

  def destroy
    @product.destroy
    flash[:notice] = "Product was sucessfully destroyed!"
    redirect_to admin_products_path
  end

  private
    def product_params
      product_params = params.require(:product).permit(:name, :description, :category_id, :product_category, :stock, :price)
    end

    def set_product
      @product = Product.find(params[:id])
    end
end
