class DashboardController < ApplicationController

before_action :authenticate_user!
before_action :check_user

  def index
    @user = current_user
    @products = Product.where(user: current_user)
  end

  def check_user
    unless current_user.has_role?(:bcmember)
      redirect_to root_url, alert: "Sorry, you do not have access to this content."
    end
  end
end

