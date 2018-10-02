class Tax < ApplicationRecord
  belongs_to :user
  has_many :payments, as: :payable
end
