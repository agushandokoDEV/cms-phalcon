<?php

use Phalcon\Mvc\Controller;
use Phalcon\Mvc\Dispatcher;
use Phalcon\Db;

class ControllerBase extends Controller
{
    protected $auth=false;
    
    public function beforeExecuteRoute(Dispatcher $dispatcher)
    {
        $this->auth=$this->session->get('auth');
        $this->myassets->assetsBase();
        /*
        $mypost=CPost::find(["post_author='".$this->auth->username."' AND post_status ='autosave'"]);
        if(count($mypost) > 0)
        {
            $mypost->delete();
        }
        */
    }
    
    public function afterExecuteRoute(Dispatcher $dispatcher)
    {
        $this->logger->info($this->router->getRewriteUri());
        $this->view->setVar("auth",$this->auth);
        if(!$this->request->isAjax() AND !$this->request->isPost())
        {
            $this->update_post_schedule();
            /*
            if($this->redis->get('sidebar-menu') == null)
            {
                $this->redis->save('sidebar-menu',$this->get_all_menu());
            }
            */
            $sidebar_menu=new MenuGenerate($this->get_all_menu());//$this->redis->get('sidebar-menu')
            $Menu=$this->getDataMenu($dispatcher->getControllerName(),$dispatcher->getActionName());
            $this->view->setVar("sidebar_menu",$sidebar_menu->sidebar());
            $this->view->setVar("row_menu",$Menu);
            $this->view->setVar("post_menu",$this->get_post_menu());
            $this->view->setVar("title",$Menu->menu_title);
            $this->view->setVar("last_activity",$this->get_list_activity());
        }
    }
    
    private function update_post_schedule()
    {
        $author=$this->auth->username;
        $now=date('Y-m-d H:i:s');
        $data=CPost::find([
            "post_author='$author' AND publish_schedule <='$now'"
        ]);
        if(count($data) > 0)
        {
            foreach($data as $v)
            {
                $this->db->query("UPDATE c_post SET post_status='publish', publish_on='$v->publish_schedule',publish_schedule=NULL WHERE post_id='$v->post_id'");
            }
        }
    }
    
    private function get_post_menu()
    {
        $data = $this->modelsManager->createBuilder()
              ->from('MPostType')
              ->where("post_type_status = 'Y'")
              ->inWhere('post_type',$this->auth->my_post_type)
              ->orderBy('post_title ASC')
              ->getQuery()
              ->execute();
              
        return $data;
    }
    
    private function get_all_menu($param=false)
    {
        
        $parent='';
        if($param != false)
        {
            $parent="AND MMenu.menu_parent_id=$param";
        }
        $data=$this->modelsManager->createBuilder()
            ->from("MMenu")
            ->columns("MMenu.menu_id,MMenu.menu_parent_id,MMenu.resources_name,MMenu.access_name,MMenu.menu_title,MMenu.description,MMenu.icon,MMenu.show_menu")
            ->join("MAccessList","MAccessList.resources_name=MMenu.resources_name AND MAccessList.access_name=MMenu.access_name")
            ->where("MMenu.show_menu='Y' AND MAccessList.allowed=1 AND MAccessList.resources_name !='post' AND MAccessList.roles='".$this->auth->roles."' $parent")
            ->orderBy("MMenu.menu_order ASC")
            ->getQuery()
            ->execute();
        return $data->toArray();
    }
    
    private function getDataMenu($resources,$access)
    {
        $data=MMenu::findFirst([
            "resources_name='$resources' AND access_name='$access'",
            'order'=>'menu_order ASC'
        ]);
        return $data;
    }
    
    private function getSuMMenu($controller,$action)
    {
        
        if($controller == '')
        {
            $controller='dashboard';
        }
        if($action == '')
        {
            $action='index';
        }
        $parent=$this->getDataMenu($controller,$action);
        $menu=$this->get_all_menu($parent->menu_id);
        
        return $menu;
    }
    
    protected function set_activity($msg='')
    {
        $data=new MUsersActivity();
        $data->author=$this->auth->username;
        $data->activity=$msg;
        $data->last_activity=date('Y-m-d H:i:s');
        $data->save();
    }
    
    private function get_list_activity()
    {
        $dt = $this->modelsManager->createBuilder()
              ->columns('MUsersActivity.activity,MUsersActivity.last_activity,MUsers.full_name')
              ->from('MUsersActivity')
              ->join('MUsers','MUsers.username=MUsersActivity.author')
              ->orderBy('MUsersActivity.last_activity DESC')
              ->limit(10)
              ->getQuery()
              ->execute();
        return $dt;
    }
    
    // show login page
    protected function showLogin()
    {
        $this->dispatcher->forward(
            [
                "controller" => "auth",
                "action"     => "index",
            ]
        );
    }
    // show 404 page not found
    protected function show404()
    {
        $this->dispatcher->forward(
            [
                "controller" => "error",
                "action"     => "show404",
            ]
        );
    }
    
    // show page forbidden access
    protected function show403()
    {
        $this->dispatcher->forward(
            [
                "controller" => "error",
                "action"     => "show403",
            ]
        );
    }
    
    // show page forbidden access
    protected function show503()
    {
        $this->dispatcher->forward(
            [
                "controller" => "error",
                "action"     => "show503",
            ]
        );
    }
    
    protected function nocontent($msg='')
    {
        $this->dispatcher->forward(
            [
                "controller" => "error",
                "action"     => "nocontent"
            ]
        );
    }
}
