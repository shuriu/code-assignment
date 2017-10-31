require 'rails_helper'

RSpec.describe Partner, type: :model do
  it "calculates the number of days to charge for all the insurance policies of a driver" do
    driver = Partner.create(name: "Danny Driver")

    driver.driver_insurances.create(start_date: Date.today, end_date: Date.today + 1.week)
    driver.driver_insurances.create(start_date: Date.today - 3.weeks, end_date: Date.today - 1.week)

    expect(driver.days_for_all_insurance_policies).to eq 21
  end

  it "calculates the price for all the insurance for one driver"
end
