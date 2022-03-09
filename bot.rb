require 'uri'
require 'net/http'
require 'twitter'
require 'dotenv'

Dotenv.load

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['CONSUMER_KEY']
  config.consumer_secret     = ENV['CONSUMER_SECRET']
  config.access_token        = ENV['ACCESS_TOKEN']
  config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
end

# qiita api
uri = URI('https://qiita.com/api/v2/items')
res = Net::HTTP.get(uri)

index = rand(20)
json = JSON.parse(res)
title = json[index]["title"]
url = json[index]["url"]
hashTag = "#Qiita"
client.update("#{title}\n#{url}\n#{hashTag}")