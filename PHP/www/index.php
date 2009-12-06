<?php

require dirname(__FILE__) . '/../core/bootstrap.php';

$controller = new PLC_Controller_Root();
$controller->dispatch();

?>
