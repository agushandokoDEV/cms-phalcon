{% extends "layouts/base.volt" %}
{% block pagetop %}
<a href="/users" title="Back" class="btn btn-default"><span class="glyphicon glyphicon-arrow-left"></span></a>
{% endblock %}
{% block content %}
{{ flash.output() }}
<?php $this->partial("layouts/html/box/start",['icon'=>$row_menu->icon,'box_title'=>$row_menu->menu_title]); ?>
<form action="/users/add" method="POST" id="form-add">
  <div class="row">
    <div class="col-md-6">
        <div class="form-group">
            <label for="email">Full name :</label>
            <input type="text" class="form-control" name="nama" placeholder="Full name">
          </div>
          <div class="form-group">
            <label for="email">Email :</label>
            <input type="text" class="form-control" name="email" placeholder="Email">
          </div>
          <div class="form-group">
            <label for="username">Username :</label>
            <input type="text" class="form-control" name="username" placeholder="Username">
          </div>
          
        </div>
    <div class="col-md-6">
        <div class="form-group">
            <label for="roles">Roles :</label>
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
    $('#list_post_type').chosen();
    $('#list_author').chosen();
    $('#box-list-author').addClass('hidden');
    $('#form-add').formValidation({
        framework: 'bootstrap',
        locale: 'id_ID',
        fields: {
            username: {
                validators: {
                    notEmpty: {},
                    stringLength: {
                        min: 3,
                        max: 30
                    },
                    regexp: {
                        regexp: /^[a-z0-9_\.]+$/,
                        message: 'Karakter tidak valid, gunakan titik(.) atau underscore(_) untuk pemisah karakter'
                    }
                }
            },
            email: {
                validators: {
                    notEmpty: {},
                    emailAddress: {}
                }
            },
        }
    });
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