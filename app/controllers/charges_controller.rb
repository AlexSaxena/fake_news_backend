require 'stripe'

class ChargesController < ApplicationController

  def create

    Stripe.api_key = 'sk_test_tHrClPOjEws9OdzVhfh8xvDC00oWD5d1My'

    begin

      customer = Stripe::Customer.create(
        :email => current_user.email,
        :source => params[:charge][:token]
      )

      charge = Stripe::Charge.create({
        :customer => customer.id,
        :amount => params[:charge][:amount],
        :description => params[:charge][:description],
        :currency => params[:charge][:currency],
      }, {
        :idempotency_key => ip_key
      })

    rescue Stripe::CardError => e
      render json: { message: 'Something went wrong, please try again later! || Ask you parents for another credit card.' }, status: :not_acceptable
    end
  end
end