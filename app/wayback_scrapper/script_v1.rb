require 'csv'
require 'wayback'
require 'open-uri'
require 'pp'
require_relative "hash.rb"
require_relative "noko_it_up.rb"

open_black_list()
# add_to_black_list(@black_list)

# @url = 'http://news.bbc.co.uk'
@url = "http://www.cbsnews.com"
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



def write_csv(timestamp, one_scrape, headlines)
  archive_url = one_scrape.last[:uri]

  headlines.each do |headline|
    CSV.open('cbs_news_headlines/headline.csv', "ab") do |csv|
      csv << [@url, archive_url, timestamp, headline.gsub("\n"," ").strip]
    end
  end

end

# Groups list by days
new_hash = list_array.group_by{ |k,v| k.to_s[0,8] }
# new_hash = new_hash.delete_if { |k| k.to_i >= 20090418 }

#iterates through list and grabs one homepage per day
new_hash.to_a.each do |internal_array|

  return false if i >= 1460
  i += 1

  p i
  # p internal_array
  p internal_array.last.first.last[:datetime]
  scrapes_in_one_day ||= internal_array.last
  one_scrape = scrapes_in_one_day.shift

  begin
    sleep 1

    timestamp = one_scrape[0]
    page = Wayback.page(@url, timestamp)
    headlines = parse_page(page.html)
    raise "A page loaded but no headlines found" if headlines.empty?
    p headlines
    puts "############################################################################"
  rescue
    p $!.message
    next if scrapes_in_one_day.empty?
    one_scrape = scrapes_in_one_day.shift
    retry
  end
  write_csv(timestamp, one_scrape, headlines)

end

# open_black_list()
# add_to_black_list(@black_list)



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