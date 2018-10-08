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
end
