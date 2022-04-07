{% extends "layouts/base.volt" %}
{% block content %}

<div class="media">
    <div class="media-body"> 
        <h4 class="media-heading">{{data.post_title}}</h4>
        <span class="label label-default">{{data.publish_on}}</span>
        <br /><br />
        {{data.post_content}}
    </div> 
</div>
<hr />
<?php $this->partial("layouts/list_media",['list_media'=>$list_media]);?>
{% endblock %}