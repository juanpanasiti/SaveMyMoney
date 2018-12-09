class Payment < ApplicationRecord
  belongs_to :payable, polymorphic: true
  belongs_to :user

  ############## SCOPES
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
  def get_detail
    if self.payable_type == "Purchase"
      return self.payable.get_item_name
    elsif self.payable_type == "Monthly"
      return "Es un pago mensual"
    elsif self.payable_type == "Tax"
      return "Es un impuesto"
    else
      return "Es de origen desconocido"
    end#if/elsif/else
  end#get_detail

  def get_pay_method
    if self.payable_type == "Purchase"
      return self.payable.get_pay_method
    elsif self.payable_type == "Monthly"
      return "$$"
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
      return "$$"
    elsif self.payable_type == "Tax"
      return "Efectivo"
    else
      return "S/D"
    end#if/elsif/else
  end#get_detail

  ############ CLASS METHODS
end#class Payment
