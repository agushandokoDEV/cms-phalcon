<?php
class PagemenupositionController extends ControllerBase 
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
        $this->myassets->nestable();
        $this->myassets->assetsFormValidation();
        $this->view->setVar("menuItem",$this->list_page_menu());
    }
    
    public function addAction($param=false)
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
    }
    
    public function editAction($param=false)
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
    }
    
    private function save_new_uri()
    {
        $title=$this->request->getPost('menu_title');
        $uri=$this->request->getPost('url_modul');
        $parent=$this->request->getPost('parent_modul');
        $pk=$this->request->getPost('pk');
        $data=CPost::findFirst([
            "post_type='page' AND post_slug=:slug:",
            "bind"=>[
                "slug"=>$uri
            ]
        ]);
        if($pk == '0')
        {
            if($data)
            {
                $this->rs->message="Menu sudah tersedia";
            }
            else
            {
                $data=new CPost();
                $data->post_title=$title;
                $data->post_slug=$uri;
                $data->custom_url='Y';
                $data->post_author=$this->auth->username;
                $data->post_status='publish';
                $data->post_type='page';
                $data->post_parent=$parent;
                $data->save();
                $this->rs->message="Menu berhasil ditambahkan";
                $this->rs->success=true;
            }
        }
        else
        {
            $upd=CPost::findFirstBypost_id($pk);
            if(!$upd)
            {
                $this->rs->message="data tidak tersedia";
            }
            else
            {
                $upd->post_title=$title;
                $upd->update();
                $this->rs->success=true;
                $this->rs->message="Edit berhasil";
            }
        }
        $this->rs->send();
    }
    
    private function list_page_menu($root_id = 0 )
    {
        $html  = '';
        //$items = $this->fetchMenu;
        $items=CPost::find([
            "post_status = 'publish' AND post_type='page'",
            "order"=>"menu_order ASC"
        ]);
        if(count($items) > 0)
        {
            foreach ( $items->toArray() as $item )
                $children[$item['post_parent']][] = $item;
    
            // loop will be false if the root has no children (i.e., an empty menu!)
            $loop = !empty( $children[$root_id] );
    
            // initializing $parent as the root
            $parent = $root_id;
            $parent_stack = array();
    
            // HTML wrapper for the menu (open)
            $html .= '<ol class="dd-list" id="menu-id">';
            
            while ( $loop && ( ( $option = each( $children[$parent] ) ) || ( $parent > $root_id ) ) )
            {
                $uri='/page/index/'.$option['value']['post_slug'];
                $del='&nbsp;<a class="btn btn-xs btn-default" href="javascript:void(0)" disabled><i class="fa fa-trash"></i></a>';
                $upd='&nbsp;<a class="btn btn-xs btn-default" href="javascript:void(0)" disabled><i class="fa fa-pencil"></i></a>';
                if($option['value']['custom_url'] == 'Y')
                {
                    $uri='/'.$option['value']['post_slug'];
                    $del='&nbsp;<a onclick="del_row('."'".$option['value']['post_id']."'".')" class="btn btn-xs btn-default" href="javascript:void(0)"><i class="fa fa-trash"></i></a>';
                    $upd='&nbsp;<a onclick="upd_row('."'".$option['value']['post_id']."'".','."'".$option['value']['post_title']."'".','."'".$option['value']['post_slug']."'".')" class="btn btn-xs btn-default" href="javascript:void(0)"><i class="fa fa-pencil"></i></a>';
                }
                if ( $option === false )
                {
                    $parent = array_pop( $parent_stack );
    
                    // HTML for menu item containing childrens (close)
                    $html .= str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 ) . '</ol>';
                    $html .= str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 ) . '</li>';
                }
                elseif ( !empty( $children[$option['value']['post_id']] ) )
                {
                    $tab = str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 );
    
                    // HTML for menu item containing childrens (open)
                    $html .= sprintf(
                        '
                        %1$s<li class="dd-item dd3-item" data-id="%2$s">
                        <div class="dd-handle dd3-handle">Drag</div>
                        <div class="dd3-content">
                            <span id="label_show%2$s">%3$s</span>
                            <span class="span-right"><span id="link_show%2$s">%4$s</span>%7$s%6$s&nbsp;<a class="btn btn-xs btn-default" onclick="get_row('."'".$option['value']['post_id']."'".','."'".$option['value']['post_title']."'".')" href="javascript:void(0)"><i class="fa fa-plus"></i></a>
                                <a class="edit-button" id="%2$s" resources="%4$s" parent="%5$s"></a>
                            </span>
                        </div>',
                        $tab,   // %1$s = tabulation
                        $option['value']['post_id'],
                        $option['value']['post_title'],
                        $uri,
                        $option['value']['post_parent'],
                        $del,
                        $upd
                    ); 
                    $html .= $tab . "\t" . '<ol class="child">';
    
                    array_push( $parent_stack, $option['value']['post_parent'] );
                    $parent = $option['value']['post_id'];
                }
                else
                    // HTML for menu item with no children (aka "leaf") 
                    $html .= sprintf(
                        '
                        %1$s<li class="dd-item dd3-item" data-id="%2$s">
                        <div class="dd-handle dd3-handle">Drag</div>
                        <div class="dd3-content">
                            <span id="label_show%2$s">%3$s</span>
                            <span class="span-right"><span id="link_show%2$s">%4$s</span>%7$s%6$s&nbsp;<a class="btn btn-xs btn-default" onclick="get_row('."'".$option['value']['post_id']."'".','."'".$option['value']['post_title']."'".')" href="javascript:void(0)"><i class="fa fa-plus"></i></a>
                                <a class="edit-button" id="%2$s" resources="%4$s" parent="%5$s"></a>
                            </span>
                        </div>
                        </li>',
                        str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 ),   // %1$s = tabulation
                        $option['value']['post_id'],
                        $option['value']['post_title'],
                        $uri,
                        $option['value']['post_parent'],
                        $del,
                        $upd
                    );
            }
    
            // HTML wrapper for the menu (close)
            $html .= '</ol>';
        }

        return $html;
    }
    
    /**
     * parsing json dari nestable
     */
    private function parseJsonArray($jsonArray, $parentID = 0) {
      $return = array();
      foreach ($jsonArray as $subArray) {
        $returnSubSubArray = array();
        if (isset($subArray->children)) {
     		$returnSubSubArray = $this->parseJsonArray($subArray->children, $subArray->id);
        }
        $return[] = array('id' => $subArray->id, 'parentID' => $parentID);
        $return = array_merge($return, $returnSubSubArray);
      }
      return $return;
    }
    
    /**
     * proses set menu posisi
     */
    private function setPosition()
    {
        $req=$this->request->getPost('data');
        $toArr=json_decode($req);
        $data = $this->parseJsonArray($toArr);
        try{
            $rs=[];
            $i=0;
            foreach($data as $v)
            {
                
                $upd=CPost::findFirst([
                    "post_id=:post_id:",
                    "bind"=>[
                        "post_id"=>$v['id']
                    ]
                ]);
                $upd->post_parent=$v['parentID'];
                $upd->menu_order=$i;
                $upd->save();
                $i++;
            }
            
            $this->rs->success=true;
            //$this->rs->data=$rs;
        }catch(Exception $e)
        {
            $this->rs->message=$e->getMessage();
        }
        $this->rs->send();
    }
    
    public function deleteAction()
    {
        if($this->request->isAjax())
        {
            $pk=$this->request->getPost('pk');
            $data=CPost::findFirstBypost_id($pk);
            if(!$data)
            {
                $this->rs->success=false;
                $this->rs->message="data tidak tersedia";
            }
            else
            {
                $this->rs->success=true;
                $data->delete();
            }
            $this->rs->send();
        }
        else
        {
            $this->show404();
        }
    }
}