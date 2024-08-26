module github.com/awad2747/sample-service-golang

go 1.23.0

replace github.com/awad2747/sample-service-golang-proto-client/helloworld => ./proto/github.com/awad2747/sample-service-golang-proto-client/helloworld

require (
	github.com/awad2747/sample-service-golang-proto-client v0.0.0-20240826132541-cd9a78e76e8b
	google.golang.org/grpc v1.65.0
	google.golang.org/protobuf v1.34.1
)

require (
	golang.org/x/net v0.25.0 // indirect
	golang.org/x/sys v0.20.0 // indirect
	golang.org/x/text v0.15.0 // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20240528184218-531527333157 // indirect
)
