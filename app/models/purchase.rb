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
    return self.credit_card.get_name
  end#get_pay_method
  def get_amount
    return "$ #{self.amount.round(2)}"
  end#get_amount
  def get_fees
    return self.fees
  end#get_fees
  def get_first_payment_date
    return self.first_payment
  end#get_first_payment_date
  def get_status
    return self.status
  end#get_status

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
