require 'csv'

def clean_phone(phone)
  clean = phone.gsub(/[()-. A-Z]/, '')
  return clean if clean.length == 10
  return clean[1..] if clean.length == 11 && clean[0] == '1'

  'Invalid phone'
end

puts 'Clean phone number'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

contents.each do |row|
  name = row[:first_name]
  phone = clean_phone(row[:homephone])
  puts "name: #{name}, phone: #{phone}"
end
