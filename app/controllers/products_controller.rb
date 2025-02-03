class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  # GET /products or /products.json
  def index
    @products = Product.all.order(:name)
    @products = @products.where("products.name like ?", "%#{params[:name]}%") if params[:name].present?
    @products = @products.order(params.slice("column", "direction").values.join(" "))
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.turbo_stream do
          flash.now[:notice] = "Product was successfully created."
          render turbo_stream: [
            turbo_stream.replace("flash_messages", partial: "shared/flash"),
            turbo_stream.append("products_list", partial: "products/product", locals: {product: @product})
          ]
        end
        format.html { redirect_to @product, notice: "Product was successfully created." }
      else
        format.turbo_stream do
          flash.now[:alert] = @product.errors.full_messages.to_sentence
          render turbo_stream: [
            turbo_stream.replace("flash_messages", partial: "shared/flash"),
            turbo_stream.replace("product_form", partial: "products/form", locals: {product: @product})
          ]
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.turbo_stream do
          flash.now[:notice] = "Product was successfully updated."
          render turbo_stream: [
            turbo_stream.replace("flash_messages", partial: "shared/flash"),
            turbo_stream.replace("product_details", partial: "products/product", locals: {product: @product})
          ]
        end
        format.html { redirect_to @product, notice: "Product was successfully updated." }
      else
        format.turbo_stream do
          flash.now[:alert] = @product.errors.full_messages.to_sentence
          render turbo_stream: [
            turbo_stream.replace("flash_messages", partial: "shared/flash"),
            turbo_stream.replace("product_form", partial: "products/form", locals: {product: @product})
          ]
        end
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :description, :price, :quantity, :image)
  end
end
