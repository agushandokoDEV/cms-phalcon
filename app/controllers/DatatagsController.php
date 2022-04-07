<?php
use \DataTables\DataTable;
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Select;

class DatatagsController extends ControllerBase 
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
        $data['list_category']=$this->get_list_category(true)->render('list_category',['class'=>'form-control input-sm','id'=>'list_category','onchange'=>'filteringDt()']);
        $this->view->setVar("data",(object)$data);
    }
    
    /**
     * get all users on dataTable
     */
    private function all_data()
    {
        $type=$this->request->get('type');
        $w_type='';
        if($type !='')
        {
            $w_type="tags_type='$type'";
        }
        $builder = $this->modelsManager->createBuilder()
                          ->columns('tags_id,tags_title,tags_slug,tags_type')
                          ->from('MTags')
                          ->where($w_type);

        $dataTables = new DataTable();
        $dataTables->fromBuilder($builder)->sendResponse();
    }
    
    private function get_list_category($empty,$val=null){
        $form=new Form();
        $dt=MCategory::find();
        $select = new Select("list_category",$dt,["useEmpty"  =>  $empty,"emptyText" =>  "- Category -",'using'=>['slug','category']]);
        if($val != null)
        {
            $select->setDefault($val);
        }
        return $form->add($select);
    }
    
    public function addAction()
    {
        if($this->request->isPost())
        {
            $this->view->disable();
            $name=$this->request->getPost('tags_name');
            $type=$this->request->getPost('list_category');
            $slug=Phalcon\Tag::friendlyTitle($name,'-');
            $data=MTags::findFirst([
                "tags_slug=:slug: AND tags_type=:type:",
                "bind"=>[
                    "slug"=>$slug,
                    "type"=>$type
                ]
            ]);
            if($data)
            {
                $this->flashSession->error("tags ".$name." sudah tersedia !!! ");
                $this->response->redirect('/datatags/add');
            }
            else
            {
                $data=new MTags();
                $data->tags_title=$name;
                $data->tags_slug=$slug;
                $data->tags_type=$type;
                $data->save();
                $this->flashSession->success("tags ".$name." berhasil ditambahkan !!! ");
                $this->response->redirect('/datatags');
            }
        }
        else
        {
            $data['list_category']=$this->get_list_category(false)->render('list_category',['class'=>'form-control input-smx','id'=>'list_category']);
            $this->view->setVar("data",(object)$data);
        }
    }
    
    public function deleteAction()
    {
        $pk=$this->request->getPost('pk');
        if($this->request->isAjax())
        {
            $data=MTags::findFirstBytags_id($pk);
            if($pk != false || $data != false)
            {
                
                $this->rs->message="tags ".$data->tags_title." berhasil dihapus";
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