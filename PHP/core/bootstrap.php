<?php

if (!defined('COREDIR')) {
	define('COREDIR', dirname(__FILE__));
}


require 'plc/autoload.php';
spl_autoload_register('PLC_Autoload::autoload');



