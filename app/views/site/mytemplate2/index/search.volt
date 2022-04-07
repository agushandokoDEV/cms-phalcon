{% extends "layouts/base.volt" %}
{% block content %}
<div class="panel panel-default">
  <div class="panel-heading" style="padding-bottom: 0;">
    <div class="row">
        <div class="col-md-12">
            <form action="/index/search" method="GET">
              <div class="row">
                <div class="col-md-12">
                    <div class="form-group">
                    <label class="sr-only" for="exampleInputPassword3">Password</label>
                        <div class="input-group">
                      <input type="text" name="keyword" class="form-control" value="{{content.search_keyword}}" placeholder="Masukan kata pencarian...">
                      <span class="input-group-btn">
                        <button class="btn btn-info" type="submit"><i class="fa fa-search"></i></button>
                      </span>
                    </div>
                  </div>
                </div>
              </div>
            </form>
        </div>
    </div>
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
            <a href="/index/detail/{{val_post.post_slug}}"><h4 class="media-heading">{{val_post.post_title}}</h4></a> 
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
          <a href="/index/search?keyword={{content.search_keyword}}" aria-label="Previous">
            <span aria-hidden="true"><i class="fa fa-backward"></i></span>
          </a>
        </li>
        <li><a href="/index/search?keyword={{content.search_keyword}}&page={{content.list_posting.before}}">Prev</a></li>
        <li><a href="/index/search?keyword={{content.search_keyword}}&page={{content.list_posting.next}}">Next</a></li>
        <li>
          <a href="/index/search?keyword={{content.search_keyword}}&page={{content.list_posting.last}}" aria-label="Next">
            <span aria-hidden="true"><i class="fa fa-forward"></i></span>
          </a>
        </li>
      </ul>
    </nav>
  </div>
  
  {% endif %}
</div>
{% endblock %}