class Api::V1::ProductsController < Api::V1::BaseController
  before_action :find_product, only: [:show, :update, :destroy]

  def index
    render json: Product.all
  end

  def create
    product = Product.new(product_params)
    if product.save
      render json: product, status: 201
    else
      render json: { errors: product.errors }, status: 422
    end
  end

  def show
    render json: @product
  end

  def update
    product = Product.find(params[:id])

    if product.update(product_params)
      render json: product, status: 200
    else
      render json: { errors: product.errors }, status: 422
    end
  end

  def destroy
    @product.destroy!
    render json: 204
  end

  private

  def product_params
    params.permit(:name, :description, :price)
  end

  def find_product
    @product = Product.find(params[:id])
  end
end
