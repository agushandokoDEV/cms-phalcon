<?php
use Phalcon\Mvc\Controller;
use Swagger\Serializer;

class DocsController extends Controller
{
    public function indexAction(){}
    
    public function apiAction(){}
    
    public function restAction()
    {
        $this->view->disable();
        $swagger = \Swagger\scan($this->config->application->swaggerDir);
        header('Content-Type: application/json');
        echo $swagger;
    }
}