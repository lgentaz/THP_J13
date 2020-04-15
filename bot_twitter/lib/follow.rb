#    client.search("#bonjour_monde", result_type: "recent").take(30).map do |tweet|
require 'twitter'
require 'pry'

require 'dotenv'# Appelle la gem Dotenv

Dotenv.load('.env') # Ceci appelle le fichier .env (situé dans le même dossier que celui d'où tu exécute app.rb)
# et grâce à la gem Dotenv, on importe toutes les données enregistrées dans un hash ENV

def login_twitter
	client = Twitter::REST::Client.new do |config|
	  config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
	  config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
	  config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
	  config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
	end
	return client
end

def follow_hello(client)
	list = []
	while list.length < 20
		client.search('#bonjour_monde', result_type: "recent").take(100).each do |tweet|
	        list << tweet.user.id
	    end
	end
    list.uniq.slice(0..20).each do |user|
		client.follow(user)
	end
end

follow_hello(login_twitter)