class MonthliesController < ApplicationController
  before_action :set_monthly, only: [:edit, :update, :destroy, :create_payment, :new_payment, :is_first_payment]
  before_action :options_for_select, only: [:new, :create, :edit, :update]
  before_action :is_first_payment, only: [:create_payment, :new_payment]

  def index
    @monthlies = Monthly.all
  end

  def new
    @monthly = current_user.monthlies.new
  end
  def create
    @monthly = current_user.monthlies.new(monthly_params)
    respond_to do |format|
      if @monthly.save
        format.html { redirect_to monthlies_path, notice: 'Pago Mensual agregado.' }
      else
        format.html { render :new }
      end#if/else
    end#respond_to
  end

  def edit
    #code
  end
  def update
    #code
  end

  def destroy
    #code
  end

  def new_payment
    @payment = @monthly.payments.new
    @payment.amount = @monthly.amount
    unless @isTheFirst
      @lastPayment = Payment.where(payable_type: :Monthly).where(payable_id: @monthly.id).last
      @payment.expiration = @lastPayment.expiration.advance(months: 1)
    end
  end
  def create_payment
    @payment = current_user.payments.new(payment_params)
    @payment.status = "Para pagar"
    @payment.payable_type = "Monthly"
    @payment.payable_id = @monthly.id
    @payment.fee = 1
    respond_to do |format|
      if @payment.save!
        format.html { redirect_to monthlies_path, notice: 'Pago de Impuesto agregado.' }
      else
        format.html { render :new_payment }

      end#if/else
    end#respond_to
  end

  protected
  def set_monthly
    @monthly = Monthly.find(params[:id])
  end#set_tax

  def monthly_params
    params.require(:monthly).permit(:user_id, :name, :amount, :credit_card_id)
  end#tax_params
  def payment_params
    params.require(:payment).permit(:user_id, :payable_type, :payable_id, :fee, :amount, :status, :expiration)
  end#payment_params

  def options_for_select
    @credit_cards_options = CreditCard.get_for_form
  end#options_for_select

  def is_first_payment
    @isTheFirst = (Payment.where(payable_type: :Monthly).where(payable_id: @monthly.id).count == 0)
  end#is_first_payment
end
