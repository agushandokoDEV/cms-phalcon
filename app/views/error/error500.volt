{% extends "layouts/errors.volt" %}
{% block content %}
<div class="error_box">
	<h1>{{title}}</h1>
	<p>The page/file you've requested has been moved or taken off the site.</p>
	<a href="javascript:history.back()" class="back_link btn btn-default btn-sm">Go back</a>
</div>
{% endblock %}