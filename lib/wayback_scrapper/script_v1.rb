require 'csv'
require 'wayback'
require 'open-uri'
require 'pp'
require_relative "hash.rb"
require_relative "noko_it_up.rb"

open_black_list()



#####################
# THIS IS WHERE YOU PUT THE URL YOU WANT TO SCRAPE
@url = "http://nytimes.com"
#######################

# This grabs all the urls wayback machine has for the url
p list = Wayback.list(@url)

# This creates an array from the parse list
list_array = list.attrs[:dates].to_a.reverse


#This is the counter being set for how many days you want to attemp to scrape
i = 1400



def write_csv(timestamp, one_scrape, headlines)
  archive_url = one_scrape.last[:uri]

  headlines.each do |headline|
    CSV.open('nytimes_headlines/headline.csv', "ab") do |csv|
      csv << [@url, archive_url, timestamp, headline.gsub("\n"," ").strip]
    end
  end

end

# Groups list by days
new_hash = list_array.group_by{ |k,v| k.to_s[0,8] }
# new_hash = new_hash.delete_if { |k| k.to_i >= 20110814 }

#iterates through list and grabs one homepage per day
new_hash.to_a.each do |internal_array|

  return false if i == 0
  i -= 1

  p "#{i} days remaining to attempt to scrape"
  # p internal_array
  p internal_array.last.first.last[:datetime]
  scrapes_in_one_day ||= internal_array.last
  one_scrape = scrapes_in_one_day.shift

  begin
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

  #comment out this line if you want to test the scrapper without writing to a csv
  write_csv(timestamp, one_scrape, headlines)

  sleep 0.5
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