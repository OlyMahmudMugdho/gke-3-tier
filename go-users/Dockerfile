# Dockerfile

# ---------- STAGE 1: Build ----------
FROM golang:1.24-alpine AS builder

WORKDIR /app

# Copy go mod files and download deps
COPY go.mod go.sum ./
RUN go mod download

# Copy all source code
COPY . .

# Build the Go app
RUN go build -o app .

# ---------- STAGE 2: Minimal Runtime ----------
FROM alpine:latest

WORKDIR /root/

# Install CA certificates
RUN apk --no-cache add ca-certificates

# Copy binary and frontend
COPY --from=builder /app/app .
COPY --from=builder /app/frontend ./frontend

# Expose port
EXPOSE 8080

# Run app
CMD ["./app"]
