<?php

class PostingtypeController extends ControllerBase
{
    public function indexAction()
    {
        $data=MPostType::find();
        $this->view->setVar("list_type",$data);
    }
    
    public function addAction()
    {
        if($this->request->isPost())
        {
            $this->view->disable();
            $type=$this->request->getPost('type');
            $desc=$this->request->getPost('description');
            $data=MPostType::findFirstBypost_type($type);
            if($data)
            {
                $this->flashSession->error("type ".$type." sudah tersedia !!! ");
                $this->response->redirect('/postingtype/add');
            }
            else
            {
                $data=new MPostType();
                $data->post_title=$this->request->getPost('title');
                $data->post_icon=$this->request->getPost('icon');
                $data->post_type=$type;
                $data->post_type_des=$desc;
                $data->save();
                $this->flashSession->success("type ".$type." berhasil ditambahkans !!! ");
                $this->response->redirect('/postingtype');
            }
        }
        $this->myassets->selectPicker();
        $this->myassets->assetsFormValidation();
        $this->view->setVar("list_icon",MIcon::find(['order'=>'icon_name ASC']));
    }
    
    public function editAction($pk)
    {
        $data=MPostType::findFirstBypost_type($pk);
        if($data)
        {
            $menu=MMenu::findFirst([
                "resources_name='post' AND access_name=:access_name:",
                "bind"=>[
                    "access_name"=>$pk
                ]
            ]);
            $this->myassets->selectPicker();
            $this->view->setVar("list_icon",MIcon::find(['order'=>'icon_name ASC']));
            $this->view->setVar("data",$data);
            $this->view->setVar("data_menu",$menu);
            if($this->request->isPost())
            {
                $this->view->disable();
                $data->post_title=$this->request->getPost('title');
                $data->post_icon=$this->request->getPost('icon');
                $desc=$this->request->getPost('description');
                $status=$this->request->getPost('status');
                $data->post_type_des=$desc;
                $data->post_type_status=$status;
                $data->update();
                $this->flashSession->success("type ".$type." berhasil diubah !!! ");
                $this->response->redirect('/postingtype');
            }
        }
        else
        {
            throw new Exception("post type tidak tersedia");
        }
    }
}