{% extends "layouts/base.volt" %}
{% block pagetop %}
<a href="/media" title="Back" class="btn btn-default"><span class="glyphicon glyphicon-arrow-left"></span></a>
{% endblock %}
{% block content %}
{{ flash.output() }}
<div class="row">
    <div class="col-md-6">
        <?php $this->partial("layouts/html/box/start",['icon'=>$row_menu->icon,'box_title'=>$row_menu->menu_title]); ?>
        <form action="/media/add" method="POST" id="form-add" class="form-media" enctype="multipart/form-data">
          <input type="hidden" name="album_id" id="album_id"/>
          <div class="form-group">
            <label for="exampleInputEmail1">Caption</label>
            <input type="text" class="form-control" name="caption" placeholder="Caption" required>
          </div>
          <div class="form-group">
            <label for="exampleInputEmail1">Media</label>
            <input type="file" class="form-control" name="file" placeholder="Media" required>
          </div>
          <button id="btn-upload" type="submit" class="btn btn-success">Submit</button>
          <a href="/media" class="btn btn-default">Kembali</a>
        </form>
        <?php $this->partial("layouts/html/box/end"); ?>
    </div>
    <div class="col-md-6">
        <?php $this->partial("layouts/html/box/start",['icon'=>'fa fa-image','box_title'=>'Album']); ?>
        <div class="form-inline">
          <div class="form-group">
            <div class="input-group">
              <input type="text" class="form-control" id="txt-search-folder" placeholder="Search album" onkeyup="on_search_folder(this)">
            </div>
          </div>
          <button type="button" id="btn-search-folder" class="btn btn-default"><i class="fa fa-search"></i></button>
        </div>
        <br />
        <div id="tree-data-container"></div>
        <?php $this->partial("layouts/html/box/end"); ?>
    </div>
</div>
<script>
var album_id=null;
var album=$('#tree-data-container');

$(document).ready(function(){
    album.jstree({
        "search": {
            "show_only_matches": true,
            'case_insensitive': true
        },
        'plugins' : ['state','dnd','sort','types','contextmenu','unique','search'],
        'core' : {
            'data' : {
              'url' : '/media/index/rstree?operation=get_node',
              'data' : function (node) {
                return { 'id' : node.id };
              },
              "dataType" : "json"
            }
            ,'check_callback' : true,
            'themes' : {
              'responsive' : false
            }
      }
    }).on('ready.jstree', function(e, data) {
        console.log(e);
		//tree_album.jstree('open_all');
        //data.instance.select_node(["j1_1"]);
	}).on("select_node.jstree", function (e, data) {
        album_id = data.node.id;
        $('#album_id').val(album_id);
        console.log(data.node.id);
    }).on('create_node.jstree', function (e, data) {
      $.get('/media/index/rstree?operation=create_node', { 'id' : data.node.parent, 'position' : data.position, 'text' : data.node.text })
        .done(function (d) {
          data.instance.set_id(data.node, d.id);
        })
        .fail(function () {
          data.instance.refresh();
        });
    }).on('rename_node.jstree', function (e, data) {
      $.get('/media/index/rstree?operation=rename_node', { 'id' : data.node.id, 'text' : data.text })
        .fail(function () {
          data.instance.refresh();
        });
    }).on('delete_node.jstree', function (e, data) {
      $.get('/media/index/rstree?operation=delete_node', { 'id' : data.node.id })
        .fail(function () {
          data.instance.refresh();
        });
    }).on('move_node.jstree', function (e, data) {
		$.get('/media/index/rstree?operation=move_node', { 'id' : data.node.id, 'parent' : data.parent })
			.done(function (d) {
				//data.instance.load_node(data.parent);
				data.instance.refresh();
			})
			.fail(function () {
				data.instance.refresh();
			});
	}).on('copy_node.jstree', function (e, data) {
		$.get('/media/index/rstree?operation=copy_node', { 'id' : data.original.id, 'parent' : data.parent })
		.done(function (d) {
			//data.instance.load_node(data.parent);
			data.instance.refresh();
		})
		.fail(function () {
			data.instance.refresh();
		});
	}).on('search.jstree', function (nodes, str, res) {
        if (str.nodes.length===0) {
            album.jstree(true).hide_all();
        }
    });
    
    $('.form-media').ajaxForm({
    
        beforeSend: function() {
            var percentVal = '0%';
            //console.log(percentVal);
        },
        uploadProgress: function(event, position, total, percentComplete) {
            var percentVal = percentComplete + '%';
            console.log(percentVal);
            $('#btn-upload').html('Loading...<i class="fa fa-refresh fa-spin"></i> '+percentVal);
            //console.log(percentVal, position, total);
        },
        complete: function(xhr) {
            var rs = jQuery.parseJSON(xhr.responseText);
            if(rs.success){
                location.reload();
            }else{
                $('.form-media')[0].reset();
                alert(rs.error.message);
            }
            $('#btn-upload').text('Submit');
        }
    });
    
    $('#btn-search-folder').click(function(e){
        album.jstree(true).show_all();
        album.jstree('search', $('#txt-search-folder').val());
    });
});

function on_search_folder(){
    var x = event.which || event.keyCode;
    if(x == 13){
        console.log();
        album.jstree(true).show_all();
        album.jstree('search', $('#txt-search-folder').val());
    }
}
</script>
{% endblock %}