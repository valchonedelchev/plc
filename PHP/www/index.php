<?php
require dirname(__FILE__) . '/../core/bootstrap.php';
$request = new PLC_Request();
$controller = new PLC_Controller_Root();
$controller->dispatch($request);
?>
