class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  def index
    flash.now[:notice] = "Welcome to Inventory Hub, you're signed in as an admin."
    @products = Product.filter(params)
  end

  def show
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      respond_to do |format|
        format.html { redirect_to quotes_path, notice: "#{@product.name} was successfully created." }
        format.turbo_stream do
          @products = Product.order(:name)
          flash.now[:notice] = "#{@product.name} was successfully created."
          render turbo_stream: [
            turbo_stream.prepend("products", partial: "products/product", locals: {product: @product}),
            turbo_stream.update("flash", partial: "shared/flash"),
            turbo_stream.replace("main", template: "products/index")
          ]
        end
      end
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      respond_to do |format|
        format.html { redirect_to quotes_path, notice: "#{@product.name} was successfully created." }
        format.turbo_stream { flash.now[:notice] = "#{@product.name} was successfully created." }
      end
    else
      render :new
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to products_path, notice: "Product was successfully destroyed." }
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :quantity, :image)
  end
end
