# ruby-pub-sub-example
Example code on how to create a pub and sub in ruby using Bunny and RabbitMQ

#Getting RabbitMQ
RabbitMQ is an amazing messaging server and very easy to get installed and up and running. If your on a MAC first get 
homebrew then brew install rabbitmq. Run the following commands on your Terminal
```
$ brew install rabbitmq
```
 once you have it, go inside your .bashrc or .bash_profile page and write the following
```
PATH=$PATH:/usr/local/sbin
```
then save the file and exit. you may have to restart your terminal after this
Now all you have to do is start it
```
$ rabbitmq-server -detached
```
you should see something like the following
```
Warning: PID file not written; -detached was passed.
```

to make sure RabbitMQ is on, run `rabbitmqctl status`
to close rabbitMQ run `rabbitmqctl stop`


#Usage
you can use any of the files from this repo or make your own. They are nothing more than simple ruby files 
direct_exchanges is a one on one connection
blabbr_exchanges is one to many conection
and topic_exchange is many to many 

to run these files, simply type on the Terminal 
```
$ ruby direct_exchanges.rb
```

