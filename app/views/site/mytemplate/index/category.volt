{% extends "layouts/base.volt" %}
{% block content %}
<div class="panel panel-default">
  <div class="panel-heading">
    <h3 class="panel-title">{{title|stripslashes}}</h3>
  </div>
  {% if content.list_posting.items|length > 0 %}
  <div class="panel-body">
    {% for val_post in content.list_posting.items %}
    <div class="media">
        <div class="media-left">
            <a href="/index/detail/{{val_post.post_slug}}"> 
                {% if val_post.post_cover == null %}
                <img style="width: 64px; height: 64px;" src="/img/no-image.jpg" class="media-object img-circle img-thumbnail" alt="64x64">
                {% else %}
                <img style="width: 64px; height: 64px;" src="{{val_post.media_path}}" class="media-object img-circle img-thumbnail"/>
                {% endif %} 
            </a> 
        </div> 
        <div class="media-body"> 
            <a href="/index/detail/{{val_post.post_slug}}"><h4 class="media-heading">{{val_post.post_title|stripslashes}}</h4></a> 
            <span class="label label-success">{{val_post.category}}</span>
            <br />
            <?php $this->myhelp->char_limit(preg_replace("#<(.*)/(.*)>#iUs", "", $val_post->post_content),400) ?>
        </div> 
    </div>
    <hr />
    {% endfor %}
    
  </div>
  <div class="panel-footer" style="padding: 0;">
    <nav class="text-center nav-pills-blue">
      <ul class="pagination pagination-blue" style="margin: 10px 0;">
        <li>
          <a href="/index/category/{{content.query_tags}}" aria-label="Previous">
            <span aria-hidden="true"><i class="fa fa-backward"></i></span>
          </a>
        </li>
        <li><a href="/index/category/{{content.query_tags}}?page={{content.list_posting.before}}">Prev</a></li>
        <li><a href="/index/category/{{content.query_tags}}?page={{content.list_posting.next}}">Next</a></li>
        <li>
          <a href="/index/category/{{content.query_tags}}?page={{content.list_posting.last}}" aria-label="Next">
            <span aria-hidden="true"><i class="fa fa-forward"></i></span>
          </a>
        </li>
      </ul>
    </nav>
  </div>
  {% endif %}
</div>
{% endblock %}