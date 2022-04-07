<div class="login_box">
	<form action="{{url('auth/dologin')}}" method="post" id="login_form">
		<div class="top_b">Sign in to Admin</div>    
		{{ flash.output() }}
        <input type="hidden" name="current_url" value="{{ router.getRewriteUri() }}"/>
		<div class="cnt_b">
			<div class="form-group">
				<div class="input-group">
					<span class="input-group-addon input-sm"><i class="glyphicon glyphicon-user"></i></span>
					<input class="form-control input-sm" type="text" id="username" name="username" placeholder="Username" />
				</div>
			</div>
			<div class="form-group">
				<div class="input-group">
					<span class="input-group-addon input-sm"><i class="glyphicon glyphicon-lock"></i></span>
					<input class="form-control input-sm" type="password" id="password" name="password" placeholder="Password" />
				</div>
			</div>
			<div class="form-group">
				<label class="checkbox-inline"><input type="checkbox" /> Remember me</label>
			</div>
		</div>
		<div class="btm_b clearfix">
			<button class="btn btn-default btn-sm pull-right" type="submit">Sign In</button>
			<span class="link_reg"><a href="#reg_form">Not registered? Sign up here</a></span>
		</div>  
	</form>
</div>