#!/usr/local/bin/php -f

<?php
//error_reporting(E_ALL);
$outpath="/root/$argv[1].pfx";
$inkey="/tmp/acme/$argv[1]/$argv[1]/$argv[1].key";
$incer="/tmp/acme/$argv[1]/$argv[1]/fullchain.cer";
$filename="$argv[1].pfx";
$server=$argv[2];

shell_exec("openssl pkcs12 -export -out $outpath -inkey $inkey -in $incer -passout file:/root/pcks12pass");

//setup the request, you can also use CURLOPT_URL
$apikey = 'Your Password State API Key';
$passid = "1234"
$ch = curl_init('https://ps.domain/api/passwords/'.$passid.'?apiKey='.$apikey.'&format=json');

var_dump($ch);

// Returns the data/output as a string instead of raw data
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

// Good practice to let people know who's accessing their servers. See https://en.wikipedia.org/wiki/User_agent
//curl_setopt($ch, CURLOPT_USERAGENT, 'GetCert/0.1 (contact@email)');

//Set your auth headers
//curl_setopt($ch, CURLOPT_HTTPHEADER, 'apiKey:');

// get stringified data/output. See CURLOPT_RETURNTRANSFER
$data = curl_exec($ch);
$json = json_decode($data);
$user = $json[0]->Title;
$password = $json[0]->Password;
$connection = ssh2_connect($server, 22);
ssh2_auth_password($connection, $user, $password);
$stream = ssh2_exec($connection, "powershell -command \"C:\Users\CertMGM\get-cert.ps1 ". $filename ."\"");
$errorStream = ssh2_fetch_stream($stream, SSH2_STREAM_STDERR);

// Enable blocking for both streams
stream_set_blocking($errorStream, true);
stream_set_blocking($stream, true);

// Whichever of the two below commands is listed first will receive its appropriate output.  The second command receives nothing
echo "Output: " . stream_get_contents($stream);
echo "Error: " . stream_get_contents($errorStream);

// Close the streams        
fclose($errorStream);
fclose($stream);

curl_close($ch);
?>