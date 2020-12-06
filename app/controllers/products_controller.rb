class ProductsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @products = Product.all.includes(:user)
  end

  def show
    @product = Product.find(params[:id])
  end

  def favorites
    @products = current_user.favorite_products.includes(:user)
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
end
