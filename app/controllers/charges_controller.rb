class ChargesController < ApplicationController
  before_action :amount, only: [:new, :create]

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.name}",
      amount: @amount
    }
  end

  def create

    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: "Rails Stripe Customer",
      currency: "usd"
      )

    if charge[:paid] == true
      current_user.premium?
    end

    flash[:success] = "Thanks for all the money, #{current_user.name}!, Feel free to pay me again"
    redirect_to wikis_path

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  protected

  def amount
    @amount = 1500
  end
end
