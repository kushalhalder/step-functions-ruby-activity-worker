#!/usr/bin/env ruby -w

require 'json'
require 'aws-sdk-core'
require 'aws-sdk-states'

activity_name = ARGV[0]

credentials = Aws::SharedCredentials.new
region = 'ap-south-1'

client = Aws::States::Client.new(
	credentials: credentials,
	region: region,
	http_read_timeout: 60
)

resp = client.create_activity({
  name: activity_name
})

puts JSON.dump(resp)
