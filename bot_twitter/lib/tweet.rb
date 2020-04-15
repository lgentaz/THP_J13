require 'twitter'
require 'pry'

require 'dotenv'# Appelle la gem Dotenv

Dotenv.load('.env') # Ceci appelle le fichier .env (situé dans le même dossier que celui d'où tu exécute app.rb)
# et grâce à la gem Dotenv, on importe toutes les données enregistrées dans un hash ENV

# quelques lignes qui appellent les clés d'API de ton fichier .env
#client = Twitter::REST::Client.new do |config|
#  config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
#  config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
#  config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
#  config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
#end

def login_twitter
	client = Twitter::REST::Client.new do |config|
	  config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
	  config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
	  config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
	  config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
	end
	return client
end

def selection
	twittos = ["@lulgentaz", "@paulinegentaz", "@nilujebubu", "@MaryMacOil", "@emiliehistoire", "@Rodrigue_Diaz", "@Dju_JP"]
	selection = []
	while (selection.length < 3) do
		who_num = rand(0..6)
		selection << twittos[who_num] unless selection.include? twittos[who_num]
	end
	return selection
end

def sending(arr)
	blague = " C'est l'histoire du Schtroumpf qui tombe et qui se fait un bleu @the_hacking_pro #bonjour_monde"
	arr.map! do |l|
		my_tweet = l + blague
		login_twitter.update(my_tweet)
	end
end

#sending(selection)

