{% extends "layouts/base.volt" %}
{% block pagetop %}
<a href="/datacategory" title="Back" class="btn btn-default"><span class="glyphicon glyphicon-arrow-left"></span></a>
{% endblock %}
{% block content %}
{{ flash.output() }}
<?php $this->partial("layouts/html/box/start",['icon'=>$row_menu->icon,'box_title'=>$row_menu->menu_title]); ?>
<form action="/datacategory/add" method="POST" id="form-add">
  <div class="form-group">
    <label for="exampleInputEmail1">Category</label>
    <input type="text" class="form-control" name="category_name" placeholder="Category name">
  </div>
  <button type="submit" class="btn btn-success">Submit</button>
  <a href="/datacategory" class="btn btn-default">Kembali</a>
</form>
<?php $this->partial("layouts/html/box/end"); ?>
{% endblock %}