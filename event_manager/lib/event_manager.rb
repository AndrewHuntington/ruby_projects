require "csv"
require "google/apis/civicinfo_v2"
require "erb"
require "date"


def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def clean_phone_number(phone_number)
  cleaned_number = phone_number.gsub(/\W/, '')

  if cleaned_number.length < 10 || (cleaned_number.length == 11 && cleaned_number[0] != '1')
    "invalid number"
  elsif cleaned_number.length == 11 && cleaned_number[0] == '1'
    "(#{cleaned_number[1..3]}) #{cleaned_number[4..6]}-#{cleaned_number[7..10]}"
  else
    "(#{cleaned_number[0..2]}) #{cleaned_number[3..5]}-#{cleaned_number[6..9]}"
  end
end

def clean_time(time)
  DateTime.strptime(time.gsub!(/[\s\/]/, ' ' => 'T', '/' => '-'),
    '%m-%d-%yT%H:%M').hour
end

def day_of_the_week(time)
  date = time[0..7].split("-")
  day_number = Date.new("20#{date[2]}".to_i,date[0].to_i,date[1].to_i).wday

  days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

  days[day_number]
end

def popular_times_registered(stats)
  hours_registered = {}

  stats.each do |x|
    if hours_registered[x[2]].nil?
      hours_registered[x[2]] = 1
    else
      hours_registered[x[2]] += 1
    end
  end

  puts "Most popular hours to register were:"
  hours_registered.to_a.sort_by { |el| el[1] }.reverse.each do |el|
    time = el[0] > 12 ? "#{el[0] - 12} PM" :  "#{el[0]} AM"
    puts "#{time}: #{el[1]}"
  end
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    legislators = civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    "You can find your representatives by visiting www.commoncause.org/take-action/find-elected-offcials"
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir("output") unless Dir.exists?("output")

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

puts "EventManager Initialized!"

contents = CSV.open("../event_attendees.csv",
                    headers: true,
                    header_converters: :symbol)

# template_letter = File.read "form_letter.erb"
# erb_template = ERB.new template_letter

# stats = []

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  # legislators = legislators_by_zipcode(zipcode)
  phone_number = clean_phone_number(row[:homephone])
  hour_registered = clean_time(row[:regdate])
  day = day_of_the_week(row[:regdate])
  # form_letter = erb_template.result(binding)
  #
  # save_thank_you_letter(id, form_letter)

  # DEBUG: This is used to check answers for the exercises
  # at the bottom of the project page:
  # https://www.theodinproject.com/courses/ruby-programming/lessons/event-manager

  # check for clean phone numbers, day of the week
  puts "#{name} #{phone_number} #{hour_registered} #{day}"

  # use to help calculate popular times to register
  # stats << [name, phone_number, hour_registered]
end

# popular_times_registered(stats)
