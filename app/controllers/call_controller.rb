class CallController < ApplicationController
	skip_before_action :verify_authenticity_token

	def handler
		if params['Digits']
			fizzbuzz
		elsif params[:call]
			setup
		else 
			prompt
		end
	end

	def prompt
		response = Twilio::TwiML::VoiceResponse.new do |r|
				r.gather numDigits: 2 do |s|
					s.say "Please enter a number with at most 2 digits"
				end
			end
		render :xml => response.to_xml
	end

	def fizzbuzz
		number = params['Digits'].to_i
		response = Twilio::TwiML::VoiceResponse.new do |r|
				for i in (1..number).to_a
					if i % 3 == 0 and i % 5 == 0
						r.say "Fizz Buzz"
					elsif i % 3 == 0
						r.say "Fizz"
					elsif i % 5 == 0
						r.say "Buzz"
					else
						r.say i.to_s
					end
				end
			end
		render :xml => response.to_xml
	end

	def setup
		@client = Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_AUTH_TOKEN']

		phone_number = params[:call][:phone_number]
		delay = if params[:call][:delay].blank? then 0 else params[:call][:delay].to_i end

		if validate(phone_number, delay)
			flash[:success] = "Success!"
		else
			redirect_to root_path
			return
		end

		twilio_number = ENV['TWILIO_NUMBER']
		url = request.base_url + '/call/handler'
		@delayed = @client.calls.delay(run_at: delay.seconds.from_now).create(
			to: phone_number,
			from: twilio_number,
			url: url
			)
		redirect_to root_path
	end

	def validate(phone_number, delay)
		number_exists(phone_number) and valid_number(phone_number) and valid_delay(delay)
	end

	def number_exists(phone_number)
		if phone_number.blank?
			flash[:error] = "Please enter a valid phone number"
			return false
		else
			return true
		end
	end

	def valid_number(phone_number)
	  begin
	  	client = Twilio::REST::Client.new ENV['TWILIO_SID'], ENV['TWILIO_AUTH_TOKEN']
	    client.lookups.v1.phone_numbers(phone_number).fetch(country_code: 'US')
	    return true
	  rescue => e
	  	flash[:error] = "Please enter a valid phone number"
	    return false
	  end
	end

	def valid_delay(delay)
		if delay < 0
			flash[:error] = "Please enter a valid delay"
			return false
		else 
			return true
		end
	end

	def index
		@call = Call.new
	end

end
