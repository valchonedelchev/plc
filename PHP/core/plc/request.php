<?php

class PLC_Request
{
	public function requestMethod()
	{
		return $_SERVER['REQUEST_METHOD'];
	}
	public function isGet()
	{
		return($this->requestMethod() == 'GET');
	}
	public function isPost()
	{
		return($this->requestMethod() == 'POST');
	}
	public function isAjax()
	{
	}
	public function requestUri()
	{
		return $_SERVER['REQUEST_URI'];
	}
}


