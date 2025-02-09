class Address < ApplicationRecord
  belongs_to :person

  validates :street, :city, :state, :country, :landmark, :postal_code, presence: true
end
