class ChargesController < ApplicationController
  before_action :set_amount

  def new
  end 

  def create
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer => customer.id,
      :amount => @amount, #in cents
      :description => 'Rails Stripe Customer',
      :currency => 'aud'
    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  private
  def set_amount
    @amount = product.price
  end

end
