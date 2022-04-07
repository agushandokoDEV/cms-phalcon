<?php
use Phalcon\Mvc\User\Component;

class MyException extends Component
{
    private $message='';
    
    public function __construct($message =false, $code = 0)
    {
        $this->logger->error($this->message);
        $this->message = $message;
        $this->rs->code=$code;
        $this->rs->message=$message;
        $this->rs->send();
    }
    
    public function saveLog()
    {
        
    }
}