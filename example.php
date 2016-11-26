<?php

require dirname(__FILE__).'/phpslide.php';

$token = "HM1XFUaTqPeDFG30Fz147NeC";
$topic = "kris/example123";

echo "Creating a Timberslide client\n";
$timber = new Timberslide($topic, $token);

echo "Sending some events into Timberslide\n";
$timber->send("This is the first test message");
$timber->send("This is the second");
$timber->send("#3");
$timber->send("This is the second last");
$timber->send("Goodbye");

echo "Stopping our stream\n";
$timber->done();

echo "Cleaning up\n";
$timber->close();

?>
