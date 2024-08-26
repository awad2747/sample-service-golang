module github.com/awad2747/sample-service-golang

go 1.23.0

replace github.com/awad2747/sample-service-golang/helloworld => ./proto/github.com/awad2747/sample-service-golang/helloworld

require (
	google.golang.org/grpc v1.65.0
	google.golang.org/protobuf v1.34.1
	github.com/awad2747/sample-service-golang/helloworld master
)

require (
	golang.org/x/net v0.25.0 // indirect
	golang.org/x/sys v0.20.0 // indirect
	golang.org/x/text v0.15.0 // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20240528184218-531527333157 // indirect
)
