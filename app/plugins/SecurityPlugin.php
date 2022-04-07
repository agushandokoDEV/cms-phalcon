<?php
use Phalcon\Acl;
use Phalcon\Acl\Role;
use Phalcon\Acl\Resource;
use Phalcon\Events\Event;
use Phalcon\Mvc\User\Plugin;
use Phalcon\Mvc\Dispatcher;
use Phalcon\Acl\Adapter\Memory as AclList;

class SecurityPlugin extends Plugin
{
    private $auth=false;
    private $roles='Guests';
    
    public function __construct()
    {
        $this->auth=$this->session->get('auth');
    }
    
    /**
	 * register roles users
	 */
    private function rolesUsers()
    {
        if($this->auth != false)
        {
            $roles[$this->auth->roles]=new Role($this->auth->roles,'Member users');
        }
        
        $roles['Guests']=new Role('Guests','Anyone browsing the site who is not signed in is considered to be a "Guest".');
        return $roles;
    }
    
    /**
	 * Public area resources for roles users "Guests"
	 */
    private function publicResources()
    {
		$publicResources = array(
			'index'      => array('*'),
            'auth'       => array('*'),
            'api'        => array('*'),
            'docs'       => array('*'),
            'error'      => array('*'),
            'page'       => array('*')
		);
        $items=CPost::find([
            "columns"=>"post_slug",
            "post_status = 'publish' AND post_type='page' AND custom_url='Y'"
        ]);
        $custom_uri=[];
        if(count($items) > 0)
        {
            foreach($items as $item)
            {
                $publicResources[$item->post_slug]=array('*');
            }
        }
        
        return $publicResources;
    }
    
    /**
	 * Private all resources for roles users "Member"
	 */
    public function privateAllResource()
    {
        //$resource=$this->curl->patch('GET','/resources/allresourcesbyroles/'.$this->roles);
        $data=[];
        $resource=$this->modelsManager->createBuilder()
            ->from("MAccessList")
            ->columns("MAccessList.resources_name,MAccessList.roles")
            ->join("MMenu","MMenu.resources_name=MAccessList.resources_name AND MMenu.access_name=MAccessList.access_name")
            ->groupBy("MAccessList.resources_name")
            ->where("MAccessList.roles='$this->roles' AND MMenu.parent_only='N'")
            ->getQuery()
            ->execute();

        if($resource)
        {
            foreach($resource as $r)
            {
                $access=MAccessList::find(
                    [
                        "roles = :roles: AND resources_name = :resources_name:",
                        "columns"=>"access_name",
                        "bind"=>[
                            "roles"=>$r->roles,
                            "resources_name"=>$r->resources_name
                        ]
                    ]
                );
                $data[$r->resources_name]=[];
                if($access)
                {
                    $accessList=[];
                    foreach($access as $a)
                    {
                        $accessList[]=$a->access_name;
                    }
                    $data[$r->resources_name]=$accessList;
                }
            }
        }
        return $data;
    }
    
    /**
	 * get private allow/deny resources for roles users "Member"
	 */
    private function PrivateResources($allowed=1)
    {
        $data=[];
        $resource=$this->modelsManager->createBuilder()
            ->from("MAccessList")
            ->columns("MAccessList.resources_name,MAccessList.roles,MAccessList.access_name,MAccessList.allowed")
            ->join("MMenu","MMenu.resources_name=MAccessList.resources_name AND MMenu.access_name=MAccessList.access_name")
            ->groupBy("MAccessList.resources_name")
            ->where("MAccessList.roles='$this->roles' AND MMenu.parent_only='N' AND MAccessList.allowed=$allowed")
            ->getQuery()
            ->execute();
        if($resource)
        {
            foreach($resource as $r)
            {
                $access=MAccessList::find(
                    [
                        "roles = :roles: AND resources_name = :resources_name: AND allowed = :allowed:",
                        "columns"=>"access_name",
                        "bind"=>[
                            "roles"=>$r->roles,
                            "resources_name"=>$r->resources_name,
                            "allowed"=>$r->allowed
                        ]
                    ]
                );
                $data[$r->resources_name]=[];
                if($access)
                {
                    $accessList=[];
                    foreach($access as $a)
                    {
                        $accessList[]=$a->access_name;
                    }
                    $data[$r->resources_name]=$accessList;
                }
            }
        }
        return $data;
    }
    
    /**
	 * ACL
	 */
    public function getAcl()
    {
        $acl = new AclList();
        $acl->setDefaultAction(Acl::DENY);
        $roles=$this->rolesUsers();
        $publicResources=$this->publicResources();
        
        /**
    	 * register role users
    	 */
        foreach ($roles as $role) {
			$acl->addRole($role);
		}
        
        /**
    	 * register public resources
    	 */
		foreach ($publicResources as $resource => $actions) {
			$acl->addResource(new Resource($resource), $actions);
		}
        
        /**
    	 * allow access resource for all roles
    	 */
		foreach ($publicResources as $resource => $actions) {
			foreach ($actions as $action){
				$acl->allow($this->roles, $resource, $action);
			}
		}
        
        /**
    	 * allow resource roles users
    	 */
        $privateAllResource=$this->privateAllResource();
        $allowResources=$this->PrivateResources(1);
        if($this->auth != false)
        {
           /**
        	 * register private resources
        	 */
    		if($privateAllResource != null)
            {
                foreach ($privateAllResource as $resource => $actions) {
        			$acl->addResource(new Resource($resource), $actions);
        		}
            }
            if($allowResources != null)
            {
                foreach ($allowResources as $resource => $actions) {
        			foreach ($actions as $action){
        				$acl->allow($this->roles, $resource, $action);
        			}
        		}
            }
        }
        
        return $acl;
    }
    
    
    /**
	 * This action is executed before execute any action in the application
	 *
	 * @param Event $event
	 * @param Dispatcher $dispatcher
	 * @return bool
	 */
	public function beforeDispatch(Event $event, Dispatcher $dispatcher)
	{
        $controller = $dispatcher->getControllerName();
        $action = $dispatcher->getActionName();
        $acl = $this->getAcl();
        if($this->auth != false)
        {
            $this->roles = $this->auth->roles;
            $acl = $this->getAcl();
            $allowed = $acl->isAllowed($this->roles, $controller, $action);
            
            /**
        	 * show error 404 on resource not register
        	 */
            if(!$acl->isResource($controller))
            {
                if($this->request->isAjax())
                {
                    $dispatcher->forward([
        				'controller' => 'error',
        				'action'     => 'ajax404'
        			]);
                }
                else
                {
                    $dispatcher->forward([
        				'controller' => 'error',
        				'action'     => 'error404'
        			]);
                }
                
                return false;
            }
            
            /**
        	 * show error 403 forbidden access
        	 */
             
            if($allowed != Acl::ALLOW)
            {
                if($this->request->isAjax())
                {
                    $dispatcher->forward(array(
        				'controller' => 'error',
        				'action'     => 'ajax403'
        			));
                }
                else
                {
                    $dispatcher->forward(array(
        				'controller' => 'error',
        				'action'     => 'error403'
        			));
                }
                return false;
            }
        }
        else
        {
            /**
        	 * show login page
        	 */
            $allowed = $acl->isAllowed($this->roles, $controller, $action);
            if(!$allowed)
            {
                if($this->request->isAjax())
                {
                    $dispatcher->forward(array(
        				'controller' => 'error',
        				'action'     => 'errorLogin'
        			));
                }
                else
                {
                    $dispatcher->forward(array(
        				'controller' => 'error',
        				'action'     => 'error404'
        			));
                }
                return false;
            }
        }
	}
}