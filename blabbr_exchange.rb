#!/usr/bin/env ruby
# encoding: utf-8

require "rubygems"
require "bunny"

#same starting points
connection = Bunny.new
connection.start

channel = connection.create_channel
#this is a new type of exchange called a fanout
#where default exchange did a 1 to 1 binding between pub and sub 
#fanout exchange is set up for a 1 to n relation
exchange = channel.fanout("name_of_fanout_exchange")


#same as the queues for the direct_exchange queues with the additional binding to the exchange
first_queue = channel.queue("queue_one", :auto_delete=> true).bind(exchange)
second_queue = channel.queue("queue_two", :auto_delete => true).bind(exchange)

first_queue.subscribe do |info, metadata, payload|
	puts "#{payload} for fist_queue"
end 

second_queue.subscribe do |info, metadata, payload|
	puts "#{payload} for second_queue"
end


#same as before, simply publish and any queue that if binded to exchange will reciecve these messages
exchange.publish("this is the first message")
		.publish("this is the second message")
		.publish("this is the third message")

#upon running, take a look at the order in which the messages appear
#play around with more messages and more queues see what happens

sleep 1.0

connection.close