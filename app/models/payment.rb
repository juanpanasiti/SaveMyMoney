class Payment < ApplicationRecord
  belongs_to :payable, polymorphic: true
  belongs_to :user

  ############## SCOPES
  scope :to_pay, -> { where(status: "Para pagar") }
  scope :paied, -> { where(status: "Pagado") }
  scope :from_purchase, -> { where(payable_type: :Purchase) }
  scope :from_tax, -> { where(payable_type: :Tax) }
  scope :from_monthly, -> { where(payable_type: :Monthly) }
  def self.current_month(user)
    date = Date.today
    start_date = date.at_beginning_of_month
    end_date = date.at_end_of_month
    return user.payments.where(:expiration => start_date..end_date)
  end

  def self.next_month(user)
    date = Date.today.advance(months: 1)
    start_date = date.at_beginning_of_month
    end_date = date.at_end_of_month
    return user.payments.where(:expiration => start_date..end_date)
  end

  def self.future_months(user)
    date = Date.today.advance(months: 2)
    start_date = date.at_beginning_of_month
    return user.payments.where("expiration >= ?", start_date)
  end

  def self.past_months(user)
    date = Date.today
    start_date = date.at_beginning_of_month
    return user.payments.where("expiration < ?", start_date).where(status: "Para pagar")
  end
  ############## METHODS
  def pay
    self.status = "Pagado"
    if self.save
      return true
    else
      return false
    end
  end #pay
  def unpay
    self.status = "Para pagar"
    if self.save
      return true
    else
      return false
    end
  end #unpay

  def get_detail
    if self.payable_type == "Purchase"
      return self.payable.get_item_name
    elsif self.payable_type == "Monthly"
      return self.payable.get_name
    elsif self.payable_type == "Tax"
      return self.payable.get_tax_name
    else
      return "Es de origen desconocido"
    end#if/elsif/else
  end#get_detail

  def get_pay_method
    if self.payable_type == "Purchase"
      return self.payable.get_pay_method
    elsif self.payable_type == "Monthly"
      return self.payable.get_pay_method
    elsif self.payable_type == "Tax"
      return "Efectivo"
    else
      return "S/D"
    end#if/elsif/else
  end#get_pay_method

  def get_fee
    if self.payable_type == "Purchase"
      if self.payable.fees == 1
        return "Único pago"
      else
        return "#{self.fee} de #{self.payable.get_fees}"
      end
    elsif self.payable_type == "Monthly"
      thisPayments = Payment.where(payable_type: :Monthly).where(payable_id: self.payable_id)
      fees = thisPayments.count
      fee = thisPayments.where("expiration >= ?", self.expiration).count
      return "#{fee}/#{fees}"
    elsif self.payable_type == "Tax"
      return "Efectivo"
    else
      return "S/D"
    end#if/elsif/else
  end#get_detail

  def get_expiration
    if self.payable_type == "Purchase"
      return self.expiration.strftime("%b-%y")
    elsif self.payable_type == "Monthly"
      return self.expiration.strftime("%d-%b-%y")
    elsif self.payable_type == "Tax"
      return self.expiration.strftime("%d-%b-%y")
    else
      return "S/D"
    end#if/elsif/else
  end
  ############ CLASS METHODS
end#class Payment
