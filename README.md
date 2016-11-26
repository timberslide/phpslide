# phpslide

This is a (very much work in progress) php client for Timberslide

The library is super limited. Currently it can only stream events into Timberslide.

## Usage

Take a look at `Dockerfile` to see what the dependencies are.

Take a look at `example.php` which should be self explanatory.

## Running the example

Add your token and topic into example.php.

Start watching your topic `ts get <username>/<topicname>`

Then run `make example`.

## Building from scratch

This repo contains a build of the library, so this step shouldn't normally be necessary.

Details of this can be found in `Dockerfile.release`

To rebuild the grpc/protobufs goodness use `make release`.
