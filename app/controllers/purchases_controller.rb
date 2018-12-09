class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:edit, :update, :destroy, :create_payments]
  before_action :options_for_select, only: [:new, :create, :edit, :update]

  def index
    @purchases = Purchase.all
  end

  def new
    @purchase = Purchase.new
  end
  def create
    @purchase = current_user.purchases.new(purchase_params)
    respond_to do |format|
      if @purchase.save
        format.html { redirect_to purchases_path, notice: 'Compra agregada, pero deja de gastar plata!.' }
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

  def create_payments
    createds = Payment.where(payable_type: :purchase).where(payable_id: @purchase.id).count
    if createds == 0
      if @purchase.generate_payments
        redirect_to purchases_path, notice: 'Se cargaron correctamente los pagos pendientes de las compras.'
      else
        redirect_to purchases_path, alert: 'Se produjeron errores al guardar los pagos.'
      end
    else
      redirect_to purchases_path, alert: 'Ya existen los pagos para esa compra.'
    end#if/else
  end#create_payments
  protected
  def set_purchase
    @purchase = Purchase.find(params[:id])
  end#set_purchase

  def purchase_params
    params.require(:purchase).permit(:user_id, :name, :credit_card_id, :amount, :fees, :first_payment, :status)
  end#purchase_params

  def options_for_select
    @credit_cards_options = CreditCard.get_for_form
  end#options_for_select
end
