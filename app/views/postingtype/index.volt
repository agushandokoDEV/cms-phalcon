{% extends "layouts/base.volt" %}
{% block pagetop %}
<h1><i class="{{row_menu.icon}}"></i> {{row_menu.menu_title}}<small>{{row_menu.description}}</small></h1>
{% endblock %}
{% block content %}
{{ flash.output() }}
<a href="/postingtype/add" class="btn btn-default"><i class="fa fa-plus"></i> Add new data</a>
<?php $this->partial("layouts/html/box/start",['icon'=>$row_menu->icon,'box_title'=>$row_menu->menu_title]); ?>
<table class="table table-bordered table-hover">
    <thead>
        <tr>
            <th>No</th>
            <th>Type</th>
            <th>Title</th>
            <th>Icon</th>
            <th>Description</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <?php if($list_type){ ?>
        <?php $no=1; foreach($list_type as $v){ ?>
        <tr>
            <td><?php echo $no++ ?></td>
            <td>{{v.post_type}}</td>
            <td>{{v.post_title}}</td>
            <td><i class="{{v.post_icon}}"></i></td>
            <td>{{v.post_type_des}}</td>
            <td>{{v.post_type_status}}</td>
            <td><a class="btn btn-sm btn-default" href="/postingtype/edit/{{v.post_type}}"><i class="fa fa-pencil"></i></a></td>
        </tr>
        <?php }?>
        <?php }?>
    </tbody>
</table>
<?php $this->partial("layouts/html/box/end"); ?>
{% endblock %}