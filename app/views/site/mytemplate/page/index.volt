{% extends "layouts/base.volt" %}
{% block content %}

<div class="media">
    <div class="media-body"> 
        <h4 class="media-heading">{{data.post_title|stripslashes}}</h4>
        <span class="label label-default">{{data.publish_on}}</span>
        <br /><br />
        {{data.post_content}}
    </div> 
</div>
{% endblock %}