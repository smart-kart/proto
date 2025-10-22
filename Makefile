# Proto generation Makefile for proto service
.PHONY: proto-gen buf go-tags

## Generate proto files using buf and add go tags
proto-gen: buf go-tags

## Generate code from proto files using buf
buf:
	@echo "Generating code from proto files using buf..."
	@command -v buf >/dev/null 2>&1 || { \
		echo "buf not found, installing..."; \
		go install github.com/bufbuild/buf/cmd/buf@latest; \
	}
	@buf generate

## Add go tags to generated files using protoc-go-inject-tag
go-tags:
	@echo "Adding go tags..."
	@command -v protoc-go-inject-tag >/dev/null 2>&1 || { \
		echo "protoc-go-inject-tag not found, installing..."; \
		go install github.com/favadi/protoc-go-inject-tag@latest; \
	}
	@for file in $$(find gen/go -name "*.pb.go" -type f 2>/dev/null); do \
		protoc-go-inject-tag -input=$$file -remove_tag_comment; \
	done
