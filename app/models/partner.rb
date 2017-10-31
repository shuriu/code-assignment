# A Partner can be either a Driver or an Owner

class Partner < ActiveRecord::Base
  # Relationships
  has_many :driver_insurances, foreign_key: "driver_id"
  has_many :owned_vehicles, class_name: "Vehicle", foreign_key: "owner_id"

  # Instance methods
  def days_for_all_insurance_policies
    driver_insurances.map(&:days).reduce(:+)
  end

  def total_vehicle_owner_insurance_v2_charges_pounds
  end
end
