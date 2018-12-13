class Tax < ApplicationRecord
  ####### RELATIONS
  belongs_to :user
  has_many :payments, as: :payable

  ####### METHODS
  def get_tax_name
    return "#{self.name} (#{self.service})"
  end
  ####### CLASS METHODS
  def self.get_services
    return ["Agua","Gas","Luz","Obra Social","Otro Servicio"]
  end

end
