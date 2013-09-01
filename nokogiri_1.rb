require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(open('http://ruby.bastardsbook.com/files/hello-webpage.html'))
news = page.css('li').css('a').each do |link|
  puts link['href']
end