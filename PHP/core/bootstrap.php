<?php

if (!defined('COREDIR')) {
	define('COREDIR', dirname(__FILE__));
}

/**
 * Autoload our classes
 * @param string $class
 */
function __autoload($class) 
{
	if (!class_exists($class)) {
		$class_parts = explode('_', strtolower($class));
		$class_file  = COREDIR . '/' . implode('/', $class_parts) . '.php';
		require $class_file;
	}
}

