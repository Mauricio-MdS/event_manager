require 'csv'

DAYS_WEEK = %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday].freeze

# transform 2 digits year format to 4 digits format
def clean_year(string_date)
  date_array = string_date.split('/')
  date_array[2] = '20'.concat(date_array.last) if date_array.last.length == 2
  date_array.join('/')
end

# return a hash with the number of registers by day of week
def get_registers_by_day_week(contents)
  register_day_week = Hash.new(0)

  contents.each do |row|
    string_date = clean_year(row[:regdate].split.first)
    day_week = DAYS_WEEK[Date.strptime(string_date, '%m/%d/%Y').wday]
    register_day_week[day_week] += 1
  end
  register_day_week
end

# show days of week sorted by number of registers
def show_day_week_by_registers(day_week)
  day_week.values.max.downto(1) do |count|
    selected_days = day_week.select { |_, v| v == count }
    puts "Days with #{count} registers: #{selected_days.keys.sort.join(', ')}" unless selected_days.empty?
  end
end

puts 'Day of week Targetting'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

register_day_week = get_registers_by_day_week(contents)
show_day_week_by_registers(register_day_week)
