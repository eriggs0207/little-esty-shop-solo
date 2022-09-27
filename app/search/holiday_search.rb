class HolidaySearch
  def self.holidays
    holiday_data ||= HolidayService.get_holidays
    holiday_data[0..2].map do |holiday|
      Holiday.new(holiday)
    end
  end
end
