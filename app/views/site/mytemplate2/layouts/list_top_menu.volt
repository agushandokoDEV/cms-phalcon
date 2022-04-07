<?php
function list_top_menu($list_menu,$root_id = 0 )
{   
    $html  = '';
    
    if(count($list_menu) > 0)
    {
        foreach ( $list_menu as $item )
            $children[$item['post_parent']][] = $item;

        // loop will be false if the root has no children (i.e., an empty menu!)
        $loop = !empty( $children[$root_id] );

        // initializing $parent as the root
        $parent = $root_id;
        $parent_stack = array();

        // HTML wrapper for the menu (open)
        $html .= '<ul class="nav navbar-nav">';

        while ( $loop && ( ( $option = each( $children[$parent] ) ) || ( $parent > $root_id ) ) )
        {
            if ( $option === false )
            {
                $parent = array_pop( $parent_stack );

                // HTML for menu item containing childrens (close)
                $html .= str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 ) . '</ul>';
                $html .= str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 ) . '</li>';
            }
            elseif ( !empty( $children[$option['value']['post_id']] ) )
            {
                $tab = str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 );

                // HTML for menu item containing childrens (open)
                $html .= sprintf(
                    '
                    %1$s<li><a href="/page/index/%4$s">%3$s</a>',
                    $tab,   // %1$s = tabulation
                    $option['value']['post_id'],
                    $option['value']['post_title'],
                    $option['value']['post_slug'],
                    $option['value']['post_parent']
                ); 
                $html .= $tab . "\t" . '<ul class="dropdown-menu">';

                array_push( $parent_stack, $option['value']['post_parent'] );
                $parent = $option['value']['post_id'];
            }
            else
            {
                // HTML for menu item with no children (aka "leaf") 
                $html .= sprintf(
                    '
                    %1$s<li><a href="/page/index/%4$s">%3$s</a></li>',
                    str_repeat( "\t", ( count( $parent_stack ) + 1 ) * 2 - 1 ),   // %1$s = tabulation
                    $option['value']['post_id'],
                    $option['value']['post_title'],
                    $option['value']['post_slug'],
                    $option['value']['post_parent']
                );
            }
        }

        // HTML wrapper for the menu (close)
        $html .= '</ul>';
    }

    return $html;
}
$dt_menu=$list_menu;
echo list_top_menu($dt_menu);
?>