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

def getStrings(url)
  begin
    uri = URI(url)
    responce = Net::HTTP.get(uri)

    # Qiita
    if url.include?("qiita")
      index = rand(20)
      json = JSON.parse(responce)
      article = json[index]
      title = article["title"]
      url = article["url"]
      tags = article["tags"]
      hashTags = "#Qiita\n"

      tags.each do |tag|
        hashTags << "#" + tag["name"] + "\n"
      end

      return "#{title}\n#{url}\n#{hashTags}"

    # Devto
    elsif url.include?("dev.to")
      index = rand(30)
      json = JSON.parse(responce)
      article = json[index]
      title = article["title"]
      url = article["url"]
      tags = article["tags"].split(", ")
      hashTags = "#DEVCommunity\n"

      tags.each do |tag|
        hashTags << "#" + tag + "\n"
      end

      return "#{title}\n#{url}\n#{hashTags}"
    end

  rescue
    puts "Failed"
  end
end

client.update(getStrings("https://qiita.com/api/v2/items"))
client.update(getStrings("https://dev.to/api/articles/latest"))
