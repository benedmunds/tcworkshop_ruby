require 'rubygems'
require 'sinatra'
require 'twilio-ruby'

get '/enqueue' do

	content_type 'text/xml'

	response = Twilio::TwiML::Response.new do |r|
	  r.Enqueue 'radio-callin-queue', 
	  	:waitUrl       => '/wait', 
	  	:waitUrlMethod => 'GET',
	  	:action        => '/sms',
	  	:method        => 'GET'
	end

	response.text
	
end

get '/sms' do

	account_sid = 'ACb04b2db30c75145beaf4129d3baa1ef7'
	auth_token  = 'a99cff08dc934045096f1d5b246b17ab'

	# set up a client to talk to the Twilio REST API
	@client = Twilio::REST::Client.new account_sid, auth_token

	# send an sms
	@client.account.sms.messages.create(
	  :from => '3144507638',
	  :to   => '7062894115',
	  :body => 'Thanks!'
	)
	
end

get '/dequeue' do

	content_type 'text/xml'

	response = Twilio::TwiML::Response.new do |r|
		r.Dial do |d|
			d.Queue 'radio-callin-queue'
		end
	end

	response.text
	
end
get '/wait' do

	content_type 'text/xml'

	response = Twilio::TwiML::Response.new do |r|

	  r.Say "You are number %s in line." % [@params['QueuePosition']]
	  r.Say "The average wait time is %s seconds." % [@params['AvgQueueTime']]

	  r.Play "http://com.twilio.music.rock.s3.amazonaws.com/nickleus_-_original_guitar_song_200907251723.mp3"

	end

	response.text
	
end