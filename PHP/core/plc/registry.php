<?php

class PLC_Registry
{
    /**
     * Static instance
     *
     * @var PLC_Registry
     */
    private static $_instance;
    /**
     * Object hash map
     *
     * @var array
     */
    private $_map;
    /**
     * Do not allow to instantiate registry outside
     *
     */
    private function __construct() 
    {
    }
    /**
     * Use this method instead new()
     *
     */
    public static function getInstance() 
    {
        
        if (self::$_instance === null) 
        {
            self::$_instance = new self();
        }
        
        return self::$_instance;
    }
    /**
     * Prevent cloning
     */
    private function __clone() 
    {
    }
    /**
     * Get an object by key
     *
     * @param string|int $key
     * @return object
     */
    public function get($key) 
    {
        
        return $this->_map[$key];
    }
    /**
     * Set an object by key
     *
     * @param string|int $key
     */
    public function set($key, $value) 
    {
        
        return $this->_map[$key] = $value;
    }
}

