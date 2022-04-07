<?php

if(!isset($icon))
{
    $icon='';
}
if(!isset($color))
{
    $color='info';
}
?>
<div class="box box-{{color}}">
    <?php if(isset($icon) AND isset($color) AND isset($box_title)){ ?>
    <div class="box-header with-border">
      <h3 class="box-title"><i class="{{icon}}"></i> {{box_title}}</h3>
    </div>
    <?php }?>
    <div class="box-body">
        
    