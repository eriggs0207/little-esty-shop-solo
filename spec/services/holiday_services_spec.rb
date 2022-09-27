require 'rails_helper'

RSpec.describe HolidayService do
  it 'can get all holidays' do
    allow(HolidayService).to receive(:get_holidays).and_return([{name: "Thanksgiving"}])
    holidays = HolidayService.get_holidays
    expect(holidays).to be_an(Array)
    expect(holidays[0]).to be_an(Hash)
    expect(holidays[0]).to have_key(:name)
  end
end
