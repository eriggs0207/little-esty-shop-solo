require 'rails_helper'

RSpec.describe Holiday do
  it 'does exist' do
    holiday_1 = Holiday.new(name: "Festivus", date: "December 25th, 2022")
    expect(holiday_1).to be_instance_of(Holiday)
    expect(holiday_1.name).to eq("Festivus")
    expect(holiday_1.date).to eq("December 25th, 2022")
  end
end
