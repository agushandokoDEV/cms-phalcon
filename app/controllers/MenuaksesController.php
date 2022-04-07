<?php
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Select;

class MenuaksesController extends ControllerBase
{
    /**
     * laman index menu akses
     */
    public function indexAction($param=false)
    {
        if($this->request->isAjax())
        {
            $this->view->disable();
            if($this->request->isAjax())
            {
                $this->view->disable();
                if(method_exists(__CLASS__,$param))
                {
                    $this->{$param}();
                }
                else
                {
                    throw new Exception("method tidak tersedia");
                }
            }
        }
        $this->myassets->treeTable();
        
        $data['list_roles']=$this->getListRoles()->render('roles',['class'=>'form-control','onchange'=>'load_access(this.value)']);
        $this->view->setVar("title","Menu Akses");
        $this->view->data=$data;
    }
    
    
    public function editAction($param=false)
    {
        if($this->request->isAjax())
        {
            $this->view->disable();
            if($this->request->isAjax())
            {
                $this->view->disable();
                if(method_exists(__CLASS__,$param))
                {
                    $this->{$param}();
                }
                else
                {
                    throw new Exception("method tidak tersedia");
                }
            }
        }
        else
        {
            $this->show404();
        }
    }
    
    /**
     * get list role (dropdown)
     */
    private function getListRoles($def_val=null){
        $form=new Form();
        $result=array();
        $dt=MRoles::find(['order'=>'roles_name ASC']);
        foreach($dt as $val){
            $result[$val->roles]=$val->roles_name;
        }
        
        $select = new Select("roles",$result,["useEmpty"  =>  true,"emptyText" =>  "- Roles -"]);
        if($def_val != null){
            $select->setDefault($def_val);
        }
        return $form->add($select);
    }
    
    /**
     * get list menu by roles
     */
    private function get_list_menu_by_role()
    {
        $roles=$this->request->getPost('roles');
            
        try{
            $allResource=MMenu::find();
            $dt=[];
            if($allResource)
            {
                foreach($allResource as $r)
                {
                    $accessList=MAccessList::findFirst([
                        "roles=:roles: AND resources_name=:resources: AND access_name=:access:",
                        "bind"=>[
                            "roles"=>$roles,
                            "resources"=>$r->resources_name,
                            "access"=>$r->access_name
                        ]
                    ]);
                    
                    if(!$accessList)
                    {
                        
                        $newAccess=new MAccessList();
                        $newAccess->roles=$roles;
                        $newAccess->resources_name=$r->resources_name;
                        $newAccess->access_name=$r->access_name;
                        $newAccess->allowed=0;
                        $newAccess->save();
                    }
                }
            }
            $this->rs->success=true;
            $this->rs->data=$this->treeTable($roles);
        }catch(Exception $e)
        {
            $this->rs->message=$e->getMessage();
        }
        $this->rs->send();
    }
    
    private function get_data_menu($roles,$m=false,$r=false)
    {
        $show_menu='';
        $resource='';
        if($m)
        {
            $show_menu="AND MMenu.show_menu='Y'";
        }
        if($r != false)
        {
            $resource="AND MAccessList.resources_name='$r'";
        }
        $menuItem=$this->modelsManager->createBuilder()
                ->from("MMenu")
                ->columns("MMenu.menu_id,MMenu.resources_name,MMenu.access_name,MMenu.menu_title,MMenu.menu_parent_id,MMenu.description,MMenu.show_menu,MMenu.menu_order,MAccessList.allowed,MAccessList.roles")
                ->join("MAccessList","MAccessList.resources_name = MMenu.resources_name AND MAccessList.access_name=MMenu.access_name")
                ->where("MAccessList.roles='$roles' $show_menu $resource")
                ->orderBy("MMenu.menu_order ASC")
                ->getQuery()
                ->execute();
        return $menuItem;
    }
    
    private function treeTable($roles)
    {
        $html  = '';
        $items = $this->get_data_menu($roles,TRUE);
        $checked[0]="";
        $checked[1]="checked";
        $html .= '
            <table id="treeGrid" class="table table-hover table-bordered">
            <thead>
                <tr>
                    <th>Modul</th>
                    <th>URI</th>
                    <th>Description</th>
                    <th style="text-align: center;">Read</th>
                    <th style="text-align: center;">Create</th>
                    <th style="text-align: center;">Update</th>
                    <th style="text-align: center;">Delete</th>
                </tr>
            </thead>
            <tbody>
        ';
        $aksi='';        
        if(count($items) > 0)
        {
            foreach($items as $v)
            {
                $acccess=$this->get_data_menu($v->roles,FALSE,$v->resources_name);
                $r='';
                $acc['index']='-';
                $acc['add']='-';
                $acc['edit']='-';
                $acc['delete']='-';
                //$acc['export']='-';
                
                if(count($acccess) > 0)
                {
                    foreach($acccess as $a)
                    {
                        $aksi = '<input id="'.$a->resources_name.$a->menu_id.'" class="'.$a->resources_name.'" type="checkbox" onchange="checkOne('."'".$a->resources_name."'".','."'".$a->access_name."'".','."'".$a->menu_id."'".')" name="'.$a->resources_name.'[]" value="'.$a->access_name.'" '.$checked[$a->allowed].'/>';
                        $acc[$a->access_name] =$aksi;
                    }
                }
                if($v->menu_parent_id == 0)
                {
                    $p="data-tt-id='parent-".$v->menu_id."'";
                }
                else
                {
                    $p="data-tt-id='parent-".$v->menu_id."' data-tt-parent-id='parent-".$v->menu_parent_id."'";
                }
                
                $resource=$v->resources_name;
                $url=$resource.'/'.$v->access_name;
                $res=substr($resource,0,1);
                if($res == '-')
                {
                    $url='-Parent';
                }
                $html .='
                        <tr '.$p.'>
                            <td>'.$v->menu_title.'</td>
                            <td>'.$url.'</td>
                            <td>'.$v->description.'</td>
                            <td align="center">'.$acc['index'].'</td>
                            <td align="center">'.$acc['add'].'</td>
                            <td align="center">'.$acc['edit'].'</td>
                            <td align="center">'.$acc['delete'].'</td>
                        </tr>
                    ';
            }
        }
        $html .= '</tbody></table>';
        return $html;
    }
    
    /**
     * set access untuk setiap roles
     */
    private function setAccess()
    {
        $data=[];
        $type=$this->request->getPost('type');
        $roles=$this->request->getPost('roles');
        $resources=$this->request->getPost('resources');
        $access=$this->request->getPost('access');
        $allowed=$this->request->getPost('allowed');
        try
        {
            if($type != "")
            {
                if($type == "one")
                {
                    $setData=MAccessList::findFirst([
                        "roles=:roles: AND resources_name=:resources: AND access_name=:access:",
                        "bind"=>[
                            "roles"=>$roles,
                            "resources"=>$resources,
                            "access"=>$access
                        ]
                    ]);
                    $setData->allowed=$allowed;
                    $setData->update();
                }
                else
                {
                    $a=[];
                    if(count($access) > 0)
                    {
                        foreach($access as $v)
                        {
                            $setData=MAccessList::findFirst([
                                "roles=:roles: AND resources_name=:resources: AND access_name=:access:",
                                "bind"=>[
                                    "roles"=>$roles,
                                    "resources"=>$resources,
                                    "access"=>$v
                                ]
                            ]);
                            $setData->allowed=$allowed;
                            $setData->update();
                        }
                    }
                }
                $this->rs->success=true;
            }
            else
            {
                $this->rs->message="type tidak diketahui";
            }
            
        }catch(Exception $e)
        {
            $this->rs->code=$e->getCode();
            $this->rs->message=$e->getMessage();
        }
        $this->rs->send();
    }
}