class Purchase < ApplicationRecord
  ####### ASOCIACIONES
  belongs_to :user
  belongs_to :credit_card, optional: true
  has_many :payments, as: :payable
  # Atributos: user_id, name, credit_card_id, amount, fees, first_payment, status
  ####### VALIDACIONES
  ####### METODOS
  def get_user
    return self.user.email
  end#get_user
  def get_item_name
    return self.name.titleize
  end#get_user_name
  def get_pay_method
    if self.credit_card.present?
      return self.credit_card.get_name
    else
      return "Efectivo"
    end
  end#get_pay_method
  def get_amount
    return self.amount
  end#get_amount
  def get_fees
    return self.fees
  end#get_fees
  def get_first_payment_date
    return self.first_payment.strftime("%b-%y")
  end#get_first_payment_date
  def get_last_payment_date
    return self.first_payment.advance(months: (self.fees - 1)).strftime("%b-%y")
  end#get_last_payment_date
  def get_status
    paied_fees = self.payments.paied.count
    if paied_fees == 0
      return "Para pagar"
    elsif paied_fees == self.fees
      return "Pagado"
    else
      return "#{(paied_fees.to_f/self.fees.to_f*100).round(1)}% pagado"
    end#if/elsif
  end#get_status
  def get_remaining_balance
    paied = 0
    self.payments.paied.each do |payment|
      paied = paied + payment.amount
    end#each_do
    return self.get_amount - paied
  end#get_remaining_balance

  def generate_payments
    remaining_amount = self.amount
    remaining_fees = self.fees
    saved = true
    for i in 1..self.get_fees
      new_payment = self.payments.new
      #new_payment.payable_type = "purchase"
      #new_payment.payable_id = self.id
      new_payment.user_id = self.user_id
      new_payment.fee = i
      new_payment.expiration = self.first_payment.advance(months: (i-1)).end_of_month
      new_payment.amount = (remaining_amount/remaining_fees).round(2)
      remaining_amount = remaining_amount - new_payment.amount
      remaining_fees = remaining_fees - 1
      new_payment.status = "Para pagar"
      unless new_payment.save!
        saved = true && saved
      end
    end#for
  end#generate_payments
end#Purchase
