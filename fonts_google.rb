require 'restclient'

urls = "http://fonts.googleapis.com/css?family="

def getFontFamily(css_text)
  arr = css_text.split(';')
  token = 'font-family: '
  i = arr[0].index(token) + token.length + 1
  arr[0][i..-2]
end

def getFontUrl(css_text)
  arr = css_text.split(';')
  token1 = 'url('
  i = arr[3].index(token1) + token1.length
  token2 = ') format('
  j =  arr[3].length - arr[3].index(token2) + 1
  arr[3][i..-j]
end

def getFontExt(fontUrl)
  fs = fontUrl.split('.')
  fs[fs.length-1]
end

require_relative 'download'

c = 0
text = File.open("fontList.txt").read
text.gsub!(/\r\n?/, "\n")
text.each_line do |line|
  puts "#{c += 1} #{line}"
  fontParam = line.gsub(' ','+')
  begin
    body = RestClient.get("#{urls}#{fontParam}",
      :user_agent => "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.62 Safari/537.36")
    fontUrl = getFontUrl(body)
    target = getFontFamily(body).gsub(' ','_') +'.'+ getFontExt(fontUrl)
    downloadMethod2(fontUrl, "fonts/#{target}")
  rescue Exception
    puts "ERROR: #{line} is not available."
  end
end
