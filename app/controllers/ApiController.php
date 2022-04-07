<?php
use Phalcon\Mvc\Controller;
class ApiController extends Controller
{
    private $limit=2;
    
    public function initialize()
    {
        
    }
    
    public function beforeExecuteRoute()
    {
        $this->view->disable();
    }
    
    public function afterExecuteRoute()
    {
        $this->response->setContentType("application/json");
        $this->response->setHeader("Access-Control-Allow-Origin", "*");
        $this->response->setHeader("Access-Control-Allow-Credentials", "true");
        $this->response->setRawHeader('HTTP/1.1 200 OK');
        $this->response->sendHeaders();
        $this->rs->send();
    }
    
    public function list_pageAction()
    {
        $data=CPost::find([
            "columns"=>"post_id,post_title,post_slug,post_parent,menu_order",
            "post_status = 'publish' AND post_type='page'",
            "order"=>"menu_order ASC"
        ]);
        $this->rs->success=true;
        $this->rs->data=$data;
    }
    
    public function detail_pageAction($post_slug)
    {
        $page=CPost::findFirst([
            "columns"=>"post_id,post_title,post_slug,post_content,post_create,post_cover,post_comment_status,post_language,publish_on,post_relation_lang",
            "post_slug=:slug: AND post_type='page'",
            "bind"=>[
                "slug"=>$post_slug
            ]
        ]);
        $data=null;
        if($page)
        {
            $data=array(
                'postid'=>$page->post_id,
                'post_title'=>$page->post_title,
                'post_slug'=>$page->post_slug,
                'post_content'=>$page->post_content,
                'list_media'=>$this->get_list_post_media($page->post_id)
            );
        }
        $this->rs->success=true;
        $this->rs->data=$data;
    }
    
    public function list_postingAction()
    {
        $page=$this->request->get('page');
        if($page == '')
        {
            $page=1;
        }
        $result=[];
        $total_rows=CPost::count([
            "post_status = 'publish' AND post_type !='page'"
        ]);
        $pages=ceil($total_rows / $this->limit);
        $start=($page - 1) * $this->limit;
        $data=$this->modelsManager->createBuilder()
            ->from("CPost")
            ->columns("
                CPost.post_id,
                CPost.post_title,
                CPost.post_slug,
                CPost.post_content,
                CPost.post_create,
                CPost.publish_on,
                CPost.post_category,
                CMedia.media_path,
                CMedia.media_guide")
            ->join("CMedia","CMedia.media_id=CPost.post_cover")
            ->where("CPost.post_status='publish' AND post_type !='page'")
            ->orderBy("CPost.publish_on DESC")
            ->limit($this->limit,$start)
            ->getQuery()
            ->execute();
        $result['total_rows']=$total_rows;
        $result['pages']=$pages;
        $result['data']=$data;
        
        $this->rs->success=true;
        $this->rs->data=$result;
    }
    
    public function search_postingAction()
    {
        $page=$this->request->get('page');
        $q=$this->request->get('q');
        if($page == '')
        {
            $page=1;
        }
        $result=[];
        $total_rows=CPost::count([
            "post_status = 'publish' AND post_type !='page' AND post_title LIKE '$q%'"
        ]);
        $pages=ceil($total_rows / $this->limit);
        $start=($page - 1) * $this->limit;
        $dataX=$this->modelsManager->createBuilder()
                ->from('CPost')
                ->columns("post_id,post_title,post_slug,post_content,post_create,post_cover,post_comment_status,post_language,publish_on,post_relation_lang")
                ->where("post_status = 'publish' AND post_type !='page' AND post_title LIKE '$q%'")
                ->limit($this->limit,$start)
                ->orderBy("post_id DESC")
                ->getQuery()
                ->execute();
        $data=$this->modelsManager->createBuilder()
            ->from("CPost")
            ->columns("
                CPost.post_id,
                CPost.post_title,
                CPost.post_slug,
                CPost.post_content,
                CPost.post_create,
                CPost.publish_on,
                CPost.post_category,
                CMedia.media_path,
                CMedia.media_guide")
            ->join("CMedia","CMedia.media_id=CPost.post_cover")
            ->where("post_status = 'publish' AND post_type !='page' AND post_title LIKE '$q%'")
            ->orderBy("CPost.publish_on DESC")
            ->limit($this->limit,$start)
            ->getQuery()
            ->execute();
                
        $result['total_rows']=$total_rows;
        $result['pages']=$pages;
        $result['data']=$data;
        
        $this->rs->success=true;
        $this->rs->data=$result;
    }
    
    public function list_post_by_tagsAction()
    {
        $page=$this->request->get('page');
        $tags=$this->request->get('tags');
        if($page == '')
        {
            $page=1;
        }
        $result=[];
        $total_rows=CPostCategory::count([
            "tags_slug = '$tags'"
        ]);
        $pages=ceil($total_rows / $this->limit);
        $start=($page - 1) * $this->limit;
        $data=$this->modelsManager->createBuilder()
                ->from('CPostCategory')
                ->columns("
                    CPost.post_id,
                    CPost.post_title,
                    CPost.post_slug,
                    CPost.post_content,
                    CPost.post_create,
                    CPost.post_cover,
                    CPost.post_comment_status,
                    CPost.post_language,
                    CPost.publish_on,
                    CPost.post_relation_lang")
                ->join("CPost","CPost.post_id=CPostCategory.post_id")
                ->where("CPostCategory.tags_slug = '$tags'")
                ->limit($this->limit,$start)
                ->orderBy("CPost.post_id DESC")
                ->getQuery()
                ->execute();
                
        $result['total_rows']=$total_rows;
        $result['pages']=$pages;
        $result['data']=$data;
        
        $this->rs->success=true;
        $this->rs->data=$result;
    }
    
    
    public function detail_postingAction($post_slug)
    {
        $p=CPost::findFirst([
            //"columns"=>"post_id,post_title,post_slug,post_content,post_create,post_cover,post_comment_status,post_language,publish_on,post_reminder,post_category,event_location_lat,event_location_long,event_location_name,event_location_addres,event_date_start,event_date_end",
            "post_slug=:slug: AND post_type !='page'",
            "bind"=>[
                "slug"=>$post_slug
            ]
        ]);
        if($p)
        {
            $data=array(
                'postid'=>$p->post_id,
                'post_title'=>$p->post_title,
                'post_slug'=>$p->post_slug,
                'post_content'=>$p->post_content,
                'publish_on'=>$p->publish_on,
                'post_category'=>$p->post_category,
                'post_reminder'=>$p->post_reminder,
                'event_location_name'=>$p->event_location_name,
                'event_location_addres'=>$p->event_location_addres,
                'event_date_start'=>$p->event_date_start,
                'event_date_end'=>$p->event_date_end,
                'event_location_lat'=>$p->event_location_lat,
                'post_category'=>$p->post_category,
                'post_cover'=>$this->get_row_media($p->post_cover),
                'list_media'=>$this->get_list_post_media($p->post_id)
            );
        }
        $this->rs->success=true;
        $this->rs->data=$data;
    }
    
    public function list_post_media_attachmentAction($post_id)
    {
        $data=$this->modelsManager->createBuilder()
            ->from("RRelationPostMedia")
            ->columns("
                CMedia.media_id,
                CMedia.media_type,
                CMedia.media_name,
                CMedia.media_date,
                CMedia.media_path,
                CMedia.file_size,
                CMedia.file_extension,
                CMedia.media_caption,
                CMedia.media_guide")
            ->join("CMedia","CMedia.media_id=RRelationPostMedia.media_id")
            ->where("RRelationPostMedia.post_id=$post_id")
            ->getQuery()
            ->execute();
            
        $this->rs->success=true;
        $this->rs->data=$data;
    }
    
    public function list_tagsAction()
    {
        $data=MTags::find([
            "columns"=>"tags_title,tags_slug",
            "order"=>"tags_title ASC"
        ]);
        $this->rs->success=true;
        $this->rs->data=$data;
    }
    
    public function list_post_relatedAction()
    {
        $page=$this->request->get('page');
        $post_id=$this->request->get('post_id');
        if($page == '')
        {
            $page=1;
        }
        $result=[];
        $total_rows=RRelationTags::count([
            "post_parent=$post_id"
        ]);
        $pages=ceil($total_rows / $this->limit);
        $start=($page - 1) * $this->limit;
        $data=$this->modelsManager->createBuilder()
            ->from("RRelationTags")
            ->columns("
                CPost.post_id,
                CPost.post_title,
                CPost.post_slug,
                CPost.post_content,
                CPost.post_create,
                CPost.post_cover,
                CPost.post_comment_status,
                CPost.post_language,
                CPost.publish_on,
                CPost.post_relation_lang")
            ->join("CPost","CPost.post_id=RRelationTags.post_id")
            ->where("RRelationTags.post_parent=$post_id")
            ->orderBy("CPost.post_id DESC")
            ->limit($this->limit,$start)
            ->getQuery()
            ->execute();
        
        $result['total_rows']=$total_rows;
        $result['pages']=$pages;
        $result['data']=$data;
        
        $this->rs->success=true;
        $this->rs->data=$result;
    }
    
    public function list_post_dateAction()
    {
        $data=CPost::find([
            "columns"=>"DATE_FORMAT(publish_on, '%Y-%m') as publish_date",
            "post_type !='page' AND post_status='publish' AND DATE_FORMAT(publish_on,'%Y')='".date('Y')."'",
            "group"=>"publish_date"
        ]);
        $this->rs->success=true;
        $this->rs->data=$data;
    }
    
    public function list_post_by_dateAction()
    {
        $page=$this->request->get('page');
        $date=$this->request->get('date');
        if($page == '')
        {
            $page=1;
        }
        $result=[];
        $total_rows=CPost::count([
            "post_status = 'publish' AND post_type !='page' AND DATE_FORMAT(publish_on,'%Y-%m')='$date'"
        ]);
        $pages=ceil($total_rows / $this->limit);
        $start=($page - 1) * $this->limit;
        $data=$this->modelsManager->createBuilder()
                ->from('CPost')
                ->columns("post_id,post_title,post_slug,post_content,post_create,post_cover,post_comment_status,post_language,publish_on,post_relation_lang")
                ->where("post_status = 'publish' AND post_type !='page' AND DATE_FORMAT(publish_on,'%Y-%m')='$date'")
                ->limit($this->limit,$start)
                ->orderBy("post_id DESC")
                ->getQuery()
                ->execute();
                
        $result['total_rows']=$total_rows;
        $result['pages']=$pages;
        $result['data']=$data;
        
        $this->rs->success=true;
        $this->rs->data=$result;
    }
    
    private function get_list_post_media($post_id)
    {
        $data=$this->modelsManager->createBuilder()
            ->from("RRelationPostMedia")
            ->columns("
                CMedia.media_type,
                CMedia.media_name,
                CMedia.media_path,
                CMedia.media_caption,
                CMedia.media_path,
                CMedia.media_guide")
            ->join("CMedia","CMedia.media_id=RRelationPostMedia.media_id")
            ->where("RRelationPostMedia.post_id=$post_id")
            ->getQuery()
            ->execute();
        $rs=[];
        if(count($data) > 0)
        {
            foreach($data as $m)
            {
                $rs[]=array(
                    'media_type'=>$m->media_type,
                    'media_name'=>$m->media_name,
                    'media_caption'=>$m->media_caption,
                    'media_guide'=>$m->media_guide,
                    'media_uri'=>array(
                        'xs'=>$this->mymedia->get_img_uri($m->media_guide,'xs'),
                        'sm'=>$this->mymedia->get_img_uri($m->media_guide,'sm'),
                        'md'=>$this->mymedia->get_img_uri($m->media_guide,'md'),
                        'lg'=>$this->mymedia->get_img_uri($m->media_guide,'lg'),
                        'xlg'=>$this->mymedia->get_img_uri($m->media_guide,'xlg')
                    )
                );
            }
        }
        return $rs;
    }
    
    private function get_row_media($media_id)
    {
        $m=CMedia::findFirstBymedia_id($media_id);
        $rs=null;
        if($m)
        {
            $rs=array(
                'media_type'=>$m->media_type,
                'media_name'=>$m->media_name,
                'media_caption'=>$m->media_caption,
                'media_guide'=>$m->media_guide,
                'media_uri'=>array(
                    'xs'=>$this->mymedia->get_img_uri($m->media_guide,'xs'),
                    'sm'=>$this->mymedia->get_img_uri($m->media_guide,'sm'),
                    'md'=>$this->mymedia->get_img_uri($m->media_guide,'md'),
                    'lg'=>$this->mymedia->get_img_uri($m->media_guide,'lg'),
                    'xlg'=>$this->mymedia->get_img_uri($m->media_guide,'xlg')
                )
            );
        }
        return $rs;
    }
}