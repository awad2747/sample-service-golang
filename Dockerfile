FROM golang:alpine


# Install git and ca-certificates (needed to be able to call HTTPS)
RUN apk --update add ca-certificates git


# Move to working directory /app
WORKDIR /app

# Copy go.mod and go.sum files
COPY go.mod go.sum ./

# Download dependencies using go mod
RUN go mod download

# Copy the code into the container
COPY . .

# Build the application's binary
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o sample-service-golang .

# Expose port 50051 to the outside world
EXPOSE 50051 
EXPOSE 80

# Command to run the application when starting the container
CMD ["/app/sample-service-golang"]

