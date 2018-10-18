class Tax < ApplicationRecord
  ####### RELATIONS
  belongs_to :user
  has_many :payments, as: :payable

  ####### CLASS METHODS
  def self.get_services
    return ["Agua","Gas","Luz","Obra Social","Otro Servicio"]
  end
end
