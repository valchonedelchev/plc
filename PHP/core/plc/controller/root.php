<?php

class PLC_Controller_Root extends PLC_Controller_Abstract  implements PLC_Controller_Interface
{
	public function dispatch(PLC_Request $request)
	{
		$nextController = $this->getNext();
		if ($nextController) 
		{
			return $nextController;
		}
	}
}

