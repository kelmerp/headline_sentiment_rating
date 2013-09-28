require 'wayback'
# require 'open-uri'
require 'nokogiri'
require_relative "black_list_helper.rb"



# hash = Wayback.list('http://www.msnbc.com')
# p hash
# url = hash.attrs[:dates].to_a.reverse.first[1][:uri]

@first_time = true
@check_array = []
@black_list = []

def parse_page(raw_html)
  page = Nokogiri::HTML(raw_html)

  @cleaned_headlines =[]

  # check_tags(page)

  parse (page.css("h1 a"))
  parse (page.css("h2 a"))
  parse (page.css("h3 a"))
  parse (page.css("h4 a"))
  parse (page.css("a"))
  # parse (page.css("h2 a"))
  find_dups()
  # puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  # p @black_list
  # puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

  @cleaned_headlines


end


def parse(a_tags)
  # h_one = page.css("h1 a")
  # nokogiri_a
  return if a_tags.length <= 0

  span_tags = a_tags.css("span")
  if !(span_tags.empty?)
    clean_data(span_tags)
  end
  clean_data(a_tags)

  @cleaned_headlines if @cleaned_headlines.length > 0


  # p array_text = grab_text(nokogiri_a)
end

def clean_data(tags)
  array = []
  tags.each do |tag|
    cleaned_tag = tag.text.gsub("\n"," ").strip
    next if cleaned_tag.length < 15
    next if @black_list.include?(cleaned_tag)
    next if cleaned_tag.include?("AP Photo")
    return array if @cleaned_headlines.length >= 20
    @cleaned_headlines << cleaned_tag
  end
  # array
end


def find_dups()
  # if @first_time
    # @check_array << @cleaned_headlines.each {|headline| @check_array << headline}
    # @first_time = false
    # p check_array
  # else
    dups = @check_array & @cleaned_headlines
    @cleaned_headlines.each {|headline| @check_array << headline}
    # @check_array.uniq!
    add_to_black_list(dups)
    dups.each { |headline| @black_list << headline } unless !dups
    dups.each {|headline| @check_array.delete(headline)}
    # p check_array
    # p cleaned_headlines
  
    # p dups
end








# @black_list = 
# [""," ", "LIVE TV","CNN TV", "HLN TV", "Markets", "My quotes", "Indexes", "Dow", "Nasdaq", "S&P", "Get Quotes", "CNNMoney.com", "NEW: My Portfolio", "U.S.", "World", "Politics", "Tech", "Business", "Entertainment", "Travel", "Living", "Health", "Photography", "Sports", "HLNtv.com", "TIME.com", "Indeed.com Job Search", "Play CNN Games!", "TV & Video", "HLN", "Full Schedule", " The Lead4pm ET / 1pm PT on CNN", "The Situation Room5pm ET / 2pm PT on CNN", " Erin Burnett: OutFront7pm ET / 4pm PT on CNN",
# " AC 3608pm ET / 5pm PT on CNN", " Piers Morgan Live9pm ET / PT on CNN","View Collections","Home","Video","CNN Trends",
# "U.S.",
# "World",
# "Politics",
# "Justice",
# "Entertainment",
# "Tech",
# "Health",
# "Living",
# "Travel",
# "Opinion",
# "iReport",
# "Money",
# "Sports",
# "Tools & widgets",
# "RSS",
# "Podcasts",
# "Blogs",
# "CNN mobile",
# "My profile",
# "E-mail alerts",
# "CNN shop",
# "Site map",
# "Contact us",
# # "CNN en ESPAÑOL",
# # "CNN México",
# "CNN Chile",
# # "CNN Expansión",
# # "العربية",
# # "日本語",
# # "Türkçe",
# "Bleacher Report",
# "CNN TV",
# "HLN",
# "Transcripts",
# "Turner Broadcasting System, Inc.","Terms of service","Privacy guidelines","Ad choices","Advertise with us","About us","Work for us","Help","CNN Newsource","License Footage", "Go", "Weather", "FULL STORY", "FULL STORY ", "TV", "Sign up", "Log in"]

#grab all a's in H1
  #check for spans via check_span method
    #grab text if text found
    #run through blacklist method
  #else
    #grab text
    #run through blacklist method
  #save to headline array

#grab all a's in H2
  #check for spans via check_span method
    #grab text if text found
    #run through blacklist method
  #else
    #grab text
    #run through blacklist method
  #save to headline array

#grab all a's in H3
  #check for spans via check_span method
    #grab text if text found
    #run through blacklist method
  #else
    #grab text
    #run through blacklist method
  #save to headline array




  # a_texts = page.css("h1 a")

  # a_texts.each do |headline|
  #   p headline.text
  # end










# page = Nokogiri::HTML(File.open('page.html'))


# all_texts = page.css("a")

# all_texts.each do |a|
#   p a.text unless black_list.include?(a.text)
# end



# hash.attrs[:dates].last do |url|
  # p open(url[1][:uri]).read
  # exit
# end
#
