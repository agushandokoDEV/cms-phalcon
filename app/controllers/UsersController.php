<?php
use \DataTables\DataTable;
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Select;

class UsersController extends ControllerBase
{
    
    /**
     * menampilkan laman index users dan load data users
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
        $this->myassets->assetDataTable();
    }
    
    /**
     * get all users on dataTable
     */
    private function all_data()
    {
        $builder = $this->modelsManager->createBuilder()
                          ->columns('full_name,username,email,roles,status,show_all_author')
                          ->from('MUsers');

        $dataTables = new DataTable();
        $dataTables->fromBuilder($builder)->sendResponse();
    }
    
    private function get_list_post_type($val=null){
        $form=new Form();
        $dt=MPostType::find();
        $select = new Select("list_post_type[]",$dt,['using'=>['post_type','post_title']]);
        if($val != null)
        {
            $select->setDefault($val);
        }
        return $form->add($select);
    }
    
    
    /**
     * get list roles (dropdown)
     */
    private function getListRoles($def_val=null){
        $form=new Form();
        $result=array();
        $dt=MRoles::find(['order'=>'roles_name ASC']);
        foreach($dt as $val){
            $result[$val->roles]=$val->roles_name;
        }
        
        $select = new Select("roles",$result,["useEmpty"  =>  false,"emptyText" =>  ""]);
        if($def_val != null){
            $select->setDefault($def_val);
        }
        return $form->add($select);
    }
    
    private function get_list_show_author($val=null){
        $form=new Form();
        $dt=array(
            'Y'=>'Y',
            'N'=>'N'
        );
        $select = new Select("list_show_author",$dt,["useEmpty"  =>  false,"emptyText" =>  "-"]);
        if($val != null)
        {
            $select->setDefault($val);
        }
        return $form->add($select);
    }
    
    private function get_list_author($val=null,$not_user=null)
    {
        $form=new Form();
        $dt=MUsers::find([
            "columns"=>"username,full_name",
            "username !='$not_user'"
        ]);
        $select = new Select("list_author[]",$dt,['using'=>['username','full_name']]);
        if($val != null)
        {
            $select->setDefault($val);
        }
        return $form->add($select);
    }
    
    /**
     * menampilkan laman tambah users dan proses tambah users
     */
    public function addAction()
    {
        if($this->request->isPost())
        {
            $this->view->disable();
            $username=Phalcon\Tag::friendlyTitle($this->request->getPost('username'),'.');
            $email=$this->request->getPost('email');
            $roles = $this->request->getPost('roles');
            $nama=$this->request->getPost('nama');
            $apt=$this->request->getPost('list_post_type');
            
            $users=MUsers::findFirstByusername($username);
            if($users)
            {
                $this->flashSession->error("username ".$username." sudah tersedia !!! ");
                $this->response->redirect('/users/add');
            }
            else
            {
                $acces_post_type=null;
                if(count($apt) > 0)
                {
                    $acces_post_type=json_encode($apt);
                }
                
                $show_all_author=$this->request->getPost('list_show_author');
                $list_author=$this->request->getPost('list_author');
                $mapping_author=null;
                
                if($show_all_author == 'N')
                {
                    if(count($list_author) > 0)
                    {
                        array_push($list_author,$username);
                        $mapping_author=json_encode($list_author);
                    }
                    else
                    {
                        $mapping_author=json_encode(array($username));
                    }
                }
                else
                {
                    $mapping_author="*";
                }
                $users=new MUsers();
                $users->full_name=$nama;
                $users->username=$username;
                $users->email=$email;
                $users->roles=$roles;
                $users->show_all_author=$show_all_author;
                $users->mapping_author=$mapping_author;
                $users->password=$this->security->hash(getenv('PASSDEFAULT'));
                $users->create_at=date('Y-m-d h:i:s');
                $users->acces_post_type=$acces_post_type;
                if($users->save())
                {
                    $this->flashSession->success("users ".$nama." berhasil ditambahkan !!! ");
                    $this->response->redirect('/users');
                }
            }
        }
        $this->myassets->assetsFormValidation();
        $this->myassets->chosen();
        $data['list_roles']=$this->getListRoles()->render('roles',['class'=>'form-control']);
        $data['list_show_author']=$this->get_list_show_author('Y')->render('list_show_author',['class'=>'form-control','id'=>'list_show_author','onchange'=>'show_list_author(this.value)']);
        $data['list_post_type']=$this->get_list_post_type()->render('list_post_type[]',['class'=>'form-control','id'=>'list_post_type','multiple'=>'multiple','data-placeholder'=>'-']);
        $data['list_author']=$this->get_list_author()->render('list_author[]',['class'=>'form-control','id'=>'list_author','multiple'=>'multiple','data-placeholder'=>'Author']);
        $this->view->setVar('data',(object)$data);
    }
    
    /**
     * menampilkan laman edit users dan proses edit users
     */
    public function editAction($username=false)
    {
        $this->view->setVar("title","Edit users");
        if($username != false)
        {
            $users=MUsers::findFirstByusername($username);
            if($users)
            {
                if($this->request->isPost())
                {
                    $email=$this->request->getPost('email');
                    $roles = $this->request->getPost('roles');
                    $status=$this->request->getPost('status');
                    $nama=$this->request->getPost('nama');
                    $apt=$this->request->getPost('list_post_type');
                    $acces_post_type=null;
                    if(count($apt) > 0)
                    {
                        $acces_post_type=json_encode($apt);
                    }
                    
                    $show_all_author=$this->request->getPost('list_show_author');
                    $list_author=$this->request->getPost('list_author');
                    $mapping_author=null;
                    
                    if($show_all_author == 'N')
                    {
                        if(count($list_author) > 0)
                        {
                            array_push($list_author,$username);
                            $mapping_author=json_encode($list_author);
                        }
                        else
                        {
                            $mapping_author=json_encode(array($username));
                        }
                    }
                    else
                    {
                        $mapping_author="*";
                    }
                    $users=MUsers::findFirstByusername($username);
                    $users->roles=$roles;
                    $users->status=$status;
                    $users->full_name=$nama;
                    $users->email=$email;
                    $users->acces_post_type=$acces_post_type;
                    $users->show_all_author=$show_all_author;
                    $users->mapping_author=$mapping_author;
                    $users->save();
                    $this->flashSession->notice("edit users ".$username." berhasil !!! ");
                    $this->response->redirect('/users');
                    
                }
                $this->myassets->select2();
                $access_post_type=null;
                if(count((array)$users->acces_post_type) > 0)
                {
                    $access_post_type=json_decode($users->acces_post_type);
                }
                
                $list_val_author=null;
                $dt_list_author=null;
                if($users->show_all_author == 'N')
                {
                    $list_val_author=json_decode($users->mapping_author);
                    if(count($list_val_author) > 0)
                    {
                        $dt_list_author=$list_val_author;
                    }
                }
                $this->myassets->chosen();
                $data['list_post_type']=$this->get_list_post_type($access_post_type)->render('list_post_type[]',['class'=>'form-control','id'=>'list_post_type','multiple'=>'multiple','data-placeholder'=>'-']);
                $data['list_roles']=$this->getListRoles($users->roles)->render('roles',['class'=>'form-control']);
                $data['list_show_author']=$this->get_list_show_author($users->show_all_author)->render('list_show_author',['class'=>'form-control','id'=>'list_show_author','onchange'=>'show_list_author(this.value)']);
                $data['list_author']=$this->get_list_author($dt_list_author,$username)->render('list_author[]',['class'=>'form-control','id'=>'list_author','multiple'=>'multiple','data-placeholder'=>'Author']);
                $data['users']=$users;
                $this->view->setVar("data",(object)$data);
            }
            else
            {
                $this->show404();
            }
        }
        else
        {
            $this->show404();
        }
    }
    
    public function deleteAction()
    {
        if($this->request->isAjax())
        {
            $username=$this->request->getPost('pk');
            $users=MUsers::findFirstByusername($username);
            $this->ajaxResponse->message="fitur delete belum aktif";
            $this->ajaxResponse->send();
        }
    }
}