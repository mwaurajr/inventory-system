require "csv"
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
            turbo_stream.update("flash_messages", partial: "shared/flash"),
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

  def export
    @products = Product.all.order(:name)

    respond_to do |format|
      format.csv { send_data generate_csv(@products), filename: "products-#{Date.today}.csv" }
      format.xlsx { send_data generate_excel(@products), filename: "products-#{Date.today}.xlsx" }
      format.html { redirect_to products_path, notice: "Export format not supported." }
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :quantity, :image)
  end

  def generate_csv(products)
    CSV.generate(headers: true) do |csv|
      # Define the header row
      csv << ["ID", "Name", "Description", "Price", "Quantity", "Created At"]
      # Add a row for each product
      products.each do |product|
        csv << [product.id, product.name, product.description, product.price, product.quantity, product.created_at]
      end
    end
  end

  def generate_excel(products)
    package = Axlsx::Package.new
    workbook = package.workbook

    workbook.add_worksheet(name: "Products") do |sheet|
      sheet.add_row ["ID", "Name", "Description", "Price", "Quantity", "Created At"]
      products.each do |product|
        sheet.add_row [product.id, product.name, product.description, product.price, product.quantity, product.created_at]
      end
    end

    package.to_stream.read
  end
end
