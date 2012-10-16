require 'rubygems'
require 'sinatra'
require 'twilio-ruby'

class TcWorkshop < Sinatra::Base

	get '/enqueue' do

		content_type 'text/xml'

		response = Twilio::TwiML::Response.new do |r|
		  r.Say 'You are being enqueued'
		  r.Enqueue 'radio-callin-queue'
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
		  r.Say "You've been in line for %s seconds." % [@params['QueueTime']]
		  r.Say "Average wait time is %s seconds." % [@params['AvgQueueTime']]

		  r.Play "http://com.twilio.music.rock.s3.amazonaws.com/nickleus_-_original_guitar_song_200907251723.mp3"

		end

		response.text
		
	end

end