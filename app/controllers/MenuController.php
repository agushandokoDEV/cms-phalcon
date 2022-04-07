<?php
use \DataTables\DataTable;
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Select;

class MenuController extends ControllerBase
{
    /**
     * asset yg digunakan pada controller menu
     */
    private function assetMenu()
    {
        $this->assets->collection("cssHeader")
            ->addCss('plugin/selectpicker/bootstrap-select.min.css');
        $this->assets->collection('jsHeader')
            ->addJs('plugin/selectpicker/bootstrap-select.min.js');
    }
    
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
    
    private function savi_icon()
    {
        $icon=$this->request->getPost('ic');
        $new=new MIcon();
        $new->icon_name=$icon;
        if($new->save())
        {
            $this->rs->success=true;
        }
        $this->rs->send();
    }            
    
    /**
     * get all menu on dataTable
     */
    private function all_data()
    {
        $builder = $this->modelsManager->createBuilder()
                      ->columns('menu_id,menu_title,show_menu,description,resources_name,access_name,icon')
                      ->from('MMenu');

        $dataTables = new DataTable();
        $dataTables->fromBuilder($builder)->sendResponse();
    }
    
    /**
     * list menu parent (dropdown)
     */
    private function getMenuPage($def=false,$notin=false)
    {
        $form=new Form();
        $result=array();
        $not='';
        if($notin != false){
            $not = "AND menu_id != $notin";
        }
        $dt=MMenu::find([
            "show_menu = 'Y' AND menu_parent_id=0",
            'order'=>'menu_title ASC',
        ]);
        foreach($dt as $val){
            $result[$val->menu_id]=$val->menu_title;
        }
        $select = new Select("menu_parent",$result,["useEmpty"  =>  true,"emptyText" =>  "-"]);
        if($def != false){
            $select->setDefault($def);
        }
        return $form->add($select);
    }
    
    
    /**
     * menampilkan laman tambah menu dan proses tambah menu
     */
    public function addAction()
    {
        if($this->request->isPost())
        {
            $this->view->disable();
            $parent=$this->request->get('parent_only');
            if($parent == 'Y')
            {
                $data=MMenu::findFirst([
                    "menu_title=:menu_title:",
                    "bind"=>[
                        "menu_title"=>$this->request->getPost('title')
                    ]
                ]);
                if(!$data)
                {
                    $randstr = new \Phalcon\Security\Random();
                    $newdata=new MMenu();
                    $newdata->menu_title=$this->request->getPost('title');
                    $newdata->menu_parent_id=0;
                    $newdata->resources_name='-'.$randstr->hex(10);;
                    $newdata->access_name='index';
                    $newdata->description=$this->request->getPost('deskripsi');
                    $newdata->show_menu='Y';
                    $newdata->icon=$this->request->getPost('icon');
                    $newdata->parent_only='Y';
                    $newdata->save();
                    $this->flashSession->success("menu ".$this->request->getPost('title')." berhasil ditambahkan");
                    $this->response->redirect('/menu');
                }
                else
                {
                    $this->flashSession->error("menu parent ".$this->request->getPost('title')." sudah tersedia..");
                    $this->response->redirect('/menu/add');
                }
            }
            else
            {
                $resources=$this->request->getPost('resources');
                $access=$this->request->getPost('access');
                if($access == '*')
                {
                    $modul=array('add','index','edit','delete');
                
                    $icon['index']=$this->request->getPost('icon');
                    $icon['add']='fa fa-plus';
                    $icon['edit']='fa fa-pencil';
                    $icon['delete']=null;
                    
                    $desk['index']=$this->request->getPost('deskripsi');
                    $desk['add']='tambah data';
                    $desk['edit']='edit data';
                    $desk['delete']='delete data';
                    
                    $title['index']=$this->request->getPost('title');
                    $title['add']='tambah data';
                    $title['edit']='edit data';
                    $title['delete']='delete data';
                    
                    foreach($modul as $k)
                    {
                        $data=MMenu::findFirst([
                            "resources_name=:resources: AND access_name=:access:",
                            "bind"=>[
                                "resources"=>$resources,
                                "access"=>$k
                            ]
                        ]);
                        
                        if(!$data)
                        {
                            if($k == "index")
                            {
                                $show_menu="Y";
                            }
                            else
                            {
                                $show_menu="N";
                            }
                            
                            $data=new MMenu();
                            $data->menu_title=$title[$k];
                            $data->menu_parent_id=0;
                            $data->resources_name=$resources;
                            $data->access_name=$k;
                            $data->description=$desk[$k];
                            $data->show_menu=$show_menu;
                            $data->icon=$icon[$k];
                            if($data->save())
                            {
                                $modules=new ModulGenerate($resources);
                                $modules->execute();
                            }
                        }
                    }
                    $this->flashSession->success("modul ".$resources." berhasil ditambahkan");
                    $this->response->redirect('/menu');
                }
                else
                {
                    $data=MMenu::findFirst([
                        "resources_name=:resources: AND access_name=:access:",
                        "bind"=>[
                            "resources"=>$resources,
                            "access"=>$access
                        ]
                    ]);
                    if(!$data)
                    {
                        if($access == "index")
                        {
                            $show_menu="Y";
                        }
                        else
                        {
                            $show_menu="N";
                        }
                        $data=new MMenu();
                        $data->menu_title=$this->request->getPost('title');
                        $data->menu_parent_id=0;
                        $data->resources_name=$resources;
                        $data->access_name=$access;
                        $data->description=$this->request->getPost('deskripsi');
                        $data->show_menu=$show_menu;
                        $data->icon=$this->request->getPost('icon');
                        if($data->save() == true && $access=='index')
                        {
                            $modules=new ModulGenerate($resources);
                            $modules->execute();
                        }
                        $this->flashSession->success("modul ".$resources."/".$access." berhasil ditambahkan");
                        $this->response->redirect('/menu');
                    }
                    else
                    {
                        $this->flashSession->error("modul ".$resources."/".$access." sudah tersedia..");
                        $this->response->redirect('/menu/add');
                    }
                }
            }
        }
        $this->assetMenu();
        $this->myassets->assetsFormValidation();
        $this->view->setVar("list_icon",MIcon::find(['order'=>'icon_name ASC']));
        $datax['menu_parent'] = $this->getMenuPage()->render('menu_parent',['class'=>'form-control','id'=>'menu_parent']);
        $this->view->data=$datax;
    }
    
    /**
     * menampilkan laman edit menu dan proses edit menu
     */
    public function editAction($menu_id=false)
    {
        $this->view->setVar("title","Edit Resources");
        if(!$menu_id)
        {
            throw new Exception("Menu tidak tersedia");
        }
        else
        {
            $data=MMenu::findFirst([
                "menu_id=:menu_id:",
                "bind"=>[
                    "menu_id"=>$menu_id
                ]
            ]);
            if($this->request->isPost())
            {   
                //$access=$this->request->getPost('access');
                
                //$desk=$this->request->getPost('deskripsi');
                //$menu_parent=$this->request->getPost('menu_parent');
                //$data->show_menu=$show_menu;
                $data->description=$this->request->getPost('deskripsi');
                $data->menu_title=$this->request->getPost('title');
                //$data->menu_parent_id=$menu_parent;
                $data->icon=$this->request->getPost('icon');
                if($data->save())
                {
                    $this->flashSession->notice("edit data berhasil");
                    $this->response->redirect('/menu');
                }
            }
            $this->assetMenu();
            $this->view->setVar("resources",$data);
            $this->view->setVar("list_icon",MIcon::find(['order'=>'icon_name ASC']));
            $datax['menu_parent'] = $this->getMenuPage($data->menu_parent_id,$menu_id)->render('menu_parent',['class'=>'form-control','id'=>'menu_parent']);
            $this->view->data=$datax;
        }
    }
    
    /**
     * delete menu
     */
    public function deleteAction()
    {
        if($this->request->isAjax())
        {
            $pk=$this->request->getPost('pk');
            $access=MMenu::findFirst([
                "menu_id=:menu_id:",
                "bind"=>[
                    "menu_id"=>$pk
                ]
            ]);
            $accessList=MAccessList::findFirst([
                "resources_name=:resources: AND access_name=:access:",
                "bind"=>[
                    "resources"=>$access->resources_name,
                    "access"=>$access->access_name
                ]
            ]);
            if($access->delete())
            {
                if($accessList)
                {
                    $accessList->delete();
                }
                
                $this->rs->success=true;
                $this->rs->message="data berhasil dihapus";
            }
            else
            {
                $this->rs->message="data gagal dihapus";
            }
            $this->rs->send();
        }
    }
}