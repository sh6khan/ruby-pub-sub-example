#!/usr/bin/env ruby
# encoding: utf-8

require "rubygems"
require "bunny"

#same starting points
connection = Bunny.new
connection.start

channel = connection.create_channel

#you may notice that "movies" is never refrenced again 
#however, if you have multple topics, then it becomes usefull
exchange = channel.topic("movies", :auto_delete => true)


#notice the lack of the titles for the queues
#when setting the routing_keys for bindings the # are the same as wild cards in a regex
thriller_queue = channel.queue("", :exclusive => true).bind(exchange, :routing_key => "#.thrillers.#")
comedy_queue = channel.queue("", :exclusive => true).bind(exchange, :routing_key => "#.comedy.#")
adventure_queue = channel.queue("", :exclusive => true).bind(exchange, :routing_key => "#.adventure.#")


thriller_queue.subscribe do |info, metadata, payload|
	puts "from thirllers #{payload}, routing handled by #{info.routing_key}"
end

comedy_queue.subscribe do |info, metadata, payload|
	puts "from comedies #{payload}, routing handled by #{info.routing_key}"
end 

adventure_queue.subscribe do |info, metadata, payload|
	puts "from adventure #{payload} routing handled by #{info.routing_key}"
end


exchange.publish("Gone Girl", :routing_key => ".thrillers.")
exchange.publish("Planes Trains and Automobiles", :routing_key => ".comedy.adventure.")
exchange.publish("Fargo", :routing_key => ".thirllers.adventure.comedy")
exchange.publish("Shrek", :routing_key => ".comedy.")
#none of our queues are bindind to the exchange with the routing key tv_shows
exchange.publish("Breaking Bad", :routing_key => ".tv_shows.") 

sleep 1.0

connection.close
