<?php
use Phalcon\Mvc\Controller;

class FrontendController extends Controller
{
    protected $template='mytemplate';
    protected $title='Home';
    protected $path_assets;
    
    public function beforeExecuteRoute()
    {
        
        $template_active=MTemplate::findFirst([
            "active=1"
        ]);
        $this->path_assets='/site/'.$this->template;
        if($template_active)
        {
            $this->template=$template_active->name;
            $this->path_assets='/site/'.$template_active->name;
        }
        $path=$this->config->application->siteViewsDir.$this->template;
        $this->view->setViewsDir($path);
        $this->view->setVar('title',$this->title);
        $this->view->setVar('list_tags',[]);
        $this->view->setVar('keyword_search','');
    }
    
    public function afterExecuteRoute()
    {
        $this->view->setVar('var_template',$this->template);
        $this->view->setVar('path_assets',$this->path_assets);
        $this->view->setVar('list_top_menu',$this->list_page_menu());
        $this->view->setVar('list_category',$this->list_category());
        $this->view->setVar('top_list_content',$this->top_list_content());
        $this->view->setVar('advertising_all_page',$this->get_list_advertising('all'));
    }
    
    private function list_page_menu()
    {
        $rs=[];
        $data_menu=CPost::find([
            "columns"=>"post_id,post_title,post_slug,post_parent,custom_url",
            "post_status = 'publish' AND post_type='page'",
            'order'=>'menu_order ASC'
        ]);
        if(count($data_menu) > 0)
        {
            $rs=$data_menu->toArray();
        }
        return $rs;
    }
    
    private function list_category()
    {
        $rs=MCategory::find([
            "columns"=>"category,slug",
            "order"=>"category ASC"
        ]);
        return $rs;
    }
    
    private function top_list_content()
    {
        $data=$this->modelsManager->createBuilder()
            ->from("CPost")
            ->columns("
                CPost.post_id,
                CPost.post_title,
                CPost.post_slug,
                CPost.post_cover,
                CPost.publish_on,
                CM.media_path,
                CM.media_guide")
            ->join("CMedia","CM.media_id=CPost.post_cover","CM","LEFT")
            ->join("CPostViews","CPostViews.post_id=CPost.post_id")
            ->where("CPost.post_status='publish' AND CPost.post_type='posting'")
            ->groupBy("CPostViews.post_id")
            ->orderBy("COUNT(CPostViews.post_id) DESC")
            ->limit(5)
            ->getQuery()
            ->execute();
            
        return $data;
    }
    
    protected function get_list_post_media($post_id)
    {
        $data=$this->modelsManager->createBuilder()
            ->from("RRelationPostMedia")
            ->columns("
                CMedia.media_id,
                CMedia.media_type,
                CMedia.media_name,
                CMedia.media_path,
                CMedia.media_caption,
                CMedia.media_path,
                CMedia.media_guide")
            ->join("CMedia","CMedia.media_id=RRelationPostMedia.media_id")
            ->where("RRelationPostMedia.post_id=:postid:",[
                "postid"=>$post_id
            ])
            ->getQuery()
            ->execute();;
        $rs=[];
        if(count($data) > 0)
        {
            foreach($data as $m)
            {
                $rs[]=array(
                    'media_id'=>$m->media_id,
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
    
    protected function get_list_advertising($location)
    {
        $row=MAdvertisement::findFirst([
            "columns"=>"id,advertiser,url_web",
            "post_location=:location: AND status='Y'",
            "bind"=>[
                "location"=>$location
            ]
        ]);
        $rs=[];
        if($row)
        {
            $rs['row']=$row;
            $rs['list_media']=[];
            $data=$this->modelsManager->createBuilder()
                ->from("MMediaAdvertisement")
                ->columns("
                    CMedia.media_id,
                    CMedia.media_type,
                    CMedia.media_name,
                    CMedia.media_path,
                    CMedia.media_caption,
                    CMedia.media_path,
                    CMedia.media_guide")
                ->join("CMedia","CMedia.media_id=MMediaAdvertisement.media_id")
                ->where("MMediaAdvertisement.id_advertisement=:pk:",[
                    "pk"=>$row->id
                ])
                ->getQuery()
                ->execute();
                
            if(count($data) > 0)
            {
                foreach($data as $m)
                {
                    $rs['list_media'][]=array(
                        'media_id'=>$m->media_id,
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
        }
        
        return $rs;
    }
    
    // show 404 page not found
    protected function show404()
    {
        $this->view->pick('error/show404');
    }
}