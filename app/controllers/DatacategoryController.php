<?php
use \DataTables\DataTable;
class DatacategoryController extends ControllerBase 
{
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
    
    private function all_data()
    {
        $builder = $this->modelsManager->createBuilder()
                          ->columns('id,category,slug')
                          ->from('MCategory');

        $dataTables = new DataTable();
        $dataTables->fromBuilder($builder)->sendResponse();
    }
    
    public function addAction()
    {
        if($this->request->isPost())
        {
            $this->view->disable();
            $name=$this->request->getPost('category_name');
            $slug=Phalcon\Tag::friendlyTitle($name,'-');
            $fetch=MCategory::findFirst([
                "slug=:slug:",
                "bind"=>[
                    "slug"=>$slug
                ]
            ]);
            if($fetch)
            {
                $this->flashSession->error("category ".$name." sudah tersedia !!! ");
                $this->response->redirect('/datacategory/add');
            }
            else
            {
                $fetch=new MCategory();
                $fetch->category=$name;
                $fetch->slug=$slug;
                $fetch->save();
                $this->flashSession->success("category ".$name." berhasil ditambahkan !!! ");
                $this->response->redirect('/datacategory');
            }
        }
    }
    
    public function editAction($pk=false)
    {
        $fetch=MCategory::findFirstByid($pk);
        if($pk ==false || $fetch !=true)
        {
            $this->show404();
        }
        if($this->request->isPost())
        {
            $this->view->disable();
            $fetch->category=$this->request->getPost('category_name');
            $fetch->save();
            $this->flashSession->notice("update category ".$name." OK !!! ");
            $this->response->redirect('/datacategory');
        }
        $data['row']=$fetch;
        $this->view->setVar("data",(object)$data);
    }
    
    public function deleteAction()
    {
        $pk=$this->request->getPost('pk');
        if($this->request->isAjax())
        {
            $data=MCategory::findFirstByid($pk);
            if($pk != '' || $data != false)
            {
                
                $this->rs->message="category ".$data->category." berhasil dihapus";
                $data->delete();
                $this->rs->success=true;
            }
            else
            {
                $this->rs->message="konten tidak tersedia";
            }
            
            $this->rs->send();
        }
        else
        {
            $this->show404();
        }
    }
}