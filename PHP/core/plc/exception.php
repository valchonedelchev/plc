<?php

class PLC_Exception extends Exception
{
    public function __construct($message = null, $code = 0) 
    {
        
        return "exception '" . __CLASS__ . "' with message '" . $this->getMessage() . "' in " . $this->getFile() . ":" . $this->getLine() . "\nStack trace:\n" . $this->getTraceAsString();
    }
}

