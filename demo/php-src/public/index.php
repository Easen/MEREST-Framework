<?php

$dataFolder = realpath('../data/');

$requestedResource = $_SERVER['REQUEST_URI'];
if ('/' == substr($requestedResource, -1)) {
	$requestedResource = substr($requestedResource, 0, -1);
}

// Don't try this at home.... or on a production server
$phpFile = $dataFolder . $requestedResource . '.php';
if (file_exists($phpFile)) {
	$structure = include $phpFile;
	header('Content-type: application/json');
	echo json_encode($structure);
} else {
	header('Status: 404 Not Found');
}