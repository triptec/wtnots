require 'rubygems'
require 'earworm'

MUSICDNS_KEY = ["0736ac2cd889ef77f26f6b5e3fb8a09c", #picard key 
								#"57aae6071e74345f69143baa210bda87", #anonymous key dosen't work
								"e4230822bede81ef71cde723db743e27",	#anonymous key
								"a7f6063296c0f1c9b75c7f511861b89b"]	#libofa example key 

MUSICDNS_KEY.each do |key|
	ew = Earworm::Client.new(key)
	info = ew.identify(:file => '1.mp3')
	puts "#{info.artist_name} - #{info.title}"
end
