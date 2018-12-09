class PaymentsController < ApplicationController
  def index
    @current_payments = Payment.current_month(current_user)
    @next_month_payments = Payment.next_month(current_user)
    @future_payments = Payment.future_months(current_user)
    @past_payments = Payment.past_months(current_user)
    @has_past_payments = @past_payments.count > 0 ? true : false
  end
end
