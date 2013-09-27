require 'csv'
require 'wayback'
require 'open-uri'
require 'pp'
require_relative "hash.rb"
require_relative "noko_it_up.rb"


@url = 'http://www.msnbc.com'
# Wayback.page(url, '20130820174405')
# Commented out wayback calls because we stored results
# In a seperate file
# hash = Wayback.list('http://www.cnn.com')
list = Wayback.list(@url)
list_array = list.attrs[:dates].to_a.reverse
# hash = Wayback.list('http://www.msnbc.com')

# Find dates of list_array and put them in reverse order
# list_array = wayback[:dates].to_a.reverse

i = 0


def write_csv(timestamp, internal_array, headlines)

  archive_url = internal_array.last.first.last[:uri]

  headlines.each do |headline|
    CSV.open('msnbc_headlines/headline.csv', "ab") do |csv|
      csv << [@url, archive_url, timestamp, headline]
    end
  end

end

# Groups list by days
new_hash = list_array.group_by{ |k,v| k.to_s[0,8] }
new_hash = new_hash.delete_if { |k| k.to_i >= 20120701 }


#iterates through list and grabs one homepage per day
new_hash.to_a.each do |internal_array|

  return false if i >= 365
  i += 1

  p i

  p internal_array.last.first.last[:datetime]
  timestamp = internal_array.last.first[0]
  begin
    page = Wayback.page(@url, timestamp)
    headlines = parse_page(page.html)
    p headlines
    puts "############################################################################"
  rescue
    p $!.message
    next
  end

  write_csv(timestamp, internal_array, headlines)

  sleep 0.5
end




#grab page
#############
# write_headlines(headlines)
#############
# p new_hash.to_a.first
# p new_hash.to_a.first.last
# p new_hash.to_a.last

# p timestamp = new_hash.to_a.first.last.first[0]
# p url = new_hash.to_a.last.last.first.last[:uri]



# # p page