class V1::PaymentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    if params[:stripeToken]

      amount = 1000

      customer = Stripe::Customer.create(
        email: params[:stripeEmail],
        source: params[:stripeToken]
      )

      charge = Stripe::Charge.create(
        customer: customer.id,
        amount: amount,
        description: 'New Fake News Subscriber',
        currency: 'sek'
      )
      if charge.paid
        current_user.update_attribute(:role, 'subscriber')
        render json: {message: 'Transaction successful'}
      else
        render json: {error: 'Transaction unsuccessful'}, status: 402
      end
    else
      render json: {error: 'Transaction unsuccessful'}, status: 402
    end
  end
end
