{% extends "layouts/base.volt" %}
{% block pagetop %}
<a href="/users" title="Back" class="btn btn-default"><span class="glyphicon glyphicon-arrow-left"></span></a>
{% endblock %}
{% block content %}
{{ flash.output() }}
<?php $this->partial("layouts/html/box/start",['icon'=>$row_menu->icon,'box_title'=>$row_menu->menu_title]); ?>
<form action="/users/edit/{{data.users.username}}" method="POST">
  <div class="row">
    <div class="col-md-6">
        <div class="form-group">
        <label for="exampleInputPassword1">Username :</label>
        <input type="text" class="form-control" name="username" placeholder="Username" value="{{data.users.username}}" readonly>
      </div>
        <div class="form-group">
        <label for="email">Full name :</label>
        <input type="text" class="form-control" name="nama" placeholder="Full name" value="{{data.users.full_name}}">
      </div>
      <div class="form-group">
        <label for="exampleInputEmail1">Email :</label>
        <input type="text" class="form-control" name="email" placeholder="Email" value="{{data.users.email}}">
      </div>
      <div class="form-group">
        <label for="exampleInputPassword1">Status :</label>
        <select name="status" class="form-control" id="status">
            <option value="0">Tidak Aktif</option>
            <option value="1">Aktif</option>
        </select>
      </div>
    </div>
    <div class="col-md-6">
        <div class="form-group">
            <label for="exampleInputPassword1">Roles :</label>
            {{data.list_roles}}
        </div>
        <div class="form-group">
            <label for="roles">Access Posting :</label>
            {{data.list_post_type}}
        </div>
        <div class="form-group">
            <label for="roles">Show all post author :</label>
            {{data.list_show_author}}
        </div>
        <div class="form-group" id="box-list-author">
            <label for="roles">Mapping Author :</label>
            {{data.list_author}}
        </div>
    </div>
  </div>
  <button type="submit" class="btn btn-success">Submit</button>
  <a href="/users" class="btn btn-default">Kembali</a>
</form>
<?php $this->partial("layouts/html/box/end"); ?>

<script>
$(document).ready(function(){
    $('#status').val('{{data.users.status}}');
    $('#list_post_type').chosen().trigger('chosen:updated');
    $('#list_author').chosen();
    if($('#list_show_author').val() == 'Y'){
        $('#box-list-author').addClass('hidden');
    }else{
        $('#box-list-author').removeClass('hidden');
    }
});
function show_list_author(stts){
    if(stts == 'N'){
        $('#box-list-author').removeClass('hidden');
    }else{
        $('#box-list-author').addClass('hidden');
    }
}
</script>
{% endblock %}