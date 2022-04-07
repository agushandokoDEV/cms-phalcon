<?php

class MenuGenerate
{
    private $fetchMenu=null;
    
    public function __construct($menu)
    {
        $this->fetchMenu=$menu;
    }
    
    public function sampleMenu( $root_id = 0 )
    {
        $html  = '';
        $items = $this->fetchMenu;

        foreach ( $items as $item )
            $children[$item['menu_parent_id']][] = $item;

        // loop will be false if the root has no children (i.e., an empty menu!)
        $loop = !empty( $children[$root_id] );

        // initializing $parent as the root
        $parent = $root_id;
        $parent_stack = array();

        // HTML wrapper for the menu (open)
        $html .= '<ol>';

        while ( $loop && ( ( $option = each( $children[$parent] ) ) || ( $parent > $root_id ) ) )
        {
            
            if ( $option === false )
            {
                $parent = array_pop( $parent_stack );

                // HTML for menu item containing childrens (close)
                $html .= str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 ) . '</ol>';
                $html .= str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 ) . '</li>';
            }
            elseif ( !empty( $children[$option['value']['menu_id']] ) )
            {
                $tab = str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 );

                // HTML for menu item containing childrens (open)
                
                $html .= sprintf(
                    '%1$s
                    <li>%3$s',
                    $tab,   // %1$s = tabulation
                    $option['value']['menu_id'],
                    $option['value']['menu_title'],
                    $option['value']['resources_name'],
                    $option['value']['access_name'],
                    $option['value']['menu_parent_id'],
                    $option['value']['show_menu'],
                    $option['value']['description']
                ); 
                $html .= $tab . "\t" . '<ol>';

                array_push( $parent_stack, $option['value']['menu_parent_id'] );
                $parent = $option['value']['menu_id'];
            }
            else
                // HTML for menu item with no children (aka "leaf")  
                $html .= sprintf(
                    '%1$s<li>%3$s</li>',
                    str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 ),   // %1$s = tabulation
                    $option['value']['menu_id'],
                    $option['value']['menu_title'],
                    $option['value']['resources_name'],
                    $option['value']['access_name'],
                    $option['value']['menu_parent_id'],
                    $option['value']['show_menu'],
                    $option['value']['description']
                );
        }

        // HTML wrapper for the menu (close)
        $html .= '</ol>';

        return $html;
    }
    
    public function nesTableDefault( $root_id = 0 )
    {
        $html  = '';
        $items = $this->fetchMenu;

        foreach ( $items->toArray() as $item )
            $children[$item['menu_parent_id']][] = $item;

        // loop will be false if the root has no children (i.e., an empty menu!)
        $loop = !empty( $children[$root_id] );

        // initializing $parent as the root
        $parent = $root_id;
        $parent_stack = array();

        // HTML wrapper for the menu (open)
        $html .= '<ol class="dd-list">';

        while ( $loop && ( ( $option = each( $children[$parent] ) ) || ( $parent > $root_id ) ) )
        {
            if ( $option === false )
            {
                $parent = array_pop( $parent_stack );

                // HTML for menu item containing childrens (close)
                $html .= str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 ) . '</ol>';
                $html .= str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 ) . '</li>';
            }
            elseif ( !empty( $children[$option['value']['menu_id']] ) )
            {
                $tab = str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 );

                // HTML for menu item containing childrens (open)
                $html .= sprintf(
                    '%1$s<li class="dd-item" data-id="%2$s"><div class="dd-handle">%3$s</div>',
                    $tab,   // %1$s = tabulation
                    $option['value']['menu_id'],   // %2$s = link (URL)
                    $option['value']['menu_title']   // %3$s = title
                ); 
                $html .= $tab . "\t" . '<ol class="dd-list">';

                array_push( $parent_stack, $option['value']['menu_parent_id'] );
                $parent = $option['value']['menu_id'];
            }
            else
                // HTML for menu item with no children (aka "leaf") 
                $html .= sprintf(
                    '%1$s<li class="dd-item" data-id="%2$s"><div class="dd-handle">%3$s</div></li>',
                    str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 ),   // %1$s = tabulation
                    $option['value']['menu_id'],   // %2$s = link (URL)
                    $option['value']['menu_title']   // %3$s = title
                );
        }

        // HTML wrapper for the menu (close)
        $html .= '</ol>';

        return $html;
    }
    
    public function nesTable( $root_id = 0 )
    {
        $html  = '';
        $items = $this->fetchMenu;

        foreach ( $items->toArray() as $item )
            $children[$item['menu_parent_id']][] = $item;

        // loop will be false if the root has no children (i.e., an empty menu!)
        $loop = !empty( $children[$root_id] );

        // initializing $parent as the root
        $parent = $root_id;
        $parent_stack = array();

        // HTML wrapper for the menu (open)
        $html .= '<ol class="dd-list" id="menu-id">';

        while ( $loop && ( ( $option = each( $children[$parent] ) ) || ( $parent > $root_id ) ) )
        {
            if ( $option === false )
            {
                $parent = array_pop( $parent_stack );

                // HTML for menu item containing childrens (close)
                $html .= str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 ) . '</ol>';
                $html .= str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 ) . '</li>';
            }
            elseif ( !empty( $children[$option['value']['menu_id']] ) )
            {
                $tab = str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 );

                // HTML for menu item containing childrens (open)
                $html .= sprintf(
                    '
                    %1$s<li class="dd-item dd3-item" data-id="%2$s">
                    <div class="dd-handle dd3-handle">Drag</div>
                    <div class="dd3-content">
                        <span id="label_show%2$s">%3$s</span>
                        <span class="span-right">/<span id="link_show%2$s">%4$s/%5$s</span> &nbsp;&nbsp; 
                            <a class="edit-button" id="%2$s" resources="%4$s" access="%5$s" parent="%6$s"><i class="glyphicon glyphicon-pencilx"></i></a>
                        </span>
                    </div>',
                    $tab,   // %1$s = tabulation
                    $option['value']['menu_id'],
                    $option['value']['menu_title'],
                    $option['value']['resources_name'],
                    $option['value']['access_name'],
                    $option['value']['menu_parent_id']
                ); 
                $html .= $tab . "\t" . '<ol class="child">';

                array_push( $parent_stack, $option['value']['menu_parent_id'] );
                $parent = $option['value']['menu_id'];
            }
            else
                // HTML for menu item with no children (aka "leaf") 
                $html .= sprintf(
                    '
                    %1$s<li class="dd-item dd3-item" data-id="%2$s">
                    <div class="dd-handle dd3-handle">Drag</div>
                    <div class="dd3-content">
                        <span id="label_show%2$s">%3$s</span>
                        <span class="span-right">/<span id="link_show%2$s">%4$s/%5$s</span> &nbsp;&nbsp; 
                            <a class="edit-button" id="%2$s" resources="%4$s" access="%5$s" parent="%6$s"><i class="glyphicon glyphicon-pencilx"></i></a>
                        </span>
                    </div>
                    </li>',
                    str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 ),   // %1$s = tabulation
                    $option['value']['menu_id'],
                    $option['value']['menu_title'],
                    $option['value']['resources_name'],
                    $option['value']['access_name'],
                    $option['value']['menu_parent_id']
                );
        }

        // HTML wrapper for the menu (close)
        $html .= '</ol>';

        return $html;
    }
    
    public function navbarMenu( $root_id = 0 )
    {
        $html  = '';
        $items = $this->fetchMenu;

        foreach ( $items->toArray() as $item )
            $children[$item['menu_parent_id']][] = $item;

        // loop will be false if the root has no children (i.e., an empty menu!)
        $loop = !empty( $children[$root_id] );

        // initializing $parent as the root
        $parent = $root_id;
        $parent_stack = array();

        // HTML wrapper for the menu (open)
        $html .= '<ul class="nav navbar-nav" id="mobile-nav">';

        while ( $loop && ( ( $option = each( $children[$parent] ) ) || ( $parent > $root_id ) ) )
        {
            
            if ( $option === false )
            {
                $parent = array_pop( $parent_stack );

                // HTML for menu item containing childrens (close)
                $html .= str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 ) . '</ul>';
                $html .= str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 ) . '</li>';
            }
            elseif ( !empty( $children[$option['value']['menu_id']] ) )
            {
                $tab = str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 );

                // HTML for menu item containing childrens (open)
                
                $html .= sprintf(
                    '%1$s<li class="dropdown">
                        <a data-toggle="dropdown" class="dropdown-toggle" href="/%4$s/%5$s"> %3$s <b class="caret"></b></a>',
                    $tab,   // %1$s = tabulation
                    $option['value']['menu_id'],
                    $option['value']['menu_title'],
                    $option['value']['resources_name'],
                    $option['value']['access_name'],
                    $option['value']['menu_parent_id'],
                    $option['value']['show_menu'],
                    $option['value']['description']
                ); 
                $html .= $tab . "\t" . '<ul class="dropdown-menu">';

                array_push( $parent_stack, $option['value']['menu_parent_id'] );
                $parent = $option['value']['menu_id'];
            }
            else
                // HTML for menu item with no children (aka "leaf")  
                $html .= sprintf(
                    '%1$s<li><a href="/%4$s/%5$s">%3$s</a></li>',
                    str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 ),   // %1$s = tabulation
                    $option['value']['menu_id'],
                    $option['value']['menu_title'],
                    $option['value']['resources_name'],
                    $option['value']['access_name'],
                    $option['value']['menu_parent_id'],
                    $option['value']['show_menu'],
                    $option['value']['description']
                );
        }

        // HTML wrapper for the menu (close)
        $html .= '</ul>';

        return $html;
    }
    
    public function listParentMenu()
    {
        $items = $this->fetchMenu;
        $html='';
        if($items)
        {
            foreach($items as $i)
            {
                $html .='<li><a href="/'.$i->resources_name.'"><i class="fa fa-circle-o text-aqua"></i> <span>'.$i->menu_title.'</span></a></li>';
            }
        }
        return $html;
    }
    
    public function listChildMenu()
    {
        $items = $this->fetchMenu;
        $html='';
        if($items)
        {
            foreach($items as $i)
            {
                $html .='
                    <li>
                        <a href="/'.$i->resources_name.'/'.$i->access_name.'">
                          <i class="menu-icon fa fa-hand-o-right bg-red"></i>
                          <div class="menu-info">
                            <h4 class="control-sidebar-subheading">'.$i->menu_title.'</h4>
                            <p>'.$i->description.'</p>
                          </div>
                        </a>
                      </li>';
            }
        }
        return $html;
    }
    
    public function boostrapDropdown( $root_id = 0 )
    {
        $html  = '';
        $items = $this->fetchMenu;

        foreach ( $items->toArray() as $item )
            $children[$item['menu_parent_id']][] = $item;

        // loop will be false if the root has no children (i.e., an empty menu!)
        $loop = !empty( $children[$root_id] );

        // initializing $parent as the root
        $parent = $root_id;
        $parent_stack = array();

        // HTML wrapper for the menu (open)
        $html .= '<ul class="nav nav-pills" role="tablist">';

        while ( $loop && ( ( $option = each( $children[$parent] ) ) || ( $parent > $root_id ) ) )
        {
            
            if ( $option === false )
            {
                $parent = array_pop( $parent_stack );

                // HTML for menu item containing childrens (close)
                $html .= str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 ) . '</ul>';
                $html .= str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 ) . '</li>';
            }
            elseif ( !empty( $children[$option['value']['menu_id']] ) )
            {
                $tab = str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 );

                // HTML for menu item containing childrens (open)
                
                $html .= sprintf(
                    '%1$s
                    <li role="presentation" class="dropdown mymenu">
                    <a href="/%4$s/%5$s" class="dropdown-toggle" id="drop%2$s" data-toggle="dropdown disable" role="button" aria-haspopup="true" aria-expanded="false"> %3$s <span class="caret"></span> </a>',
                    $tab,   // %1$s = tabulation
                    $option['value']['menu_id'],
                    $option['value']['menu_title'],
                    $option['value']['resources_name'],
                    $option['value']['access_name'],
                    $option['value']['menu_parent_id'],
                    $option['value']['show_menu'],
                    $option['value']['description']
                ); 
                $html .= $tab . "\t" . '<ul class="dropdown-menu" id="menu'.$option['value']['menu_id'].'" aria-labelledby="drop'.$option['value']['menu_id'].'"> ';

                array_push( $parent_stack, $option['value']['menu_parent_id'] );
                $parent = $option['value']['menu_id'];
            }
            else
                // HTML for menu item with no children (aka "leaf")  
                $html .= sprintf(
                    '%1$s<li role="presentation"><a href="/%4$s/%5$s">%3$s</a></li>',
                    str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 ),   // %1$s = tabulation
                    $option['value']['menu_id'],
                    $option['value']['menu_title'],
                    $option['value']['resources_name'],
                    $option['value']['access_name'],
                    $option['value']['menu_parent_id'],
                    $option['value']['show_menu'],
                    $option['value']['description']
                );
        }

        // HTML wrapper for the menu (close)
        $html .= '</ul>';

        return $html;
    }
    
    public function treeGrid()
    {
        $html  = '';
        $items = $this->fetchMenu;
        $checked[0]="";
        $checked[1]="checked";
        $html .= '
            <table id="treeGrid" class="table table-hover table-bordered">
            <thead>
                <tr>
                    <th>Modul</th>
                    <th>Show Menu</th>
                    <th>URI</th>
                    <th>Description</th>
                    <th>Allowed</th>
                </tr>
            </thead>
            <tbody>
        ';
        $aksi='';        
        if($items)
        {
            foreach($items as $v)
            {
                
                if($v->menu_parent_id == 0)
                {
                    $p='';
                    $aksi = '<td><input id="'.$v->resources_name.'" onchange="checkAll('."'".$v->resources_name."'".')" type="checkbox" name="'.$v->resources_name.'[]" value="'.$v->access_name.'" '.$checked[$v->allowed].'/></td>';
                }
                else
                {
                    $p='treegrid-parent-'.$v->menu_parent_id;
                    $aksi = '<td><input id="'.$v->resources_name.$v->menu_id.'" class="'.$v->resources_name.'" type="checkbox" onchange="checkOne('."'".$v->resources_name."'".','."'".$v->access_name."'".','."'".$v->menu_id."'".')" name="'.$v->resources_name.'[]" value="'.$v->access_name.'" '.$checked[$v->allowed].'/></td>';
                }
                $html .='
                        <tr class="treegrid-'.$v->menu_id.' '.$p.'">
                            <td>'.$v->menu_title.'</td>
                            <td>'.$v->show_menu.'</td>
                            <td>'.$v->resources_name.'/'.$v->access_name.'</td>
                            <td>'.$v->description.'</td>                                        
                            '.$aksi.'
                        </tr>
                    ';
            }
        }
        $html .= '</tbody></table>';
        return $html;
    }
    
    public function sidebar( $root_id = 0 )
    {
        $html  = '';
        $items = $this->fetchMenu;

        foreach ( $items as $item )
            $children[$item['menu_parent_id']][] = $item;

        // loop will be false if the root has no children (i.e., an empty menu!)
        $loop = !empty( $children[$root_id] );

        // initializing $parent as the root
        $parent = $root_id;
        $parent_stack = array();

        // HTML wrapper for the menu (open)
        $html .= '<ul class="sidebar-menu">';

        while ( $loop && ( ( $option = each( $children[$parent] ) ) || ( $parent > $root_id ) ) )
        {
            
            if ( $option === false )
            {
                $parent = array_pop( $parent_stack );

                // HTML for menu item containing childrens (close)
                $html .= str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 ) . '</ul>';
                $html .= str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 ) . '</li>';
            }
            elseif ( !empty( $children[$option['value']['menu_id']] ) )
            {
                $tab = str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 );
                $resource=$option['value']['resources_name'];
                $res=substr($resource,0,1);                
                $url='/'.$resource.'/'.$option['value']['access_name'];
                if($res == '-')
                {
                    $url='#';
                }
                // HTML for menu item containing childrens (open)
                
                $html .= sprintf(
                    '%1$s
                    <li class="treeview">
                        <a href="%4$s">
                        <i class="%9$s"></i> <span>%3$s</span>
                        <span class="pull-right-container">
                          <i class="fa fa-angle-left pull-right"></i>
                        </span>
                      </a>',
                    $tab,   // %1$s = tabulation
                    $option['value']['menu_id'],
                    $option['value']['menu_title'],
                    $url,
                    $option['value']['access_name'],
                    $option['value']['menu_parent_id'],
                    $option['value']['show_menu'],
                    $option['value']['description'],
                    $option['value']['icon']
                ); 
                $html .= $tab . "\t" . '<ul class="treeview-menu">';

                array_push( $parent_stack, $option['value']['menu_parent_id'] );
                $parent = $option['value']['menu_id'];
            }
            else
            {
                // HTML for menu item with no children (aka "leaf")
                $resource=$option['value']['resources_name'];
                $res=substr($resource,0,1);                
                $url='/'.$resource.'/'.$option['value']['access_name'];
                if($res == '-')
                {
                    $url='#';
                }
                $html .= sprintf(
                    '%1$s<li><a href="%4$s"><i class="%9$s"></i> <span>%3$s</span></a></li>',
                    str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 ),   // %1$s = tabulation
                    $option['value']['menu_id'],
                    $option['value']['menu_title'],
                    $url,
                    $option['value']['access_name'],
                    $option['value']['menu_parent_id'],
                    $option['value']['show_menu'],
                    $option['value']['description'],
                    $option['value']['icon']
                );
            }
        }

        // HTML wrapper for the menu (close)
        $html .= '</ul>';

        return $html;
    }
    
    public function sidebarXXX( $root_id = 0 )
    {
        $html  = '';
        $items = $this->fetchMenu;

        foreach ( $items as $item )
            $children[$item['menu_parent_id']][] = $item;

        // loop will be false if the root has no children (i.e., an empty menu!)
        $loop = !empty( $children[$root_id] );

        // initializing $parent as the root
        $parent = $root_id;
        $parent_stack = array();

        // HTML wrapper for the menu (open)
        $html .= '<ul class="sidebar-menu">';

        while ( $loop && ( ( $option = each( $children[$parent] ) ) || ( $parent > $root_id ) ) )
        {
            
            if ( $option === false )
            {
                $parent = array_pop( $parent_stack );

                // HTML for menu item containing childrens (close)
                $html .= str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 ) . '</ul>';
                $html .= str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 ) . '</li>';
            }
            elseif ( !empty( $children[$option['value']['menu_id']] ) )
            {
                $resource=$option['value']['resources_name'];
                $res=substr($resource,0,1);                
                $url='/'.$resource.'/'.$option['value']['access_name'];
                if($res == '-')
                {
                    $url='#';
                }
                $tab = str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 );

                // HTML for menu item containing childrens (open)
                
                $html .= sprintf(
                    '%1$s
                    <li class="treeview">
                        <a href="%4$s">
                        <i class="%9$s"></i> <span>%3$s</span>
                        <span class="pull-right-container">
                          <i class="fa fa-angle-left pull-right"></i>
                        </span>
                      </a>',
                    $tab,   // %1$s = tabulation
                    $option['value']['menu_id'],
                    $option['value']['menu_title'],
                    $url,
                    $option['value']['access_name'],
                    $option['value']['menu_parent_id'],
                    $option['value']['show_menu'],
                    $option['value']['description'],
                    $option['value']['icon']
                ); 
                $html .= $tab . "\t" . '<ul class="treeview-menu">';

                array_push( $parent_stack, $option['value']['menu_parent_id'] );
                $parent = $option['value']['menu_id'];
            }
            else
                // HTML for menu item with no children (aka "leaf")  
                $resource=$option['value']['resources_name'];
                $res=substr($resource,0,1);                
                $url='/'.$resource.'/'.$option['value']['access_name'];
                if($res == '-')
                {
                    $url='#';
                }
                $html .= sprintf(
                    '%1$s<li><a href="%4$s"><i class="%9$s"></i> <span>%3$s</span></a></li>',
                    str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 ),   // %1$s = tabulation
                    $option['value']['menu_id'],
                    $option['value']['menu_title'],
                    $url,
                    $option['value']['access_name'],
                    $option['value']['menu_parent_id'],
                    $option['value']['show_menu'],
                    $option['value']['description'],
                    $option['value']['icon']
                );
        }

        // HTML wrapper for the menu (close)
        $html .= '</ul>';

        return $html;
    }
    
    public function jsTree( $root_id = 0 )
    {
        $html  = '';
        $items = $this->fetchMenu;

        foreach ( $items->toArray() as $item )
            $children[$item['album_parent_id']][] = $item;

        // loop will be false if the root has no children (i.e., an empty menu!)
        $loop = !empty( $children[$root_id] );

        // initializing $parent as the root
        $parent = $root_id;
        $parent_stack = array();

        // HTML wrapper for the menu (open)
        $html .= '<ul>';

        while ( $loop && ( ( $option = each( $children[$parent] ) ) || ( $parent > $root_id ) ) )
        {
            
            if ( $option === false )
            {
                $parent = array_pop( $parent_stack );

                // HTML for menu item containing childrens (close)
                $html .= str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 ) . '</ul>';
                $html .= str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 ) . '</li>';
            }
            elseif ( !empty( $children[$option['value']['album_id']] ) )
            {
                $tab = str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 );

                // HTML for menu item containing childrens (open)
                
                $html .= sprintf(
                    '%1$s
                    <li>%3$s',
                    $tab,   // %1$s = tabulation
                    $option['value']['album_id'],
                    $option['value']['album_name'],
                    $option['value']['album_parent_id']
                ); 
                $html .= $tab . "\t" . '<ul>';

                array_push( $parent_stack, $option['value']['album_parent_id'] );
                $parent = $option['value']['album_id'];
            }
            else
                // HTML for menu item with no children (aka "leaf")  
                $html .= sprintf(
                    '%1$s<li>%3$s</li>',
                    str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 ),   // %1$s = tabulation
                    $option['value']['album_id'],
                    $option['value']['album_name'],
                    $option['value']['album_parent_id']
                );
        }

        // HTML wrapper for the menu (close)
        $html .= '</ul>';

        return $html;
    }
    
    public function ajsTree()
    {
        $result = $this->fetchMenu;
        $data=[];
        if(count($result)> 0)
        {
            foreach($result->toArray() as $row)
            {
                $data[]=$row;
            }
            $itemsByReference = array();
            // Build array of item references:
            foreach($data as $key => &$item) {
                $itemsByReference[$item['album_id']] = &$item;
                // Children array:
                $itemsByReference[$item['album_id']]['children'] = array();
                // Empty data class (so that json_encode adds "data: {}" )
                $itemsByReference[$item['album_id']]['data'] = new StdClass();
            }
            // Set items as children of the relevant parent item.
            foreach($data as $key => &$item)
            if($item['album_parent_id'] && isset($itemsByReference[$item['album_parent_id']]))
            $itemsByReference [$item['album_parent_id']]['children'][] = &$item;
            // Remove items that were added to parents elsewhere:
            foreach($data as $key => &$item) {
                if($item['album_parent_id'] && isset($itemsByReference[$item['album_parent_id']]))
                unset($data[$key]);
            }
        }
        return $data;
    }
}