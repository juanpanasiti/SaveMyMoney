class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:edit, :update, :destroy]
  before_action :options_for_select, only: [:new, :create, :edit, :update]

  def index
    @purchases = Purchase.all
  end

  def new
    #code
  end
  def create
    #code
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

  protected
  def set_purchase
    @credit_card = CreditCard.find(params[:id])
  end#set_purchase

  def purchase_params
    params.require(:purchase).permit(:user_id, :name, :credit_card_id, :amount, :fees, :first_payment, :status)
  end#purchase_params

  def options_for_select

  end#options_for_select
end
