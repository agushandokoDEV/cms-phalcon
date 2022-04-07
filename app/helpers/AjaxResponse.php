<?php
class AjaxResponse
{
    private $arayResponse;
    public $success=false;
    public $code=null;
    public $message='OK';
    public $data=null;
    
    public function send()
    {
        $this->arayResponse['success']=$this->success;
        
        if($this->success)
        {
            $this->arayResponse['message']  =$this->message;
            $this->arayResponse['data']     =$this->data;
        }
        else
        {
            $this->arayResponse['error']['code']=$this->code;
            $this->arayResponse['error']['message']=$this->message;
        }
        echo json_encode($this->arayResponse);
    }
}