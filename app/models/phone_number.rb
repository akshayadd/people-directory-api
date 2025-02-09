class PhoneNumber < ApplicationRecord
  belongs_to :person

  validates :mobile_number, presence: true
end
