{% if list_media|length > 0 %}
<h3 style="margin-top: 0;border-bottom: 4px double #ddd;padding-bottom: 5px;color: whitesmoke;font-weight: bold; text-shadow: 1px 1px 5px black;font-family: tes-font;">Galery</h3>
<div class="row">
    {% for mval in list_media %}
        <div class="col-md-2">
            <img class="img-thumbnail" src="{{mval.media_path}}" style="min-height: 100px;max-height: 100px;"/>
        </div>
    {% endfor %}
</div>
{% endif %}