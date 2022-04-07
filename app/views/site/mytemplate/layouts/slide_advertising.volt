{% if advertising_all_page|length > 0 %}
<p>Sponsor by : {{advertising_all_page['row']['advertiser']}}</p>
<div id="slide-all-page" class="carousel slide" data-ride="carousel">
    <ol class="carousel-indicators">
        {% for all_advs in advertising_all_page['list_media'] %}
        <li data-target="#slide-all-page" data-slide-to="{{all_advs['media_id']}}" class=""></li>
        {% endfor %}
    </ol>
    <div class="carousel-inner">
        {% for all_advs in advertising_all_page['list_media'] %}
        <div class="item">
            <img style="width: 100%;" src="{{all_advs['media_uri']['lg']}}" alt="{{all_advs['media_caption']}}">
            <div class="carousel-caption">
              {{all_advs['media_caption']}}
            </div>
        </div>
        {% endfor %}
    </div>
    <a class="left carousel-control" href="#slide-all-page" data-slide="prev">
      <span class="fa fa-angle-left"></span>
    </a>
    <a class="right carousel-control" href="#slide-all-page" data-slide="next">
      <span class="fa fa-angle-right"></span>
    </a>
</div>
<p><a href="{{advertising_all_page['row']['url_web']}}" target="_blank">{{advertising_all_page['row']['advertiser']}}</a></p>
{% endif %}