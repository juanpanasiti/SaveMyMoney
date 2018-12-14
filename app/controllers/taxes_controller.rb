class TaxesController < ApplicationController
  before_action :set_tax, only: [:edit, :update, :destroy, :create_payment, :new_payment]
  before_action :options_for_select, only: [:new, :create, :edit, :update]

  def index
    @taxes = Tax.all
  end

  def new
    @tax = Tax.new
  end
  def create
    @tax = current_user.taxes.new(tax_params)
    respond_to do |format|
      if @tax.save
        format.html { redirect_to taxes_path, notice: 'Pago de Impuesto agregado.' }
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
    @payment = @tax.payments.new
  end
  def create_payment
    @payment = current_user.payments.new(payment_params)
    @payment.status = "Para pagar"
    @payment.payable_type = "Tax"
    @payment.payable_id = @tax.id
    @payment.fee = 1
    respond_to do |format|
      if @payment.save!
        format.html { redirect_to taxes_path, notice: 'Pago de Impuesto agregado.' }
      else
        format.html { render :new_payment }

      end#if/else
    end#respond_to
  end

  protected
  def set_tax
    @tax = Tax.find(params[:id])
  end#set_tax

  def tax_params
    params.require(:tax).permit(:user_id, :name, :service)
  end#tax_params
  def payment_params
    params.require(:payment).permit(:user_id, :payable_type, :payable_id, :fee, :amount, :status, :expiration)
  end#payment_params

  def options_for_select
    @services_options = Tax.get_services
  end#options_for_select
end
