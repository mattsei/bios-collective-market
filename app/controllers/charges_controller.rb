class ChargesController < ApplicationController
  def new
  end 

  def create
    customer = Stripe::Customer.create(
      :email => params[stripeEmail],
      :source => params [:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer => customer.id,
      :amount => @amount, #in cents
      :description => 'Rails Stripe Customer',
      :currency => 'aud'
    )
  end

end
