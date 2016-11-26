example:
	docker build -t timberslide/phpexample .
	docker run -it timberslide/phpexample

release:
	docker build -f Dockerfile.release -t timberslide/phpslide .
	-docker rm phpslide-build
	docker run --name phpslide-build timberslide/phpslide
	-mkdir release
	docker cp phpslide-build:/phpslide/vendor ./release/vendor
	docker cp phpslide-build:/phpslide/timberslide.php ./release/timberslide.php

clean:
	rm -rf release
