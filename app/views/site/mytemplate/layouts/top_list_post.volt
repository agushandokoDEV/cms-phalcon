<h3 style="margin-top: 20px;border-bottom: 4px double #ddd;padding-bottom: 5px;color: whitesmoke;font-weight: bold; text-shadow: 1px 1px 5px black;font-family: tes-font;">Top list Article</h3>
{% if top_list_content|length > 0 %}
<div class="myWrapper">
<ul class="list-unstyled">
    
    {% for top_content in  top_list_content%}
    <li style="border-bottom: 1px solid #ddd;padding: 10px 0 10px 0;">
        <div class="media">
          <div class="media-left">
            <a href="/index/detail/{{top_content.post_slug}}">
                {% if top_content.post_cover == null %}
                <img class="media-object img-thumbnail no-radius" alt="64x64" style="width: 64px; height: 64px;" src="/img/no-image.jpg" data-holder-rendered="true">
                {% else %}
                <img class="media-object img-thumbnail no-radius" alt="64x64" style="width: 64px; height: 64px;" src="{{top_content.media_path}}" data-holder-rendered="true">
                {% endif %}
            </a>
          </div>
          <div class="media-body">
            <h5 class="media-heading"><a style="text-decoration: none;" href="/index/detail/{{top_content.post_slug}}">{{top_content.post_title|stripslashes}}</a></h5>
            <p><small>{{top_content.publish_on}}</small></p>
          </div>
        </div>
    </li>
    {% endfor %}
</ul>
</div>
{% endif %}