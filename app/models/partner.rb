# A Partner can be either a Driver or an Owner

class Partner < ActiveRecord::Base
  # Relationships
  has_many :driver_insurances, foreign_key: "driver_id"
  has_many :owned_vehicles, class_name: "Vehicle", foreign_key: "owner_id"
  has_many :vehicle_owner_insurances, through: :owned_vehicles

  # Instance methods
  def total_insurance_days
    driver_insurances.map(&:days).sum
  end

  def total_insurance_price
    driver_insurances.map(&:policy_price).sum
  end

  def total_vehicle_owner_insurance_v2_charges_pounds
    vehicle_owner_insurances.flat_map do |owner_insurance|
      owner_insurance.covered_dates.map do |date|
        owner_insurance.vehicle_daily_rate * vehicle_insurance_premium(date)
      end
    end.sum
  end

  def vehicle_insurance_premium(date)
    return 1.1 if active_vehicle_insurances_count(date) >= 3
    return 1.0
  end

  def active_vehicle_insurances_count(date)
    vehicle_owner_insurances.active_on_date(date).count
  end
end
