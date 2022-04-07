{% extends "layouts/base.volt" %}
{% block pagetop %}
<a href="/roles" title="Back" class="btn btn-default"><span class="glyphicon glyphicon-arrow-left"></span></a>
{% endblock %}
{% block content %}
{{ flash.output() }}
<?php $this->partial("layouts/html/box/start",['icon'=>$row_menu->icon,'box_title'=>$row_menu->menu_title]); ?>
<form action="/roles/edit/{{roles.roles}}" method="POST" id="form-edit">
  <div class="form-group">
    <label for="exampleInputEmail1">Role</label>
    <input type="hidden" name=""/>
    <input type="text" class="form-control" name="name" placeholder="Nama Role" value="{{roles.roles_name}}">
  </div>
  <div class="form-group">
    <label for="exampleInputPassword1">Username</label>
    <textarea class="form-control" rows="3" name="deskripsi" placeholder="Deskripsi roles">{{roles.description}}</textarea>
  </div>
  <button type="submit" class="btn btn-success">Submit</button>
  <a href="/roles" class="btn btn-default">Kembali</a>
</form>
<?php $this->partial("layouts/html/box/end"); ?>
{% endblock %}