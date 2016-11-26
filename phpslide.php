<?php

require dirname(__FILE__).'/vendor/autoload.php';
require dirname(__FILE__).'/timberslide.php';

class Timberslide {
    private $token = '';
    private $topic = '';
    private $host = 'gw.timberslide.com:443';
    private $ingestClient;
    private $streamer;

    function __construct($topic, $token) {
        // Set up
        $this->token = $token;
        $this->topic = $topic;
        $channel_credentials = Grpc\ChannelCredentials::createComposite(
            Grpc\ChannelCredentials::createSsl(null),
            Grpc\CallCredentials::createFromPlugin(array($this, 'authCallback'))
        );
        $opts = [
            'credentials' => $channel_credentials
        ];
        $this->ingestClient = new ts\IngestClient($this->host, $opts);
        $this->streamer = $this->ingestClient->StreamEvents();
    }

    function __destruct() {
        // not yet implemented
        echo "In destructor\n";
        $this->streamerClient->close();
        echo "Goodbye\n";
    }

    function close() {
        // When we want to close our connection to Timberslide
        $this->streamerClient->close();
    }

    function done() {
        // When we're finished our stream, wait for Timberslide to finish
        $done = new ts\Event();
        $done->setTopic($this->topic);
        $done->setDone(true);
        $this->streamer->write($done);
        $this->streamer->read();
    }

    function authCallback($context) {
        // Gets called to add creds to the context
        return ["ts-access-token" => [$this->token]];
    }

    function send($message) {
        // Send an event into a topic
        $request = new ts\Event();
        $request->setTopic($this->topic);
        $request->setMessage($message);
        $this->streamer->write($request);
    }
}

?>
