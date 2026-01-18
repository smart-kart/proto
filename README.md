# Cozy Hub Proto

This repository contains Protocol Buffer definitions for the Cozy Hub services.

## Structure

```
proto/
├── account/              # Account service proto definitions
│   ├── grpc/v1/         # gRPC v1 definitions
│   └── http/v3/         # HTTP v3 definitions
├── gen/                 # Generated code (auto-generated, do not edit)
│   ├── go/             # Generated Go code
│   └── resource/       # Generated OpenAPI specs
├── buf.yaml            # Buf configuration
├── buf.gen.yaml        # Buf code generation configuration
└── Makefile            # Build targets

```

## Prerequisites

- [buf](https://buf.build/docs/installation) - Protocol buffer tooling
- Go 1.21+

## Usage

### Install Dependencies

```bash
make install-buf
```

### Generate Code

Generate Go code from proto files:

```bash
make generate
```

### Lint Proto Files

```bash
make lint
```

### Format Proto Files

```bash
make format
```

### Check for Breaking Changes

```bash
make breaking
```

### Clean Generated Files

```bash
make clean
```

## Adding New Services

1. Create a new directory under `proto/` for your service (e.g., `proto/payment/`)
2. Add subdirectories for API versions (e.g., `grpc/v1/`, `http/v3/`)
3. Create your `.proto` files
4. Add the module to `buf.yaml`:
   ```yaml
   modules:
     - path: your-service
       name: buf.build/cozy-hub/your-service
   ```
5. Run `make generate` to generate code

## Generated Code

Generated code is placed in:
- `gen/go/` - Go protobuf and gRPC code
- `gen/resource/` - OpenAPI/Swagger specifications

The generated code uses the module path: `github.com/cozy-hub/proto/gen/go`

## Integration

To use the generated code in your Go services:

```go
import (
    accountv1 "github.com/cozy-hub/proto/gen/go/account/grpc/v1"
    accountv3 "github.com/cozy-hub/proto/gen/go/account/http/v3"
)
```

## Buf Configuration

- **buf.yaml**: Defines modules, dependencies, and linting rules
- **buf.gen.yaml**: Defines code generation plugins and options

### Plugins Used

- **protocolbuffers/go**: Generates Go protobuf code
- **grpc/go**: Generates Go gRPC server/client code
- **grpc-gateway**: Generates HTTP/JSON to gRPC gateway
- **openapiv2**: Generates OpenAPI/Swagger documentation
