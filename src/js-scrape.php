#!/usr/bin/env php
<?php

namespace JsScrape;

require_once __DIR__ . '/../vendor/autoload.php';

use Goutte\Client;

$distDir = './dist/';
$url['document'] = 'https://developer.mozilla.org/ja/docs/Web/API/Document';

$client = new Client();
$crawler = $client->request('GET', $url['document']);


// property
$properties = $crawler->filter('#wiki-content table td a code')->each(function($node){
    return $node->text();
});

// method
$methods = $crawler->filter('#wiki-content dt a')->each(function($node) {
    return $node->text();
});

$properties = array_filter($properties, function($property) {
    if (preg_match('/^(Node|document)\./', $property)) {
        return $property;
    }
});
sort($properties);

$file['document'] = new \SplFileObject($distDir . '/document-properties', 'w');
$file['node'] = new \SplFileObject($distDir . '/node-properties', 'w');

foreach ($properties as $property) {
    if (preg_match('/^document\.(.+)$/', $property, $match)) {
        $file['document']->fwrite($match[1] . "\n");
    }
    if (preg_match('/^Node\.(.+)$/', $property, $match)) {
        $file['node']->fwrite($match[1] . "\n");
    }
}

sort($methods);

$file['document'] = new \SplFileObject($distDir . '/document-methods', 'w');
$file['node'] = new \SplFileObject($distDir . '/node-methods', 'w');

foreach ($methods as $method) {
    $method = preg_replace('/\(\)$/','', $method);
    $method .= '()';

    if (preg_match('/^document\.(.+)$/', $method, $match)) {
        $file['document']->fwrite($match[1] . "\n");
    }
    if (preg_match('/^Node\.(.+)$/', $method, $match)) {
        $file['node']->fwrite($match[1] . "\n");
    }
}
