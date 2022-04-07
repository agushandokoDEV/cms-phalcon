<?php
use Phalcon\Mvc\Controller;

class ErrorController extends Controller
{
    public function initialize()
    {
       $this->assets->collection("cssHeader")
            ->addCss('theme/lte/bootstrap/css/bootstrap.min.css')
            ->addCss('theme/lte/plugins/font-awesome.min.css')
            ->addCss('theme/lte/plugins/ionicons.min.css')
            ->addCss('theme/lte/dist/css/skins/_all-skins.min.css');
    }
    public function errorLoginAction()
    {
        $this->view->disable();
        $this->rs->code=403;
        $this->rs->message="Anda sudah logout, harap login kembali";
        $this->rs->send();
    }
    public function error404Action()
    {
        $this->view->setVar("title","404 - Page not found");
    }
    
    public function error403Action()
    {
        $this->view->setVar("title","403 - Forbidden access");
    }
    
    public function error503Action()
    {
        $this->view->setVar("title","503");
    }
    
    public function nocontentAction()
    {
        $this->view->setVar("title","Konten tidak tersedia");
    }
    
    public function ajax404Action()
    {
        $this->view->disable();
        $this->rs->code=404;
        $this->rs->message="Laman tidak tersedia";
        $this->rs->send();
    }
    
    public function ajax403Action()
    {
        $this->view->disable();
        $this->rs->code=403;
        $this->rs->message="Maaf anda tidak punya akses untuk menu ini";
        $this->rs->send();
    }
}