<?php
use Phalcon\Mvc\User\Component;

class ModulGenerate extends Component
{
    private $menu='';
    
    public function __construct($menu)
    {
        $this->menu=$menu;
    }
    
    public function execute()
    {
        $this->createController();
    }
    
    private function createController()
    {
        $controller=ucfirst($this->menu).'Controller';
        $file = $this->config->application->controllersDir.$controller.'.php';
        $str='';
        if(!file_exists($file))
        {
            // Open the file to get existing content
            //$current = file_get_contents($file);
            // Append a new person to the file
            $str .= "<?php\n";
            $str .= "class $controller extends ControllerBase \n";
            $str .= "{\n";
            //$str .= "\n";
            $str .= "   public function indexAction()\n";
            $str .= "   {\n";
            $str .= "   }\n";
            $str .= "}";
            // Write the contents back to the file
            file_put_contents($file, $str);
            $this->createView($this->menu);
        }
    }
    
    private function createView()
    {
        $path=$this->config->application->viewsDir;
        $foldername=strtolower($this->menu);
        $folderpath=$path.$foldername;
        if(!is_dir($path.$foldername)){
            mkdir($path.$foldername,0777,true);
            $this->createViewFile($path.$foldername);
        }
    }
    
    private function createViewFile($path)
    {
        $str ='';
        $str .='{% extends "layouts/base.volt" %}'."\n";
        $str .='{% block pagetop %}'."\n";
        $str .='<h1><i class="{{row_menu.icon}}"></i> {{row_menu.menu_title}}<small>{{row_menu.description}}</small></h1>'."\n";
        $str .='{% endblock %}'."\n";
        $str .='{% block content %}'."\n";
        $str .='<?php $this->partial("layouts/html/box/start",["icon"=>$row_menu->icon,"box_title"=>$row_menu->menu_title]); ?>'."\n";
        $str .='<?php $this->partial("layouts/html/box/end"); ?>'."\n";
        $str .='{% endblock %}';
        file_put_contents($path.'/index.volt', $str);
    }
}