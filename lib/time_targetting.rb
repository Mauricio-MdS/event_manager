require 'csv'

# extract after space and before :
def extract_hour(date_and_time)
  date_and_time.split.last.split(':').first
end

# extract all hours of register and the sum of registers
def get_all_hours(contents)
  register_hours = Hash.new(0)

  contents.each do |row|
    hour = extract_hour(row[:regdate])
    register_hours[hour] += 1
  end
  register_hours
end

# show hours sorted by number of registers
def show_hours_by_registers(hours)
  hours.values.max.downto(1) do |count|
    selected_hours = hours.select { |_, v| v == count }
    puts "Hours with #{count} registers: #{selected_hours.keys.sort.join(', ')}"
  end
end

puts 'Time Targetting'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

register_hours = get_all_hours(contents)

show_hours_by_registers(register_hours)
