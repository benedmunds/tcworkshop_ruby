require 'rubygems'
require 'sinatra'
require 'twilio-ruby'

get '/' do

	content_type 'text/xml'

	response = Twilio::TwiML::Response.new do |r|
	  r.Say 'You are being enqueued'
	  r.Enqueue 'radio-callin-queue'
	end

	response.text
	
end