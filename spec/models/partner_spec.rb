require 'rails_helper'

RSpec.describe Partner, type: :model do
  it "calculates the number of days to charge for all the insurance policies of a driver" do
    driver = Partner.create(name: "Danny Driver")

    driver.driver_insurances.create(start_date: Date.today, end_date: Date.today + 1.week)
    driver.driver_insurances.create(start_date: Date.today - 3.weeks, end_date: Date.today - 1.week)

    expect(driver.total_insurance_days).to eq 21
  end

  it "calculates the price for all the insurance for one driver" do
    driver = Partner.create(name: "Danny Driver")

    vehicle1 = Vehicle.create(driver_insurance_daily_rate_pounds: 17.50)
    vehicle2 = Vehicle.create(driver_insurance_daily_rate_pounds: 88.99)

    driver.driver_insurances.create(start_date: Date.today, end_date: Date.today + 1.week, vehicle: vehicle1)
    driver.driver_insurances.create(start_date: Date.today - 3.weeks, end_date: Date.today - 1.week, vehicle: vehicle2)

    expect(driver.total_insurance_price).to eq (7 * 17.50 + 14 * 88.99)
  end
end
