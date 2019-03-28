#!/usr/bin/env ruby -w
for value in 1..10 do
	system('aws stepfunctions start-execution --state-machine-arn "arn:aws:states:ap-south-1:127603365779:stateMachine:PaymentFlow-20190328-1" --input "{\"value\" : \"test\"}"')
end
