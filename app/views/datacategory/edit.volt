{% extends "layouts/base.volt" %}
{% block pagetop %}
<a href="/datacategory" title="Back" class="btn btn-default"><span class="glyphicon glyphicon-arrow-left"></span></a>
{% endblock %}
{% block content %}
{{ flash.output() }}
<?php $this->partial("layouts/html/box/start",['icon'=>$row_menu->icon,'box_title'=>$row_menu->menu_title]); ?>
<form action="/datacategory/edit/{{data.row.id}}" method="POST" id="form-add">
  <div class="form-group">
    <label for="exampleInputEmail1">Category</label>
    <input type="text" class="form-control" name="category_name" placeholder="Category name" value="{{data.row.category}}">
  </div>
  <button type="submit" class="btn btn-success">Submit</button>
  <a href="/datacategory" class="btn btn-default">Kembali</a>
</form>
<?php $this->partial("layouts/html/box/end"); ?>
{% endblock %}