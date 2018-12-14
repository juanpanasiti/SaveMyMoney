class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:edit, :update, :destroy, :create_payments, :delete_payments]
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
    respond_to do |format|
      if @purchase.update(purchase_params)
        format.html { redirect_to purchases_path, notice: "Los datos de la compra '#{@purchase.get_item_name}' fueron actualizados." }
      else
        format.html { render :edit }
      end#if/else
    end#respond_to
  end#update

  def destroy
    @purchase.destroy
    respond_to do |format|
      format.html { redirect_to purchases_path, notice: 'Compra eliminada.' }
    end
  end

  def create_payments
    createds = Payment.where(payable_type: :Purchase).where(payable_id: @purchase.id).count
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

  def delete_payments
    payments = Payment.where(payable_type: :Purchase).where(payable_id: @purchase.id)
    counter = 0
    total = payments.count
    payments.each do |p|
      if p.delete
        counter = counter + 1
      end
    end
    redirect_to purchases_path, alert: "#{counter} de #{total} pagos eliminados"
  end
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
