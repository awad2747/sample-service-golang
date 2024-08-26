# Define the paths to the Protobuf compiler and plugins
PROTOC = protoc
PROTOC_GEN_GO = $(GOPATH)/bin/protoc-gen-go
PROTOC_GEN_GO_GRPC = $(GOPATH)/bin/protoc-gen-go-grpc

# Define the paths to your Protobuf files and output directories
ROOT_DIR = .
OUT_DIR = ./proto

# Find all .proto files in the working directory and compile them
PROTO_FILES := $(shell find . -name '*.proto')


# Define the target for building Protobuf files
compile_protos: $(patsubst %.proto,$(OUT_DIR)/%.pb.go,$(PROTO_FILES))

# Rule for generating Go code from Protobuf definitions
$(OUT_DIR)/%.pb.go: %.proto
	@mkdir -p $(OUT_DIR)
	$(PROTOC) -I=$(ROOT_DIR) --go_out=$(OUT_DIR) --go-grpc_out=$(OUT_DIR) $<


# Clean up generated files
clean:
	rm -rf $(OUT_DIR)



.PHONY: compile_protos clean
