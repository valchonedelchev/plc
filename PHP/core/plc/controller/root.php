<?php

class PLC_Controller_Root extends PLC_Controller_Abstract  implements SPL_Controller_Interface
{
	public function dispatch()
	{
		$nextController = $this->getNext();
		if ($nextController) 
		{
			return $nextController;
		}
	}
}

