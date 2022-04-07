<h3 style="margin-top: 0;border-bottom: 4px double #ddd;padding-bottom: 5px;color: whitesmoke;font-weight: bold; text-shadow: 1px 1px 5px black;font-family: tes-font;">Kategori</h3>
<ul class="list-unstyled">
{% if list_category|length > 0 %}
{% for val_category in list_category %}
<li style="padding: 7px;border-bottom: 1px dotted #ddd;"><a href="/index/category/{{val_category.slug}}"><i class="fa fa-tag"></i> {{val_category.category}}</a></li>
{% endfor %}
{% endif %}
</ul>