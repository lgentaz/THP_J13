#    client.search("#bonjour_monde", result_type: "recent").take(30).map do |tweet|
require 'twitter'
require 'pry'

require 'dotenv'# Appelle la gem Dotenv

Dotenv.load('.env') # Ceci appelle le fichier .env (situé dans le même dossier que celui d'où tu exécute app.rb)
# et grâce à la gem Dotenv, on importe toutes les données enregistrées dans un hash ENV

def streaming_twitter
	client = Twitter::Streaming::Client.new do |config|
	  config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
	  config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
	  config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
	  config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
	end
	return client
end

def login_twitter
	client = Twitter::REST::Client.new do |config|
	  config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
	  config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
	  config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
	  config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
	end
	return client
end


def like_follow(s_client,l_client)
	s_client.filter(track: "#bonjour_monde") do |tweet|
		if tweet.is_a?(Twitter::Tweet)
			puts tweet.text 
			l_client.favorite(tweet)
			l_client.follow(tweet.user.id)
		end
	end
end

like_follow(streaming_twitter, login_twitter)