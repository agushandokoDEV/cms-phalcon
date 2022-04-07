<?php

class PageController extends FrontendController
{
    
    public function indexAction($slug=false)
    {
        $data=CPost::findFirst([
            "columns"=>"post_id,post_title,post_slug,post_content,post_create,post_cover,post_comment_status,post_language,publish_on,post_relation_lang",
            "post_slug=:slug: AND post_type='page'",
            "bind"=>[
                "slug"=>$slug
            ]
        ]);
        if(!$data)
        {
            $this->show404();
        }
        else
        {
            $this->view->setVar('list_media',$this->get_list_post_media($data->post_id));
            $this->view->setVar("title",$data->post_title);
            $this->view->setVar("data",$data);
        }
    }
}