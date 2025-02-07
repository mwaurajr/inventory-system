class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  def index
    flash.now[:notice] = "Welcome to Inventory Hub, you're signed in as an admin."
    @products = Product.filter(params)
  end

  def show; end

  def new
    @product = Product.new
  end

  def edit; end

  def create
    @product = Product.new(product_params)
    respond_to do |format|
      if @product.save
        format.turbo_stream do
          flash.now[:notice] = 'Product was successfully created.'
          render turbo_stream: [
            # Replace the flash messages section with updated content
            turbo_stream.replace('flash_messages', partial: 'shared/flash'),

            # Add the new product to the products grid
            turbo_stream.append('products_grid', partial: 'products/product', locals: { product: @product }),

            # Clear the modal/form after successful creation
            turbo_stream.replace('new_product_modal', '')
          ]
        end
        # Fallback for non-Turbo requests
        format.html { redirect_to products_path, notice: 'Product was successfully created.' }
      else
        format.turbo_stream do
          flash.now[:alert] = @product.errors.full_messages.to_sentence
          render turbo_stream: [
            # Update flash messages to show errors
            turbo_stream.replace('flash_messages', partial: 'shared/flash'),

            # Re-render the form with errors
            turbo_stream.replace('product_form', partial: 'products/form', locals: { product: @product })
          ]
        end
        # Fallback for non-Turbo requests
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.turbo_stream do
          flash.now[:notice] = 'Product was successfully updated.'
          render turbo_stream: [
            turbo_stream.replace('flash_messages', partial: 'shared/flash'),
            turbo_stream.replace('product_details', partial: 'products/product', locals: { product: @product })
          ]
        end
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
      else
        format.turbo_stream do
          flash.now[:alert] = @product.errors.full_messages.to_sentence
          render turbo_stream: [
            turbo_stream.replace('flash_messages', partial: 'shared/flash'),
            turbo_stream.replace('product_form', partial: 'products/form', locals: { product: @product })
          ]
        end
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to products_path, notice: 'Product was successfully destroyed.' }
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
