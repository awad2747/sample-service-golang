package main

import (
	"context"
	"fmt"
	"log"
	"net"
	"time"

	helloworldproto "github.com/awad2747/sample-service-golang-proto-client/helloworld"
	"google.golang.org/grpc"
	"net/http"
)

// Unary interceptors
func LoggingInterceptor(ctx context.Context, req interface{}, info *grpc.UnaryServerInfo, handler grpc.UnaryHandler) (interface{}, error) {
	start := time.Now()
	resp, err := handler(ctx, req)
	log.Printf(`Request - Method:%s Duration:%s Error:%v
`, info.FullMethod, time.Since(start), err)
	return resp, err
}

// GreeterServer is the server API for Greeter service.
type GreeterServer struct {
	helloworldproto.UnimplementedGreeterServer
}

// SayHello implements the Greeter service.
func (s *GreeterServer) SayHello(ctx context.Context, req *helloworldproto.HelloRequest) (*helloworldproto.HelloReply, error) {
	return &helloworldproto.HelloReply{
		Message: `Hello, ` + req.Name,
	}, nil
}

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintln(w, "Hello, World!")
}

func main() {

	// run http server
	http.HandleFunc("/", handler)

	go func() {
		err := http.ListenAndServe(":80", nil)
		if err != nil {
			fmt.Println("Error starting server:", err)
		}
		if err == nil {
			fmt.Println("starting http server on 80", err)
		}
	}()

	// Create a TCP listener on port 50051
	lis, err := net.Listen(
		`tcp`,
		":50051",
	)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

	// Create grpc server
	grpcServer := grpc.NewServer(
		grpc.ChainUnaryInterceptor(
			LoggingInterceptor,
		),
	)

	// Register proto
	helloworldproto.RegisterGreeterServer(grpcServer, &GreeterServer{})

	// Listen on grpc server
	fmt.Println("gRPC server listening on port 50051...")
	if err := grpcServer.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
