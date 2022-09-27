require 'httparty'
require 'json'

class HolidayService

  def self.get_holidays
    get_uri('https://date.nager.at/api/v3/NextPublicHolidays/US')
  end

  def self.get_uri(uri)
    data = HTTParty.get(uri)
    parsed = JSON.parse(data.body, symbolize_names: true)
  end
end
