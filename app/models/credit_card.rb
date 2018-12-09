class CreditCard < ApplicationRecord
  belongs_to :user
  has_many :purchases
  # Atributos: user, issuer, kind, expiration
  ####### METHODS
  def get_kind
    kind = self.kind.blank? ? '' : self.kind
    return kind
  end
  def get_issuer
    issuer = self.issuer.blank? ?  '' : self.issuer
    return issuer
  end
  def get_user_name
    user = self.user.blank? ? '' : self.user.email
    return user
  end
  def get_expiration
    expiration = self.expiration.blank? ? '' : self.expiration
    return expiration
  end
  def get_name
    return "#{self.issuer} (#{self.kind})"
  end
  def get_balance
    balance = 0
    
    return "$####,##"
  end
  ####### CLASS METHODS
  def self.get_kind_options
    return ['VISA','MastrerCard','Otra']
  end
  def self.get_for_form
    options = []
    CreditCard.all.each do |cc|
      options << [cc.get_name,cc.id]
    end
    return options
  end
end
