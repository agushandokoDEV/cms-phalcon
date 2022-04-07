{% extends "layouts/base.volt" %}
{% block pagetop %}
<a href="/roles" title="Back" class="btn btn-default"><span class="glyphicon glyphicon-arrow-left"></span></a>
{% endblock %}
{% block content %}
{{ flash.output() }}
<?php $this->partial("layouts/html/box/start",['icon'=>$row_menu->icon,'box_title'=>$row_menu->menu_title]); ?>
<form action="/roles/add" method="POST" id="form-add">
  <div class="form-group">
    <label for="exampleInputEmail1">Role</label>
    <input type="text" class="form-control" name="role" placeholder="Nama Role">
  </div>
  <div class="form-group">
    <label for="exampleInputPassword1">Deskripsi</label>
    <textarea class="form-control" rows="3" name="deskripsi" placeholder="Deskripsi roles"></textarea>
  </div>
  <button type="submit" class="btn btn-success">Submit</button>
  <a href="/roles" class="btn btn-default">Kembali</a>
</form>
<?php $this->partial("layouts/html/box/end"); ?>
<script>
$(document).ready(function(){
    $('#form-add').formValidation({
        framework: 'bootstrap',
        locale: 'id_ID',
        fields: {
            role: {
                validators: {
                    notEmpty: {},
                    stringLength: {
                        min: 3,
                        max: 30
                    },
                    regexp: {
                        regexp: /^[A-Za-z0-9_\ ]+$/
                    }
                }
            },
            deskripsi: {
                validators: {
                    notEmpty: {},
                }
            }
        }
    });
});
</script>
{% endblock %}