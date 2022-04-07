<?php
use \DataTables\DataTable;
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Select;
use Phalcon\Db;

class PostController extends ControllerBase
{
    public function indexAction($type=false,$param=false)
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
        $this->set_var_posttype($type);
        $this->myassets->assetDataTable();
        $data['list_post_author']=$this->get_list_post_author()->render('list_post_author',['class'=>'form-control input-sm','id'=>'list_post_author','onchange'=>'filteringDt()']);
        $data['list_category']=$this->get_list_category(true)->render('list_category',['class'=>'form-control input-sm','id'=>'list_category','onchange'=>'filteringDt()']);
        $this->view->setVar("data",(object)$data);
    }
    
    private function get_all_data()
    {
        $type=$this->request->get('type');
        $author=$this->request->get('author');
        $status=$this->request->get('status');
        $category=$this->request->get('category');
        
        $qry='';
        if($author !='')
        {
            $qry .="AND CPost.post_author ='$author'";
        }
        if($status !='')
        {
            $qry .="AND CPost.post_status ='$status'";
        }
        if($category !='')
        {
            $qry .="AND CPost.post_category ='$category'";
        }
        $builder = $this->modelsManager->createBuilder()
                      ->columns('
                        CPost.post_id, 
                        CPost.post_title,
                        CPost.post_status,
                        CPost.post_create,
                        CPost.publish_on,
                        CPost.post_author,
                        CPost.post_language,
                        MUsers.full_name,
                        MC.category')
                      ->where("post_type =:type: AND post_status !='autosave' AND custom_url='N' $qry ",
                        [
                            "type"=>$type
                        ]
                      )
                      ->from('CPost')
                      ->join('MUsers','MUsers.username=CPost.post_author')
                      ->join('MCategory','MC.slug=CPost.post_category','MC','LEFT');

        $dataTables = new DataTable();
        $dataTables->fromBuilder($builder)->sendResponse();
    }
    
    /**
     * get list list post author (dropdown)
     */
    private function get_list_post_author(){
        $form=new Form();
        $dt=[];
        $empty=false;
        if($this->auth->show_all_author == 'Y')
        {
            $empty=true;
            $dt=MUsers::find([
                'columns'=>'username,full_name',
                'status=1',
                'order'=>'full_name ASC'
            ]);
        }
        else
        {
            if(count($this->auth->mapping_author) > 0)
            {
                $dt = $this->modelsManager->createBuilder()
                      ->columns('username,full_name')
                      ->from('MUsers')
                      ->inWhere('username',$this->auth->mapping_author)
                      ->orderBy('full_name ASC')
                      ->getQuery()
                      ->execute();
            }
        }
        
        $select = new Select("list_post_author",$dt,["useEmpty"  =>  $empty,"emptyText" =>  "All Author",'using'=>['username','full_name']]);
        $select->setDefault($this->auth->username);
        return $form->add($select);
    }
    
    /**
     * list post tage
     */
    private function get_list_post_tags($type=false){
        $form=new Form();
        //$dt=MTags::find();
        $dt=MTags::find([
            "columns"=>"tags_title",
            "order"=>"tags_title ASC"
        ]);
        $select = new Select("list_post_tags[]",$dt,['using'=>['tags_title','tags_title']]);
        return $form->add($select);
    }
    
    /**
     * list category post
     */
    private function get_list_category($empty,$val=null)
    {
        $form=new Form();
        $dt=MCategory::find();
        $select = new Select("list_category",$dt,["useEmpty"  =>  $empty,"emptyText" =>  "Category",'using'=>['slug','category']]);
        if($val != null)
        {
            $select->setDefault($val);
        }
        return $form->add($select);
    }
    
    /**
     * insert tags/kategori
     */
    private function insert_post_tags(){
        $dt_tags=$this->request->getPost('dt_tags');
        $type=$this->request->getPost('post_type');
        if(count($dt_tags) > 0)
        {
            foreach($dt_tags as $k=>$v)
            {
                if($v != '')
                {
                    $slug=Phalcon\Tag::friendlyTitle($v, "-");
                    $cek_slug=MTags::findFirst([
                        "tags_slug=:slug:",
                        "bind"=>[
                            "slug"=>$slug
                        ]
                    ]);
                    
                    if(!$cek_slug)
                    {
                        $data=new MTags();
                        $data->tags_title=$v;
                        $data->tags_slug=$slug;
                        $data->tags_type=$type;
                        $data->save();
                    }
                }
            }
        }
        $this->rs->success=true;
        $this->rs->data=$dt_tags;
        $this->rs->send();
    }
    
    /**
     * get list post type
     */
    private function get_post_type($type)
    {
        $data=MPostType::findFirst([
            "columns"=>"post_type,post_title,post_icon",
            "post_type=:type:",
            "bind"=>[
                "type"=>$type
            ]
        ]);
        return $data;
    }
    
    private function list_post_relation()
    {
        $post_lang=$this->request->get('lang');
        $keyword=$_GET['data']['q'];
        $data=CPost::find([
            "post_title LIKE '%$keyword%'",
            //"bind"=>["lang"=>$post_lang],
            "columns"=>"post_id as id,post_title as text",
            "limit"=>5,
            "order"=>"post_title ASC"
        ]);
        if(count($data) <= 0)
        {
            $data=[];
        }
        echo json_encode(array("q"=>$keyword,"results"=>$data));
    }
    
    private function set_var_posttype($type)
    {
        $post_type=$this->get_post_type($type);
        if($type == false OR $post_type === false)
        {
            $this->show404();
        }
        else
        {
            if(in_array($type,$this->auth->my_post_type))
            {
                $this->view->setVar("row_post",$post_type);
            }
            else
            {
                $this->show404();
            }
        }
    }
    
    private function create_post($type,$status)
    {
        $data=new CPost();
        $title="Auto Save";
        $data->post_author=$this->auth->username;
        $data->post_type=$type;
        $data->post_status=$status;
        $data->post_title=$title;
        $data->post_slug=Phalcon\Tag::friendlyTitle($title, "_");
        $data->save();
        return $data;
    }
    
    
    private function auto_slug($title,$postid)
    {
        $notin='';
        if($postid !='')
        {
            $notin="AND post_id !=$postid";
        }
        $slug = Phalcon\Tag::friendlyTitle($title, "-");
        $data = CPost::count([
            "conditions"=>"post_slug LIKE '$slug%' $notin",
        ]);
        $rs=$slug;
        if($data > 0)
        {
            $num = $data + 1;
            $rs=$slug.'-'.$num;
        }
        return $rs;
    }
    
    private function get_post_slug()
    {
        $title=$this->request->get('post_title');
        $post_id=$this->request->get('postid');
        $this->rs->success=true;
        $this->rs->data=$this->auto_slug($title,$post_id);
        $this->rs->send();
    }
    
    private function save_post($postid,$type,$edit=false)
    {
        
        if($postid != null)
        {
            $data=CPost::findFirstBypost_id($postid);
            //$data->post_modified_by=$this->auth->username;
        }
        else
        {
            $data=new CPost();
        }
        
        $data->post_language=$this->request->getPost('post_lang');
        $slug=$this->request->getPost('post_slug');
        $tags=$this->request->getPost('list_post_tags');
        $cover=$this->request->getPost('media_cover');
        $attach=$this->request->getPost('list_media_attch');
        $category=$this->request->getPost('list_category');
        $reminder=$this->request->getPost('input_reminder');
        $event_start=$this->request->getPost('event_start');
        $event_end=$this->request->getPost('event_end');
        $schedule=$this->request->getPost('schedule');
        $title=$this->request->getPost('title');
        $status=$this->request->getPost('status');
        //var_dump($reminder);
        //exit;
        if($event_start == '')
        {
            $event_start=null;
        }
        if($event_end == '')
        {
            $event_end=null;
        }
        if($reminder == '')
        {
            $reminder='N';
            $event_start=null;
            $event_end=null;
        }
        if($status == 'publish' || $schedule == '')
        {
            $schedule=null;
        }
        
        if($cover == '')
        {
            $cover=null;
        }

        if($status == 'publish')
        {
            if($data->publish_on == null)
            {
                $data->publish_on=date('Y-m-d H:i:s');
            }
        }
        
        //$data->post_reference=null;
        if($type !='page')
        {
            $this->db->execute("DELETE FROM c_post_category WHERE post_id=$postid");
            if(count($tags) > 0)
            {
                //$data->post_reference=implode(",",$tags);
                //$this->db->execute("DELETE FROM c_post_category WHERE post_id=$postid");
                foreach($tags as $tagsv)
                {
                    $vtags=new CPostCategory();
                    $vtags->post_id=$postid;
                    $vtags->tags_slug=Phalcon\Tag::friendlyTitle($tagsv,'-');
                    $vtags->tags_title=$tagsv;
                    $vtags->catagory=$category;
                    $vtags->save();
                   
                }
            }
        }
        //echo $status;
        //exit;
        $data->post_title=addslashes($title);
        $data->event_location_name=$this->request->getPost('location-name');
        $data->event_location_addres=$this->request->getPost('location-addres');
        $data->event_location_lat=$this->request->getPost('location-lat');
        $data->event_location_long=$this->request->getPost('location-long');
        $data->post_reminder=$reminder;
        $data->event_date_start=$event_start;
        $data->event_date_end=$event_end;
        $data->post_cover=$cover;
        $data->post_slug=$slug;
        $data->post_type=$type;
        $data->post_content=$this->request->getPost('content');
        $data->post_status=$status;
        $data->post_category=$category;
        $data->publish_schedule=$schedule;
        
        $activity="add new post ($type) $data->post_title";
        if($edit)
        {
            $data->post_modified=date('Y-m-d H:i:s');
            $data->post_modified_by=$this->auth->username;
            $activity="edit post ($type) $data->post_title";
        }
        
        $this->db->execute("DELETE FROM r_relation_post_media WHERE post_id=$postid");
        if(count($attach) > 0)
        {
            foreach($attach as $k=>$m)
            {
                if($m != '')
                {
                    $cekM=RRelationPostMedia::findFirst([
                        "post_id=:postid: AND media_id=:mediaid:",
                        "bind"=>[
                            "postid"=>$postid,
                            "mediaid"=>$m
                        ]
                    ]);
                    if(!$cekM)
                    {
                        $m_attach=new RRelationPostMedia();
                        $m_attach->post_id=$postid;
                        $m_attach->media_id=$m;
                        $m_attach->save();
                    }
                }
                
            }
        }
        $this->set_activity($activity);
        return $data->update();
    }
    
    /**
     * get list mime type
     */
    private function get_list_mime_type()
    {
        $form=new Form();
        $rs=array();
        $data=array_keys($this->mymedia->list_mime());
        foreach($data as $k)
        {
            $rs[$k]=ucfirst($k);
        }
        $select = new Select("list_mime_type",$rs,["useEmpty"  =>  true,"emptyText" =>  "-"]);
        return $form->add($select);
    }
    
    private function TagstoJson($data=[]){
        $result='';
        if(count($data) > 0){
            $result=explode(",",$data);
        }
        return json_encode($result);
    }
    
    public function addAction($type)
    {
        if($this->request->isPost())
        {
            $this->view->disable();
            $postid=$this->request->getPost('post_id');
            if(!$this->save_post($postid,$type))
            {
                throw new Exception("terjadi kesalahan pada server");
            }
            $this->flashSession->success($type." ".$this->request->getPost('title')." berhasil ditambahkan !!! ");
            $this->response->redirect('/post/index/'.$type);
        }
        else
        {
            $this->myassets->jstree();
            $this->myassets->datepicker();
            $this->myassets->select2();
            $this->myassets->chosenAjax();
            $this->myassets->dateTimePicker();
            $this->myassets->prismjs();
            $this->assets
                ->collection("jsHeader")
                ->addJs("plugin/tinymce/tinymce.min.js")
                ->addJs("plugin/jquery.form.min.js")
                ->addJs("plugin/jscroll/jquery.jscroll.js")
                ->addJs("plugin/backdetect/jquery.backDetect.min.js")
                ->addJs($this->config->api->google->maps->src);
                
            $newpost=$this->create_post($type,'autosave');
            $this->set_var_posttype($type);
            $this->view->setVar('list_mime_type',$this->get_list_mime_type()->render('list_mime_type',['class'=>'form-control input-sm','id'=>'list-mime-insert']));
            $this->view->setVar('list_post_tags',$this->get_list_post_tags($type)->render('list_post_tags[]',['class'=>'form-control input-sm','id'=>'list-post-tags','multiple'=>'multiple']));
            $this->view->setVar('list_category',$this->get_list_category(true)->render('list_category',['class'=>'form-control','id'=>'list_category']));
            $this->view->setVar('data',$newpost);
        }
    }
    
    public function editAction($type,$postid)
    {
        $cek_post=CPost::findFirst([
            "post_id=:post_id: AND post_type=:type:",
            "bind"=>[
                "post_id"=>$postid,
                "type"=>$type
            ]
        ]);
        if($this->auth->show_all_author == 'N')
        {
            if(!in_array($cek_post->post_author,$this->auth->mapping_author))
            {
                $this->show404();
            }
        }
        if(!$cek_post)
        {
            $this->show404();
        }
        if($this->request->isPost())
        {
            $this->view->disable();
            $postid=$this->request->getPost('post_id');
            if(!$this->save_post($postid,$type,true))
            {
                throw new Exception("terjadi kesalahan pada server");
            }
            $this->flashSession->notice("update ".$type." ".$this->request->getPost('title')." berhasil !!! ");
            $this->response->redirect('/post/index/'.$type);
        }
        else
        {
            
            $this->myassets->jstree();
            $this->myassets->datepicker();
            $this->myassets->select2();
            $this->myassets->chosenAjax();
            $this->myassets->dateTimePicker();
            $this->myassets->prismjs();
            $this->assets
                ->collection("jsHeader")
                ->addJs("plugin/tinymce/tinymce.min.js")
                ->addJs("plugin/jquery.form.min.js")
                ->addJs("plugin/jscroll/jquery.jscroll.js")
                ->addJs("plugin/backdetect/jquery.backDetect.min.js")
                ->addJs($this->config->api->google->maps->src);
                
            $post_cover='';
            $newpost=CPost::findFirstBypost_id($postid);
            if($newpost->post_cover !='')
            {
                $media=CMedia::findFirstBymedia_id($newpost->post_cover);
                $post_cover='<img title="'.$media->media_caption.'" class="img-thumbnail" src="'.$media->media_path.'" style="width: 100%;height: 200px;"/> <a href="javascript:void(0)" onclick="delete_selected_cover()">Remove cover</a>';
            }
            $list_media_attach=[];
            $list_media_dr_attach=[];
            $dt_media_attach=$this->modelsManager->createBuilder()
                ->from("RRelationPostMedia")
                ->join("CMedia","CMedia.media_id=RRelationPostMedia.media_id")
                ->where("RRelationPostMedia.post_id=:postid:",
                    [
                        "postid"=>$postid
                    ]
                )
                ->getQuery()
                ->execute();
            if(count($dt_media_attach) > 0)
            {
                $ar_attch_id=[];
                $ar_media=[];
                foreach($dt_media_attach as $m)
                {
                    $ar_attch_id[]=$m->media_id;
                    $list_media_dr_attach[]=array(
                        'media_id'=>$m->media_id,
                        'media_type'=>$m->media_type,
                        'media_author'=>$m->media_author,
                        'media_date'=>$m->media_date,
                        'media_path'=>$m->media_path,
                        'media_caption'=>$m->media_caption
                    );
                }
                $list_media_attach=array_values($ar_attch_id);
            }
            $list_tags='';
            $dt_tags=CPostCategory::find([
                "columns"=>"tags_title",
                "post_id=:postid:",
                "bind"=>[
                    "postid"=>$postid
                ]
            ]);
            if(count($dt_tags) > 0)
            {
                $list_tags=[];
                foreach($dt_tags as $tags)
                {
                    $list_tags[]=$tags->tags_title;
                }
                $list_tags=json_encode($list_tags);
            }
            $data['row']=$newpost;
            $data['data_post_tags']=$list_tags;
            $data['post_cover']=$post_cover;
            $data['list_attach']=join(',',$list_media_attach);
            $data['list_dt_attach']=$list_media_dr_attach;
            $this->set_var_posttype($type);
            $this->view->setVar('list_mime_type',$this->get_list_mime_type()->render('list_mime_type',['class'=>'form-control input-sm','id'=>'list-mime-insert']));
            $this->view->setVar("list_post_tags",$this->get_list_post_tags($type)->render('list_post_tags[]',['class'=>'form-control input-sm','id'=>'list-post-tags','multiple'=>'multiple']));
            $this->view->setVar('list_category',$this->get_list_category(true,$newpost->post_category)->render('list_category',['class'=>'form-control','id'=>'list_category']));
            $this->view->setVar("data",(object)$data);
        }
    }
    
    public function deleteAction($type)
    {
        if($this->request->isAjax())
        {
            $postid=$this->request->getPost('postid');
            $data=CPost::findFirstBypost_id($postid);
            if($this->auth->show_all_author == 'N')
            {
                if(!in_array($data->post_author,$this->auth->mapping_author))
                {
                    throw new Exception("Maaf anda tidak punya akses untuk hapus data ini");
                }
            }
            $data->delete();
            $this->rs->success=true;
            $this->rs->message="$type $data->post_title berhasil dihapus";
            $this->rs->send();
            $this->set_activity("delete post ($type) $data->post_title");
        }
        else
        {
            $this->show404();
        }
    }
    
    private function insert_to_editor()
    {
        $media=(object)$this->request->get('dt_media');
        $data=$this->mymedia->get_media_uri($media->media_guide,$media->media_type,$media->media_path,'lg');
        $this->rs->success=true;
        $this->rs->data=$data;
        $this->rs->send();
    }
    
    private function list_media_attach()
    {
        $dt_media=$this->request->get('media_attach');
        $rs='';
        if(count($dt_media) > 0)
        {
            foreach($dt_media as $k=>$v)
            {
                $media=CMedia::findFirstBymedia_id($v);
                if($media)
                {
                    $img_uri=$this->mymedia->get_media_uri($media->media_guide,$media->media_type,$media->media_path,'xs');
                    $rs .='
                        <li class="item" id="media-list-item-'.$media->media_id.'">
                          <div class="product-img">
                            '.$img_uri.'
                          </div>
                          <div class="product-info">
                            <div class="product-title">'.$media->media_caption.'
                              <a onclick="del_item_media_attach('."'".$media->media_id."'".')" href="javascript:void(0)" class="label label-danger pull-right"><i class="fa fa-trash"></i></a></div>
                                <span class="product-description text-sm">Author : '.$media->media_author.'</span>
                          </div>
                        </li>
                    ';
                }
            }
        }
        $this->rs->success=true;
        $this->rs->data=$rs;
        $this->rs->send();
    }
}