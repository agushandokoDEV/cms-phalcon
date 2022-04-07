{% extends "layouts/base.volt" %}
{% block pagetop %}
<a href="/template" title="Back" class="btn btn-default"><span class="glyphicon glyphicon-arrow-left"></span></a>
{% endblock %}
{% block content %}
{{ flash.output() }}
<?php $this->partial("layouts/html/box/start",['icon'=>$row_menu->icon,'box_title'=>$row_menu->menu_title]); ?>
<form action="/template/edit/{{data.row.name}}" method="POST" id="form-add" enctype="multipart/form-data">
  <div class="form-group">
    <label for="exampleInputEmail1">Title</label>
    <input type="text" class="form-control" name="title" value="{{data.row.title}}">
  </div>
  <button type="submit" class="btn btn-success">Submit</button>
  <a href="/template" class="btn btn-default">Kembali</a>
</form>
<?php $this->partial("layouts/html/box/end"); ?>

{% endblock %}