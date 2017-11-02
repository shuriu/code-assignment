# Vehicle owner insurance is issued to vehicle owners, but they only pay for all days the vehicle is NOT on rent by drivers.
# This is to cover periods the vehicle is waiting to be rented and sitting in the parking lot.
# Vehicle insurance pricing includes the end date (unlike driver insurance)
# eg. a vehicle insurance from 1st Oct to 8th Oct is 8 days of cover, at a rate of £1, gives a total of £8
# if the vehicle is rented from 2nd Oct to 5th Oct then the owner pays for 3 less days, giving a total of £5

class VehicleOwnerInsurance < ActiveRecord::Base
  # Relationships
  belongs_to :vehicle
  has_many :driver_insurances, through: :vehicle

  # Scopes
  scope :active_on_date, -> (date) { where(":date BETWEEN start_date AND end_date", date: date) }

  # Instance methods
  def as_range
    (start_date..end_date)
  end

  def total_days_covered
    (end_date - start_date).to_i + 1
  end

  def total_days_charged_for
    covered_dates.size
  end

  def covered_dates
    dates = as_range.to_a

    driver_insurances.each do |driver_insurance|
      dates -= driver_insurance.as_range.to_a
    end

    dates
  end

  def vehicle_daily_rate
    vehicle.vehicle_owner_insurance_daily_rate_pounds
  end

  def total_charge_pounds
    total_days_charged_for * vehicle_daily_rate
  end
end
