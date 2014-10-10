require 'rubygems'
require 'oauth'
require 'json'

# Now you will fetch /1.1/statuses/user_timeline.json,
# returns a list of public Tweets from the specified
# account.
baseurl = "https://api.twitter.com"
path    = "/1.1/statuses/user_timeline.json"
query   = URI.encode_www_form(
    "screen_name" => "duyqtran",
    "count" => 50,
)
address = URI("#{baseurl}#{path}?#{query}")
request = Net::HTTP::Get.new address.request_uri

# Print data about a list of Tweets
def print_timeline(tweets)
  # ADD CODE TO ITERATE THROUGH EACH TWEET AND PRINT ITS TEXT
    count = 0
    content = JSON.pretty_generate(tweets)
    File.write('core/data/timeline.json', content)

    tweets.each do |tweet|
    	count += 1
    	puts "#{count.to_i} - #{tweet["created_at"]} - #{tweet["text"]}."
    end
end

# Set up HTTP.
http             = Net::HTTP.new address.host, address.port
http.use_ssl     = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER

# If you entered your credentials in the first
# exercise, no need to enter them again here. The
# ||= operator will only assign these values if
# they are not already set.
consumer_key ||= OAuth::Consumer.new "u9X8EKJQZxzfv3ou5qmZiyVqa", "9xv9OKt6XVDOxOh7McJwW4dJJGJriukk97rpj3BRTyieXxU51x"
access_token ||= OAuth::Token.new "106644406-Pwwnk4X76TCZ4SeRU6uZ2xTxd3C11riUrUEH92Vr", "1bjFLLglNdZfMXIys4SYfCa8rv6PccBHCZy7wjleZwb4L"

# Issue the request.
request.oauth! http, consumer_key, access_token
http.start
response = http.request request

# Parse and print the Tweet if the response code was 200
tweets = nil
if response.code == '200' then
  tweets = JSON.parse(response.body)
  print_timeline(tweets)
end
nil
