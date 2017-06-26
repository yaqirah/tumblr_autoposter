require 'tumblr_client'
require 'fileutils'
require_relative 'echoes' #Blog specific methods for finding and tagging posts stored here.

#define variables
blog = "daily-koichi"
file_path_unused = "/mnt/c/Users/Yaqirah/Dropbox/Koichis/Unused/"
file_path_used = "/mnt/c/Users/Yaqirah/Dropbox/Koichis/Used/"
post_count = 1 #set how many times the bot should post
file = ""
tags = []

# Authenticate via OAuth
client = Tumblr::Client.new({  
    :consumer_key => ENV['CONSUMER_KEY'],
    :consumer_secret => ENV['CONSUMER_SECRET'],
    :oauth_token => ENV['OAUTH_TOKEN'],
    :oauth_token_secret => ENV['OAUTH_TOKEN_SECRET']
})

post_count.times do
	#get a random file from specified file path
	file = get_file(file, file_path_unused)

	tags = tag_post(file, tags)

	#create and send post
	client.photo(blog, {:data => [file_path_unused + file], tags: tags, state: "queue"})
	puts "Posted " + file + " to #{blog} successfully"

	#move file to used
	FileUtils.mv(file_path_unused + file, file_path_used + file)
end