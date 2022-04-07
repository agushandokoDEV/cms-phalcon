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
            <br /><br />
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
          <a href="/" aria-label="Previous">
            <span aria-hidden="true"><i class="fa fa-backward"></i></span>
          </a>
        </li>
        <li><a href="/index/index?page={{content.list_posting.before}}">Prev</a></li>
        <li><a href="/index/index?page={{content.list_posting.next}}">Next</a></li>
        <li>
          <a href="/index/index?page={{content.list_posting.last}}" aria-label="Next">
            <span aria-hidden="true"><i class="fa fa-forward"></i></span>
          </a>
        </li>
      </ul>
    </nav>
  </div>
  {% endif %}
</div>

{% if advertising_home_page|length > 0 %}
<div class="modal fade in" tabindex="-1" role="dialog" id="mdl-advs">
  <div class="modal-dialog modal-md" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">{{advertising_home_page['row']['advertiser']}}</h4>
      </div>
      <div class="modal-body">
        
        <div id="slide-home-page" class="carousel slide" data-ride="carousel">
            <ol class="carousel-indicators">
                {% for home_advs in advertising_home_page['list_media'] %}
                <li data-target="#slide-home-page" data-slide-to="{{home_advs['media_id']}}" class=""></li>
                {% endfor %}
            </ol>
            <div class="carousel-inner">
                {% for home_advs in advertising_home_page['list_media'] %}
                <div class="item">
                    <img style="width: 100%;" src="{{home_advs['media_uri']['lg']}}" alt="{{home_advs['media_caption']}}">
                    <div class="carousel-caption">
                      {{home_advs['media_caption']}}
                    </div>
                </div>
                {% endfor %}
            </div>
            <a class="left carousel-control" href="#slide-home-page" data-slide="prev">
              <span class="fa fa-angle-left"></span>
            </a>
            <a class="right carousel-control" href="#slide-home-page" data-slide="next">
              <span class="fa fa-angle-right"></span>
            </a>
        </div>
        <p><a href="{{advertising_home_page['row']['url_web']}}" target="_blank">{{advertising_home_page['row']['url_web']}}</a></p>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
{% endif %}
{% endblock %}