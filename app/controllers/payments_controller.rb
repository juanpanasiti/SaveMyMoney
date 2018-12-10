class PaymentsController < ApplicationController
  before_action :set_payment, only: [:pay, :unpay]
  def index
    @current_payments = Payment.current_month(current_user)
    @next_month_payments = Payment.next_month(current_user)
    @future_payments = Payment.future_months(current_user).order('expiration ASC').order('fee ASC')
    @past_payments = Payment.past_months(current_user)
    @has_past_payments = @past_payments.count > 0 ? true : false
  end

  def pay
    if @payment.pay
      redirect_to payments_path, notice: "Cuota pagada!"
    else
      redirect_to payments_path, alert: "Error!!"
    end
  end #pay

  def unpay
    if @payment.unpay
      redirect_to payments_path, alert: "Pago cancelado!"
    else
      redirect_to payments_path, alert: "Error!!"
    end
  end #unpay

  protected
  def set_payment
    @payment = Payment.find(params[:id])
  end
end
