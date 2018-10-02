class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :credit_card
  has_many :payments, as: :payable
end
