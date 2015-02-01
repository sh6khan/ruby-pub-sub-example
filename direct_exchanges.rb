#!/usr/bin/env ruby
# encoding: utf-8

require "rubygems"
require "bunny"


#creating a new Bunny connection and starting it
connection = Bunny.new
connection.start

#creating a channel under that connection
channel = connection.create_channel


#creating a queue under the created channel 
#its important to have a unique name for each queue
#the :auto_delete makes it so that when the last sub unsubs, the queue is deleted
first_queue = channel.queue("unique_name_of_queue", :auto_delete => true)
direct_messages = channel.queue("direct_messages_for_bob", :auto_delete => true)


#an exchange is where the publisher sends their data
#a queue is from where the sub gets their data
#default_exchange simply creates a binding between exchange and queue
exchange = channel.default_exchange



#this is the proccess of subscribing to a queue
first_queue.subscribe do |info, metadata, payload|
	puts "unique_name received #{payload}"
end

direct_messages.subscribe do |info, metadata, payload|
	puts "bob recieved #{payload}"
end

#this is the proccess of publishing to an exchange
exchange.publish("This message will go to the first_queue", :routing_key=> "unique_name_of_queue")
.publish("this message will go to the direct_messages queue", :routing_key=> "direct_messages_for_bob")

sleep 1.0

connection.close



