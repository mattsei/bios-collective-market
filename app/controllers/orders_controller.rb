class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # before_action :set_amount

  after_action :send_email, only: [:create]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    @product = Product.find(params[:product_id])
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @product = Product.find(params[:product_id])
    @amount = (@product.price * 100).floor
    @seller = @product.user

   

    @order.product_id = @product.id
    @order.buyer_id = current_user.id
    @order.seller_id = @seller.id

    respond_to do |format|
      if @order.save
        # OrderMailer.send_order_email(@user).deliver
        format.html { redirect_to products_path, notice: 'Order was successfully submitted.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end

  customer = nil
  if current_user.stripe_customer_id.present?
    customer = Stripe::Customer.retrieve(current_user.stripe_customer_id)
  else
    customer = Stripe::Customer.create(
      :email => current_user.email,
      :source => params[:stripeToken],
      :shipping => {
        :address => {
          :line1 => current_user.address['street_address'],
          :city => current_user.address['city'],
          :state => current_user.address['state'],
          :postal_code => current_user.address['postcode'],
          :country => current_user.address['country'],
        },
        :name => current_user.first_name + " " + current_user.last_name,
      }
    )
  end

    charge = Stripe::Charge.create(
      :customer => customer.id,
      :amount => @amount, #in cents
      :description => @product.name,
      :currency => 'aud'
    )

    current_user.update_attributes(stripe_customer_id: customer.id)
    # rescue Stripe::CardError => e
    #   flash[:error] = e.message
    #   redirect_to new_order_path
    # end

    # private
    # def set_amount
    #   @amount = product.price
    # end

  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.permit(:product_id, :buyer_id, :seller_id)
    end

    # def set_amount
    #   @amount = @product.price
    # end

    def send_email
      OrderMailer.send_order_email(current_user).deliver
    end
end
