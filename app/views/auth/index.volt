{% extends "layouts/main.volt" %}
{% block content %}
<div class="login-box-body">
    <p class="login-box-msg">Sign in to start your session</p>
    
    <form action="/auth/dologin" method="post">
        <input type="hidden" name="current_url" value="{{ router.getRewriteUri() }}"/>
        <input type="hidden" name="login" value="login"/>
      <div class="form-group has-feedback">
        <input type="text" name="username" class="form-control" placeholder="username" id="username">
        <span class="glyphicon glyphicon-user form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <input type="password" name="password" id="password" class="form-control" placeholder="Password">
        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
      </div>
      <button type="submit" class="btn btn-md btn-primary btn-block btn-flat">Sign In</button>
    </form>
    <br />
    {{ flash.output() }}
    <div class="social-auth-links text-center hidden">
      <p>- OR -</p>
      <a href="#" class="btn btn-block btn-social btn-google btn-flat"><i class="fa fa-lock"></i>I forgot my password</a>
    </div>
    <!-- /.social-auth-links -->
  </div>
  <!-- /.login-box-body -->
<script>
$(function(){
    $('input').iCheck({
      checkboxClass: 'icheckbox_square-blue',
      radioClass: 'iradio_square-blue',
      increaseArea: '20%' // optional
    });
    $('#login_form').ajaxForm({
    
    beforeSend: function() {
       $('#btn-submit').html('<img src="/img/ajax_loader.gif"/>');
       console.log("before");
    },
    complete: function(xhr) {
        var rs = jQuery.parseJSON(xhr.responseText);
        $('#btn-submit').html('Sign In');
        console.log(rs);
    }
    });
});
</script>
{% endblock %}