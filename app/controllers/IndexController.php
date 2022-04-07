<?php
use Phalcon\Paginator\Adapter\QueryBuilder as PaginatorQueryBuilder;

class IndexController extends FrontendController
{
    private $limit;
    
    public function initialize()
    {
        $this->limit=$this->config->apps->posts_per_page;
    }
    public function indexAction()
    {
        $content['list_posting']=$this->list_posting();
        $this->view->setVar("content",(object)$content);
        $this->view->setVar('advertising_home_page',$this->get_list_advertising('home'));
    }
    
    public function categoryAction($slug=null)
    {
        $dt_tags=MCategory::findFirst([
            "columns"=>"category,slug",
            "slug=:slug:",
            "bind"=>[
                "slug"=>$slug
            ]
        ]);
        $title='-';
        if($dt_tags)
        {
            $title=$dt_tags->category;
        }
        $content['list_posting']=$this->list_post_by_category($slug);
        $content['query_tags']=$slug;
        $this->view->setVar("title","Category : ".$title);
        $this->view->setVar('list_tags',$this->list_tags_by_category($dt_tags->slug));
        $this->view->setVar("content",(object)$content);
    }
    
    public function tagsAction($tags)
    {
        $dt_tags=MTags::findFirst([
            "columns"=>"tags_title,tags_type",
            "tags_slug=:tags:",
            "bind"=>[
                "tags"=>$tags
            ]
        ]);
        $title='-';
        if($dt_tags)
        {
            $title=$dt_tags->tags_title;
        }
        $this->view->setVar("title","Tags : ".$title);
        
        $content['list_posting']=$this->list_post_by_tags($tags);
        $content['query_tags']=$tags;
        $this->view->setVar('list_tags',$this->list_tags_by_category($dt_tags->tags_type));
        $this->view->setVar("content",(object)$content);
    }
    
    public function searchAction()
    {
        $keyword=$this->request->get('keyword');
        $this->view->setVar("title","Serach : ".$keyword);
        $content['list_posting']=$this->search_posting($keyword);
        $this->view->setVar('keyword_search',$keyword);
        $this->view->setVar("content",(object)$content);
    }
    
    public function detailAction($slug=false)
    {
        $data=$this->modelsManager->createBuilder()
            ->from("CPost")
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
                CPost.post_relation_lang,
                CPost.event_location_name,
                CPost.event_location_addres,
                CPost.event_date_start,
                CPost.event_date_end,
                CPost.event_location_long,
                CPost.event_location_lat,
                CPost.post_category,
                MCategory.category,
                CM.media_path,
                CM.media_guide")
            ->join("CMedia","CM.media_id=CPost.post_cover","CM","LEFT")
            ->join("MCategory","MCategory.slug=CPost.post_category")
            ->where("CPost.post_slug=:slug: AND post_type !='page'",
                [
                    "slug"=>$slug
                ]
            )
            ->getQuery()
            ->getSingleResult();
        if(!$data)
        {
            $this->show404();
        }
        else
        {
            $views=CPostViews::findFirst([
                "ip_addr=:ipaddr: AND post_id=:post_id:",
                "bind"=>[
                    "ipaddr"=>$this->request->getClientAddress(),
                    "post_id"=>$data->post_id
                ]
            ]);
            if(!$views)
            {
                $new_view=new CPostViews();
                $new_view->ip_addr=$this->request->getClientAddress();
                $new_view->post_id=$data->post_id;
                
            }
            else
            {
                $new_view=CPostViews::findFirstByid_post_views($views->id_post_views);
                $new_view->total_views=$views->total_views + 1;
            }
            $new_view->last_read=date('Y-m-d H:i:s');
            $new_view->save();
            $post_related_tags=$this->modelsManager->createBuilder()
                ->from("CPostCategory")
                ->columns("MTags.tags_slug,MTags.tags_title")
                ->join("MTags","MTags.tags_slug=CPostCategory.tags_slug")
                ->where("CPostCategory.post_id=:post_id:",
                    [
                        "post_id"=>$data->post_id
                    ]
                )
                ->getQuery()
                ->execute();
            
            $post_views=CPostViews::count([
                "post_id=:post_id:",
                "bind"=>[
                    "post_id"=>$data->post_id
                ]
            ]);
            $content['data']=$data;
            $content['list_media']=$this->get_list_post_media($data->post_id);
            $content['post_related_tags']=$post_related_tags;
            $content['post_views']=$post_views;
            $content['post_related']=$this->get_post_related($post_related_tags);
            $content['current_url']=$this->config->apps->site_url.$this->router->getRewriteUri();
            $this->view->setVar('list_tags',$this->list_tags_by_category($data->post_category));
            $this->view->setVar("title",$data->post_title);
            $this->view->setVar("content",(object)$content);
        }
    }
    
    private function list_posting()
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
                CPost.post_cover,
                CPost.post_comment_status,
                CPost.post_language,
                CPost.publish_on,
                CPost.post_relation_lang,
                CPost.event_location_name,
                CPost.event_location_addres,
                CPost.event_date_start,
                CPost.event_date_end,
                CPost.event_location_long,
                CPost.event_location_lat,
                MCategory.category,
                CM.media_path,
                CM.media_guide")
            ->join("CMedia","CM.media_id=CPost.post_cover","CM","LEFT")
            ->join("MCategory","MCategory.slug=CPost.post_category")
            ->where("CPost.post_status='publish' AND CPost.post_type !='page'")
            ->orderBy("CPost.post_id DESC");
            //->limit($this->limit,$start)
            //->getQuery()
            //->execute();
            
        //$result['total_rows']=$total_rows;
        //$result['pages']=$pages;
        //$result['data']=$data;
        
        $paginator = new PaginatorQueryBuilder(
            [
                "builder" => $data,
                "limit"   => $this->limit,
                "page"    => $page,
            ]
        );
        $page = $paginator->getPaginate();
        return $page;
    }
    
    private function list_post_by_category($category=null)
    {
        $page=$this->request->get('page');
        if($page == '')
        {
            $page=1;
        }
        $result=[];
        /*
        $total_rows=CPost::count([
            "post_category='$category'"
        ]);
        */
        //$pages=ceil($total_rows / $this->limit);
        //$start=($page - 1) * $this->limit;
        
        $data=$this->modelsManager->createBuilder()
            ->from("CPost")
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
                CPost.post_relation_lang,
                CM.media_path,
                CM.media_guide,
                MCategory.category")
            //->join("CPostCategory","CPostCategory.post_id=CPost.post_id")
            ->join("MCategory","MCategory.slug=CPost.post_category")
            ->join("CMedia","CM.media_id=CPost.post_cover","CM","LEFT")
            ->where("CPost.post_status='publish' AND CPost.post_type !='page' AND CPost.post_category=:category:",
                [
                    "category"=>$category
                ]
            )
            ->orderBy("CPost.post_id DESC");
            //->limit($this->limit,$start)
            //->getQuery()
            //->execute();
            
        //$result['total_rows']=$total_rows;
        //$result['pages']=$pages;
        //$result['data']=$data;
        
        $paginator = new PaginatorQueryBuilder(
            [
                "builder" => $data,
                "limit"   => $this->limit,
                "page"    => $page,
            ]
        );
        $page = $paginator->getPaginate();
        return $page;
    }
    
    private function list_tags_by_category($type)
    {
        $data=$this->modelsManager->createBuilder()
            ->from("CPostCategory")
            ->columns("
                tags_slug,
                tags_title,
                COUNT(post_id) as count")
            ->where("catagory=:type:",
                [
                    "type"=>$type
                ]
            )
            ->groupBy("tags_slug")
            ->orderBy("tags_title ASC")
            ->getQuery()
            ->execute();
            
        return $data;
    }
    
    public function list_post_by_tags($tags)
    {
        $page=$this->request->get('page');
        if($page == '')
        {
            $page=1;
        }
        $result=[];
        $total_rows=CPostCategory::count([
            "CPostCategory.tags_slug='$tags'"
        ]);
        $pages=ceil($total_rows / $this->limit);
        $start=($page - 1) * $this->limit;
        
        $data=$this->modelsManager->createBuilder()
            ->from("CPostCategory")
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
                CPost.post_relation_lang,
                CM.media_path,
                CM.media_guide,
                MCategory.category")
            ->join("CPost","CPost.post_id=CPostCategory.post_id")
            ->join("CMedia","CM.media_id=CPost.post_cover","CM","LEFT")
            ->join("MCategory","MCategory.slug=CPost.post_category")
            ->where("CPost.post_status='publish' AND CPost.post_type !='page' AND CPostCategory.tags_slug='$tags'")
            ->orderBy("CPost.post_id DESC");
            //->limit($this->limit,$start)
            //->getQuery()
            //->execute();
            
        //$result['total_rows']=$total_rows;
        //$result['pages']=$pages;
        //$result['data']=$data;
        
        $paginator = new PaginatorQueryBuilder(
            [
                "builder" => $data,
                "limit"   => $this->limit,
                "page"    => $page,
            ]
        );
        $page = $paginator->getPaginate();
        return $page;
    }
    
    private function search_posting($keyword='')
    {
        $page=$this->request->get('page');
        
        if($page == '')
        {
            $page=1;
        }
        $result=[];
        $total_rows=CPost::count([
            "consitions"=>"post_status = 'publish' AND post_type !='page' AND CPost.post_title LIKE :keyword:",
            "bind"=>[
                "keyword"=>'%'.$keyword.'%'
            ]
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
                CPost.post_cover,
                CPost.post_comment_status,
                CPost.post_language,
                CPost.publish_on,
                CPost.post_relation_lang,
                CM.media_path,
                CM.media_guide,
                MCategory.category")
            ->join("CMedia","CM.media_id=CPost.post_cover","CM","LEFT")
            ->join("MCategory","MCategory.slug=CPost.post_category")
            ->where("CPost.post_status='publish' AND CPost.post_type !='page' AND CPost.post_title LIKE :keyword: OR CPost.post_content LIKE :keyword:",
                [
                    "keyword"=>'%'.$keyword.'%'
                ]
            )
            ->orderBy("CPost.post_id DESC");
            //->limit($this->limit,$start)
            //->getQuery()
            //->execute();
            
        //$result['total_rows']=$total_rows;
        //$result['pages']=$pages;
        //$result['data']=$data;
        
        $paginator = new PaginatorQueryBuilder(
            [
                "builder" => $data,
                "limit"   => $this->limit,
                "page"    => $page,
            ]
        );
        $page = $paginator->getPaginate();
        return $page;
    }
    
    private function get_post_related($related)
    {
        
        $in=[];
        if(count($related) > 0)
        {
            foreach($related as $r)
            {
                $in[]=$r->tags_slug;
            }
        }
        $data=$this->modelsManager->createBuilder()
            ->from("CPostCategory")
            ->columns("
                CPost.post_id,
                CPost.post_title,
                CPost.post_slug,
                CPost.post_content,
                CPost.post_create,
                CPost.post_cover,
                CM.media_path,
                CM.media_guide")
            ->join("CPost","CPost.post_id=CPostCategory.post_id")
            ->join("CMedia","CM.media_id=CPost.post_cover","CM","LEFT")
            //->join("MCategory","MCategory.slug=CPost.post_category")
            ->inWhere("CPostCategory.tags_slug",$in)
            ->groupBy("CPost.post_id")
            ->limit(6)
            ->getQuery()
            ->execute();
            
        return $data;
    }
    
    public function tesAction()
    {
        $this->view->disable();
        $baseUrl = $this->config->apps->site_url;
        $sitemap = new SitemapGenerator($baseUrl.'/');
        
        $posts=CPost::find([
            "post_status='publish'",
            "order"=>"publish_on DESC"
        ]);
        $uri='';
        if(count($posts) > 0)
        {
            foreach($posts as $post)
            {
                if($post->post_type == 'page')
                {
                    $uri=$baseUrl.'/page/index/'.$post->post_slug;
                }
                else
                {
                    $uri=$baseUrl.'/index/detail/'.$post->post_slug;
                }
                $sitemap->addUrl($uri,date('c'),  'daily',    '1');
            }
        }
        // add urls
        /*
        $sitemap->addUrl("http://your.app.com",                date('c'),  'daily',    '1');
        $sitemap->addUrl("http://your.app.com/page1",          date('c'),  'daily',    '0.5');
        $sitemap->addUrl("http://your.app.com/page2",          date('c'),  'daily');
        $sitemap->addUrl("http://your.app.com/page3",          date('c'));
        $sitemap->addUrl("http://your.app.com/page4");
        $sitemap->addUrl("http://your.app.com/page/subpage1",  date('c'),  'daily',    '0.4');
        $sitemap->addUrl("http://your.app.com/page/subpage2",  date('c'),  'daily');
        $sitemap->addUrl("http://your.app.com/page/subpage3",  date('c'));
        $sitemap->addUrl("http://your.app.com/page/subpage4");
        */
        // create sitemap
        $sitemap->createSitemap();
        // write sitemap as file
        $sitemap->writeSitemap();
        // update robots.txt file
        $sitemap->updateRobots();
        // submit sitemaps to search engines
        $result=$sitemap->submitSitemap();
        echo "<pre>";
        print_r($result);
        echo "</pre>";
        echo "Memory peak usage: ".number_format(memory_get_peak_usage()/(1024*1024),2)."MB";
    }
}