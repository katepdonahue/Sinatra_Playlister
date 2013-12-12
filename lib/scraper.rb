# require 'debugger'
# require "open-uri"
# # require "rexml/document"
# require "nokogiri"


# class Video_Scraper
#   attr_reader :html

#   def initialize(artist, song)
#     debugger
#     url = "https://gdata.youtube.com/feeds/api/videos?q=#{artist}+#{song}"
#     @html = Nokogiri::HTML(open(url))
#     debugger
#     puts 'hi'
#   end

#   def video
#     debugger
#     @html.xpath("//content")[1].attributes["url"].value
#   end
# end 

# my_scraper = Video_Scraper.new("azelia%20banks", "212")

# url = my_scraper.video

# "https://gdata.youtube.com/feeds/api/videos?q="


require "open-uri"

class Video_Scraper
  attr_reader :html

  def initialize(artist, song)
    url = "https://gdata.youtube.com/feeds/api/videos?q=#{artist}+#{song}"
    @html = Nokogiri::HTML(open(url))
  end

  def video
    @html.xpath("//content")[1].attributes["url"].value
  end
end 

# "https://gdata.youtube.com/feeds/api/videos?q="