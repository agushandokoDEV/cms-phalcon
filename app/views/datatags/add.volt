{% extends "layouts/base.volt" %}
{% block pagetop %}
<a href="/datatags" title="Back" class="btn btn-default"><span class="glyphicon glyphicon-arrow-left"></span></a>
{% endblock %}
{% block content %}
{{ flash.output() }}
<?php $this->partial("layouts/html/box/start",['icon'=>$row_menu->icon,'box_title'=>$row_menu->menu_title]); ?>
<form action="/datatags/add" method="POST" id="form-add">
  <div class="form-group">
    <label for="exampleInputEmail1">Tags</label>
    <input type="text" class="form-control" name="tags_name" placeholder="Tags">
  </div>
  <div class="form-group">
    <label for="exampleInputEmail1">Category</label>
    {{data.list_category}}
  </div>
  <button type="submit" class="btn btn-success">Submit</button>
  <a href="/datatags" class="btn btn-default">Kembali</a>
</form>
<?php $this->partial("layouts/html/box/end"); ?>
{% endblock %}