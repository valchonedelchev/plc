<?php

class PLC_Autoload
{
	/**
	 * Autoload our classes
	 * 
	 * @param string $class
	 */
	public static function autoload($class)
	{
		if (!class_exists($class)) {
			$class_parts = explode('_', strtolower($class));
			$class_file  = COREDIR . '/' . implode('/', $class_parts) . '.php';
			require $class_file;
		}
	}
}

