#!/usr/bin/env ruby -w

require 'json'
require 'securerandom'

PAYMENT_MODES = ['ONLINE']
IS_COURIER_ORDER = [true]

def create_order_json
	invoice_value = rand(600...2000)
	discounted_invoice_value = invoice_value * 0.8
	order_hash = {
		:order_id => SecureRandom.hex,
		:customer_id => SecureRandom.hex,
		:payment_mode => PAYMENT_MODES.sample,
		:is_courier_order => IS_COURIER_ORDER.sample,
		:invoice_value => invoice_value,
		:discounted_invoice_value => discounted_invoice_value.floor,
		:payment_completed => false
	}
	JSON.generate(order_hash, quirks_mode: true)
end

number_of_orders = ARGV[0]

number_of_orders.to_i.times do
	order_json_string = create_order_json()
	system('aws', 'stepfunctions', 'start-execution', '--state-machine-arn', 'arn:aws:states:ap-south-1:127603365779:stateMachine:PaymentFlow-20190328-2', '--input', order_json_string)
end
