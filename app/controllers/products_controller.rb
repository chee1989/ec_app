class ProductsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @search_params = product_search_params
    @products = Product.with_attached_images.includes(:user, :category).search(@search_params).page(params[:page])
    # render :json => @products
    # render json: { status: 'SUCCESS', message: 'Loaded posts', data: @products }
  end

  def show
    @product = Product.find(params[:id])
  end

  def favorites
    @products = current_user.favorite_products.includes(:user, :category)
  end

  def new
  end
  
  def create
    @product = Product.find(params[:id])

    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })
  
    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @product.price,
      description: @product.title,
      currency: 'jpy',
    })
  
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to product_path(@product)
  end

  private
  def product_search_params
    params.fetch(:search, {}).permit(:title, :min_price, :max_price, :category_id, :user_id)
  end
end
