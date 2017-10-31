# A Partner can be either a Driver or an Owner

class Partner < ActiveRecord::Base
  # Relationships
  has_many :driver_insurances, foreign_key: "driver_id"
  has_many :owned_vehicles, class_name: "Vehicle", foreign_key: "owner_id"

  # Instance methods
  def total_insurance_days
    driver_insurances.map(&:days).reduce(:+)
  end

  def total_insurance_price
    driver_insurances.map(&:policy_price).reduce(:+)
  end
end
