<?php
use \DataTables\DataTable;
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Select;

class RolesController extends ControllerBase
{
    /**
     * menampilkan laman index roles dan load data roles
     */
    public function indexAction($param=false)
    {
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
        $this->view->setVar("title","Roles Users");
        $this->myassets->assetDataTable();
    }
    
    /**
     * get all roles on dataTable
     */
    private function all_data()
    {
        $builder = $this->modelsManager->createBuilder()
                      ->columns('roles_name, description,roles')
                      ->from('MRoles');

        $dataTables = new DataTable();
        $dataTables->fromBuilder($builder)->sendResponse();
    }
    
    /**
     * menampilkan laman tambah roles dan proses tambah roles
     */
    public function addAction()
    {
        if($this->request->isPost())
        {
            $this->view->disable();
            $name=$this->request->getPost('role');
            $role=Phalcon\Tag::friendlyTitle($name,'.');
            $data=MRoles::findFirstByroles($role);
            if($data)
            {
                $this->flashSession->error("roles ".$name." sudah tersedia !!! ");
                $this->response->redirect('/roles/add');
            }
            else
            {
                $data=new MRoles();
                $data->roles_name=$name;
                $data->roles=$role;
                $data->description=$this->request->getPost('deskripsi');
                if($data->save())
                {
                    $this->add_acces_by_roles($role);
                    $this->flashSession->success("roles ".$name." berhasil ditambahkan !!! ");
                    $this->response->redirect('/roles');
                }
            }
        }
        $this->myassets->assetsFormValidation();
    }
    
    
    private function add_acces_by_roles($roles)
    {
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
    }
    
    /**
     * menampilkan laman edit roles dan proses edit roles
     */
    public function editAction($role=false)
    {
        if($role != false)
        {
            $data=MRoles::findFirstByroles($role);
            if($data)
            {
                if($this->request->isPost())
                {
                    $name=$this->request->getPost('name');
                    $data->roles_name=$name;
                    $data->description=$this->request->getPost('deskripsi');
                    if($data->save())
                    {
                        $this->flashSession->notice("edit roles ".$name." berhasil !!! ");
                        $this->response->redirect('/roles');
                    }
                }
                $this->view->setVar("roles",$data);
                
            }
            else
            {
                throw new Exception("role tidak tersedia");
            }
        }
        else
        {
            throw new Exception("role tidak tersedia");
        }
    }
    
    
    /**
     * delete roles
     */
    public function deleteAction($pk=false)
    {
        if($this->request->isAjax())
        {
            if($pk != false)
            {
                $data=MRoles::findFirstByroles($pk);
                $this->rs->message="hapus roles berhasil";
                
                if($data->delete())
                {
                    $accesList=BAccessList::find([
                        "roles_name=:roles_name:",
                        "bind"=>[
                            "roles_name"=>$pk
                        ]
                    ]);
                    $accesList->delete();
                    $this->rs->success=true;
                    $this->rs->message="data berhasil dihapus";
                }
                
            }
            else
            {
                $this->rs->message="role tidak tersedia";
            }
            
            $this->rs->send();
        }
        else
        {
            $this->show404();
        }
    }
    
}