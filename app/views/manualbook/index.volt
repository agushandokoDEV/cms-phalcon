{% extends "layouts/base.volt" %}
{% block pagetop %}
<h1><i class="{{row_menu.icon}}"></i> {{row_menu.menu_title}}<small>{{row_menu.description}}</small></h1>
{% endblock %}
{% block content %}
<div id="flipbookContainer"></div>
<script>
	var flipBook;
	var link_video="/plugin/dflip/books/dFlipManual.pdf";
    var height_doc="500";
	var duration_doc="600";
	var webgl_doc="1";
	var enableDownload="1";
	var limit="320";
	var backgroundColor="#aaaaaa";
	var scrollwheel="0";
	jQuery(document).ready(function () {
	DFLIP.defaults.pdfjsSrc = '/plugin/dflip/js/libs/pdf.min.js';
	DFLIP.defaults.pdfjsWorkerSrc = '/plugin/dflip/js/libs/pdf.worker.min.js';
	DFLIP.defaults.threejsSrc = '/plugin/dflip/js/libs/three.min.js';
	DFLIP.defaults.threejsSrc = '/plugin/dflip/js/libs/three.min.js';
	DFLIP.defaults.mockupjsSrc = '/plugin/dflip/js/libs/mockup.min.js';
	DFLIP.defaults.soundFile = '/plugin/dflip/sound/turn2.mp3';

	var options = {
    webgl: true, //sets if to use 3d or not (true|false)
    enableDownload: true, // enableDownload of PDF files (true|false)
    height: 500,
		limit: 320,// default 500, height of the container // value(eg: 320) or percentage (eg: '50%')// calculaton limit: minimum 320, max window height
    duration: 600,// duration of page turn in milliseconds
    backgroundColor: "grey",//color value in hexadecimal
    scrollWheel :false//set if the zoom changes on mouse scroll (true|false)
    };

	//uses source from online(make sure the file has CORS access enabled if used in cross domain)
	
	var pdf = link_video;
	var options = {hard: 'none', webgl: webgl_doc, height: height_doc, duration: duration_doc,enableDownload:enableDownload,backgroundColor:backgroundColor,scrollWheel:scrollwheel,limit:limit};

	flipBook = $("#flipbookContainer").flipBook(pdf, options);
	});
</script>
{% endblock %}