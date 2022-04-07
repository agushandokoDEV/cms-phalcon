
{% if list_tags|length > 0 %}
<h3 style="margin-top: 0;border-bottom: 4px double #ddd;padding-bottom: 5px;color: whitesmoke;font-weight: bold; text-shadow: 1px 1px 5px black;font-family: tes-font;">Tags</h3>
<ul class="list-unstyled">
{% for val in list_tags %}
<li style="padding: 7px;border-bottom: 1px dotted #ddd;"><a href="/index/tags/{{val.tags_slug}}"><i class="fa fa-tag"></i> <i>{{val.tags_title}}</i></a></li>
{% endfor %}
</ul>
{% endif %}