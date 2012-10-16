require 'rubygems'
require 'sinatra'
require 'twilio-ruby'

get '/enqueue' do

	content_type 'text/xml'

	response = Twilio::TwiML::Response.new do |r|
	  r.Enqueue 'radio-callin-queue', 
	  	:waitUrl => '/wait', 
	  	:waitUrlMethod => 'GET',
	  	:action => '/sms'
	end

	response.text
	
end

get '/sms' do

	content_type 'text/xml'

	response = Twilio::TwiML::Response.new do |r|
	  r.Sms 'Thanks for Calling!'
	end

	response.text
	
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