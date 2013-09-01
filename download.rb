def downloadMethod1(host, path, target)
  require 'net/http'
  
  Net::HTTP.start(host) do |http|
   resp = http.get(path)
   open(target, "wb") do |file|
     file.write(resp.body)
   end
  end
  puts("Done.")
end

#downloadMethod1("static.scripting.com", "/google/webFontNames.txt", "fontList2.txt")

def downloadMethod2(uri, target)
  require 'open-uri'
  
  open(target, "wb") do |file|
    file << open(uri).read
  end
  puts("Done.")
end

#downloadMethod2("http://www.google.com/images/srpr/logo4w.png", "google.png")
