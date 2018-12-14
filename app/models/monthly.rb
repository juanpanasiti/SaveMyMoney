class Monthly < ApplicationRecord
  belongs_to :user
  belongs_to :credit_card, optional: true
  has_many :payments, as: :payable

  ################## METHODS
  def get_name
    return self.name
  end#get_name

  def get_amount
    return self.amount
  end#get_amount

  def get_pay_method
    if self.credit_card.present?
      return self.credit_card.get_name
    else
      return "Efectivo"
    end
  end
end
