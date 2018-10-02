class CreditCard < ApplicationRecord
  belongs_to :user
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
  ####### CLASS METHODS
  def self.get_kind_options
    return ['VISA','MastrerCard','Otra']
  end
end
