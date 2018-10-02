class CreditCardsController < ApplicationController
  before_action :set_credit_card, only: [:edit, :update, :destroy]
  before_action :options_for_select, only: [:new, :create, :edit, :update]
  def index
    @le_titule = "Tarjetas de Crédito"
    @credit_cards = current_user.credit_cards
  end#index

  def new
    @credit_card = CreditCard.new
  end#new
  def create
    @credit_card = current_user.credit_cards.new(credit_card_params)
    respond_to do |format|
      if @credit_card.save
        format.html { redirect_to credit_cards_path, notice: 'Tarjeta de Crédito agregada.' }
      else
        format.html { render :new }
      end#if/else
    end#respond_to
  end#create

  def edit
    #code
  end#edit
  def update
    respond_to do |format|
      if @credit_card.update(credit_card_params)
        format.html { redirect_to credit_cards_path, notice: 'Datos de la tarjeta actualizados.' }
      else
        format.html { render :edit }
      end#if/else
    end#respond_to
  end#update

  def destroy
    @credit_card.destroy
    respond_to do |format|
      format.html { redirect_to credit_cards_path, alert: 'Tarjeta eliminada.' }
    end
  end#destroy

  protected
  def set_credit_card
    @credit_card = CreditCard.find(params[:id])
  end#set_credit_card

  def credit_card_params
    params.require(:credit_card).permit(:user_id, :issuer, :kind, :expiration)
  end#credit_card_params

  def options_for_select
    @kind_options = CreditCard.get_kind_options
  end#options_for_select
end#Controller
