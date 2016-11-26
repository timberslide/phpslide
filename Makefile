all:
	protoc302 -I . timberslide.proto --php_out=plugins=grpc:.
