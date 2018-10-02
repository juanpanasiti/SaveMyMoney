class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :payable, polymorphic: true
end
