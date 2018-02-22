class Weather < ApplicationRecord
  validates_format_of :city, :with => /[a-zA-Z]/
end
