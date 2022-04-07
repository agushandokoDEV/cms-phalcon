{% extends "layouts/base.volt" %}
{% block pagetop %}
<a href="/advertising" title="Back" class="btn btn-default"><span class="glyphicon glyphicon-arrow-left"></span></a>
{% endblock %}
{% block content %}
{{ flash.output() }}
<style>
.img-list-media{
    width: 100%;
    height: 100px;
    padding: 0;
    margin-bottom: 5px;
    border:0;
    border:1px inset #ddd;
}
.img-list-media-selected{
    border:3px inset #5cb85c;
}
ul.demo-list-media{
    position: absolute;
    top: 50px;
    left: 0;
    bottom: 0;
    overflow: auto;
    outline: 0;
}
ul.demo-list-media li.demo-list-li-media{
    position: relative;
    float: left;
    padding: 3px;
    margin: 0;
    color: #444;
    cursor: pointer;
    list-style: none;
    text-align: center;
    box-sizing: border-box;
    width:30%;
}
.box-for-loading{position: relative;}
.overlay{position: absolute;left: 0; top: 0; right: 0; bottom: 0;z-index: 2;background-color: rgba(255,255,255,0.8);}
.overlay-content {
    position: absolute;
    transform: translateY(-50%);
     -webkit-transform: translateY(-50%);
     -ms-transform: translateY(-50%);
    top: 50%;
    left: 0;
    right: 0;
    text-align: center;
    color: #555;
}

</style>
<div class="row">
    <div class="col-md-8">
          <?php $this->partial("layouts/html/box/start",['icon'=>$row_menu->icon,'box_title'=>$row_menu->menu_title]); ?>
          <form action="/advertising/add" method="POST" id="form-add">
            <div class="hidden" id="list-media-attch"></div>
            <div class="form-group">
                <label for="exampleInputEmail1">Advertiser :</label>
                <input type="text" class="form-control" name="advertiser" placeholder="Advertiser">
            </div>
            <div class="form-group">
                <label for="exampleInputEmail1">Page location :</label>
                <select name="post_location" class="form-control">
                    <option value="all">All</option>
                    <option value="home">Home</option>
                </select>
            </div>
            <div class="form-group">
                <label for="exampleInputEmail1">Contract :</label>
                <select name="contract" class="form-control">
                    <option value="new">New</option>
                    <option value="extend">Extend</option>
                </select>
            </div>
            <div class="form-group">
                <label for="exampleInputEmail1">Price :</label>
                <input type="text" class="form-control" name="price" placeholder="Price">
            </div>
            <div class="form-group">
                <label for="exampleInputEmail1">Web URL :</label>
                <input type="text" class="form-control" name="url_web" placeholder="Web URL">
            </div>
            <div class="form-group">
                <label for="exampleInputEmail1">Date :</label>
                <div class="row">
                    <div class="col-md-6">
                        <input type="text" class="form-control dp" name="start_date" placeholder="From">
                    </div>
                    <div class="col-md-6">
                        <input type="text" class="form-control dp" name="end_date" placeholder="To">
                    </div>
                </div>
            </div>
          <button type="submit" class="btn btn-success">Submit</button>
          <a href="/advertising" class="btn btn-default">Kembali</a>
        </form>
        <?php $this->partial("layouts/html/box/end"); ?>
    </div>
    <div class="col-md-4">
        <div class="box box-info">
            <div class="box-header with-border">
              <div class="row">
                <div class="col-md-8">
                    <h3 class="box-title"><i class="fa fa-image"></i> Media Selected</h3>
                </div>
                <div class="col-md-4">
                    <div class="pull-right">
                        <button onclick="open_media()" class="btn btn-success btn-xs">File Manager</button>
                    </div>
                </div>
              </div>
            </div>
            <div class="box-body">
                <ul class="products-list product-list-in-box" id="li-box-media-attach">
                    
                </ul>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" tabindex="-1" role="dialog" id="mdl-media" data-keyboard="false" data-backdrop="static">
  <div class="modal-dialog modal-lg" role="document" style="width: 95%;">
    <div class="modal-content">
      <div class="modal-header" style="background-color: #FCFCFC;">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-picture-o"></i> File Manager</h4>
      </div>
      <div class="modal-body">
        <div class="row">
            <div class="col-md-3">
                <div class="panel panel-default">
                  <div class="panel-heading">Media Album</div>
                  <div class="panel-body">
                    <div class="form-inline">
                      <div class="form-group">
                        <div class="input-group">
                          <input type="text" class="form-control" id="txt-search-folder" placeholder="Search album" onkeyup="on_search_folder(this)">
                        </div>
                      </div>
                      <button type="button" id="btn-search-folder" class="btn btn-default"><i class="fa fa-search"></i></button>
                    </div>
                    <br />
                    <div id="tree-data-container" class="tree-data-container"></div>
                  </div>
                </div>
            </div>
            <div class="col-md-9">
                <!-- Nav tabs -->
                <ul class="nav nav-tabs" role="tablist">
                    <li role="presentation" id="li-tab-upload"><a onclick="open_tab('upload')" href="#tab-upload" aria-controls="tab-upload" role="tab" data-toggle="tab"><i class="fa fa-upload"></i> Upload Files</a></li>
                    <li role="presentation" id="li-tab-attach"><a onclick="open_tab('attach')" href="#tab-attach" aria-controls="tab-attach" role="tab" data-toggle="tab"><i class="fa fa-file-archive-o"></i> Attachment</a></li>
                </ul>
                
                <!-- Tab panes -->
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane" id="tab-upload">
                        <div class="thumbnail" style="border: 0; margin-top: 10px;">
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="panel panel-default">
                                      <div class="panel-heading">
                                        Form Upload
                                      </div>
                                      <div class="panel-body">
                                        <form class="form-media" action="/media/add" method="POST" id="form-add" enctype="multipart/form-data">
                                          <input type="hidden" name="album_id" id="album_id"/>
                                          <div class="form-group">
                                            <label for="exampleInputEmail1">Caption</label>
                                            <input type="text" class="form-control" name="caption" placeholder="Caption" required>
                                          </div>
                                          <div class="form-group">
                                            <label for="exampleInputEmail1">Media</label>
                                            <input id="preview_gambar" type="file" class="form-control" name="file" placeholder="Media" required>
                                          </div>
                                          <button type="submit" class="btn btn-success" id="btn-upload">Submit</button>
                                          
                                        </form>
                                      </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                    <div role="tabpanel" class="tab-pane" id="tab-attach">
                        <div class="thumbnail" style="border: 0; margin-top: 10px;">
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <div class="form-inline">
                                          <div class="form-group">
                                            <input type="text" class="form-control input-sm dp" id="fil-date-attach"/>
                                          </div>
                                          <div class="form-group">
                                            <input id="fil-search-attach" type="text" class="form-control input-sm" placeholder="Search item">
                                            <input type="hidden" id="list-mime-attach" value="image"/>
                                          </div>
                                          <button onclick="get_list_media()" type="button" class="btn btn-sm btn-default" style="background-color: #fff;border-radius: 0;"><i class="fa fa-search"></i></button>
                                          <button onclick="checked_attach()" type="button" class="btn btn-sm btn-default" style="background-color: #fff;border-radius: 0;"><i class="fa fa-check"></i></button>
                                        </div>
                                      </div>
                                      <div class="panel-body box-list-media" id="box-list-media-attach" onscroll="_on_scroll_box_media()">
                                        <div class="row">
                                            <div class="list-dt-media" id="list-dt-media-attach"></div>
                                        </div>
                                      </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="panel panel-default">
                                      <div class="panel-heading">Media Detail</div>
                                      <div class="panel-body" style="min-height: 200px;">
                                        <div id="row-media-dtl-attach" class="row-media-dtl box-for-loading">
                                            <p class="text-center">No media selected</p>
                                        </div>
                                      </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
      </div>
      <div class="modal-footer hidden">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script>
var album=$('#tree-data-container');
var tab_active='upload';
var album_id=$('#album_id');
var myloading='<div class="text-center"><p><i class="fa fa-refresh fa-spin"></i><br/>Loading...</p></div>';
var media_attach=[];
var check_media_attach=true;
var is_open_mdl_media=false;

$(document).ready(function(){
    $(".dp").datepicker({
        autoclose:true,
        format: "yyyy-mm-dd"
    });
    // MEDIA UPLOAD
    $('.form-media').ajaxForm({
    
        beforeSend: function() {
            var percentVal = '0%';
            //console.log(percentVal);
        },
        uploadProgress: function(event, position, total, percentComplete) {
            var percentVal = percentComplete + '%';
            //console.log(percentVal);
            $('#btn-upload').html('Loading...<i class="fa fa-refresh fa-spin"></i> '+percentVal);
            //console.log(percentVal, position, total);
        },
        complete: function(xhr) {
            var rs = jQuery.parseJSON(xhr.responseText);
            if(rs.success){
                $('.form-media')[0].reset();
            }else{
                alert(rs.error.message);
            }
            $('#btn-upload').text('Submit');
        }
    });
    
    $('#btn-search-folder').click(function(e){
        album.jstree(true).show_all();
        album.jstree('search', $('#txt-search-folder').val());
    });
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
        //console.log(e);
		//tree_album.jstree('open_all');
        //data.instance.select_node(["j1_1"]);
	}).on("select_node.jstree", function (e, data) {
        //album_id = data.node.id;
        album_id.val( data.node.id);
        if(is_open_mdl_media){
            get_list_media();
        }
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
	})
    .on('search.jstree', function (nodes, str, res) {
        if (str.nodes.length===0) {
            album.jstree(true).hide_all();
        }
    });
});

function open_media(){
    $('#li-tab-'+tab_active).addClass('active');
    $('#tab-'+tab_active).addClass('active');
    is_open_mdl_media=true;
    $('#mdl-media').modal('show');
    open_selected_tab();
    //open_insert_media();
}

function open_selected_tab(){
    if(tab_active == 'attach'){
        get_list_media();
    }
}

function open_tab(tab){
    tab_active=tab;
    $('#row-media-dtl-'+tab).html('<p class="text-center">No media selected</p>');
    $('.list-dt-media').html('');
    open_selected_tab();
    media_last_selected=null;
    if(tab == 'cover'){
        $('#box-btn-set-cover').html('');
    }
}

function get_list_media(offset=0){
    var albm_id = album_id.val();
    var m_type=$('#list-mime-'+tab_active).val();
    var txt_search=$('#fil-search-'+tab_active).val();
    var m_date=$('#fil-date-'+tab_active).val();
    $('#list-dt-media-'+tab_active).html(myloading);
    $.get('/media/index/get_list_media',{album:albm_id,type:m_type,keyword:txt_search,m_date:m_date,offset:offset},function(r){
        var rs=jQuery.parseJSON(r);
        if(rs.success){
            $('#list-dt-media-'+tab_active).html(rs.data);
            media_is_selected();
            if(check_media_attach){
                $('.checkbox-media-selected').removeClass('hidden');
            }
        }else{
            alert(rs.error.message);
        }
    });
    //console.log(media_attach);
}

function media_is_selected(){
    if(media_attach.length > 0){
        for(i=0;i<media_attach.length; i++){
            $('#media-selected-'+media_attach[i]).addClass('img-list-media-selected');
            $('#checkbox-media-selected-'+media_attach[i]).prop('checked', true);
        }
    }
}

function media_selected(dt_media_id){
    $('#box-btn-set-cover').html('');
    if(check_media_attach){
        if(media_attach.indexOf(dt_media_id) >= 0){
            var index=media_attach.indexOf(dt_media_id);
            media_attach.splice(index,1);
            $('#media-selected-'+dt_media_id).removeClass('img-list-media-selected');
            $('#checkbox-media-selected-'+dt_media_id).prop('checked', false);
            
        }else{
            $('#media-selected-'+dt_media_id).addClass('img-list-media-selected');
            $('#checkbox-media-selected-'+dt_media_id).prop('checked', true);
            media_attach.push(dt_media_id);
        }
    }else{
        $('.img-list-media').removeClass('img-list-media-selected');
        $('#media-selected-'+dt_media_id).addClass('img-list-media-selected');
        if(tab_active == 'cover'){
            var btn_txt_cover='Set post over';
            if(media_cover_selected != null){
                btn_txt_cover='Update post cover'
            }
            $('#box-btn-set-cover').html('<button id="btn-set-cover" style="width: 100%;" onclick="_selected_cover()" type="button" class="btn btn-sm btn-default" style="background-color: #fff;border-radius: 0;">'+btn_txt_cover+'</button>');
        }else{
            $('#box-btn-set-cover').html('');
        }
    }
     $('.row-media-dtl').html('<p class="text-center">No media selected</p>');
    get_media_dtl(dt_media_id);
}

function get_media_dtl(pk){
    $('#row-media-dtl-'+tab_active).html(myloading);
    var dt='';
    var other='';
    
    $.get('/media/index/get_detail_media',{pk:pk},function(r){
        var rs=jQuery.parseJSON(r);
        //console.log(rs);
        if(rs.success){
            media_last_selected=rs.data;
            if(rs.data.media_type == 'video'){
                var d='-';
                if(rs.data.video_duration != null){
                    d=rs.data.video_duration;
                }
                other +='<br/>Duration : '+d;
            }
            dt=rs.data.media_uri+'<br/><br/><address><strong>'+rs.data.media_caption+'</strong><br>Date : '+rs.data.media_date+'<br>Type : '+rs.data.media_type+' ('+rs.data.file_extension+')<br>Size : '+rs.data.file_size+''+other+'<br>Author : '+rs.data.media_author;
            $('#row-media-dtl-'+tab_active).html(dt);
        }else{
            alert(rs.error.message);
        }
    })
}

function checked_attach(){
    if(media_attach.length > 0){
        $('#box-media-attach').removeClass('hidden');
        $.get('/advertising/index/list_media_attach',{media_attach:media_attach},function(r){
            var rs=jQuery.parseJSON(r);
            for(i=0; i<media_attach.length; i++){
                $('#list-media-attch').append('<div id="checked-attach-selected-'+media_attach[i]+'"><input type="hidden" name="list_media_attch[]" value="'+media_attach[i]+'"/></div>');
            }
            $('#li-box-media-attach').html(rs.data);
        });
        
    }else{
        $('#list-media-attch').html('');
        $('#box-media-attach').addClass('hidden');
    }
}
function del_item_media_attach(param_id){
    $('#checked-attach-selected-'+param_id).remove();
    $('#media-list-item-'+param_id).remove();
    media_attach.splice( media_attach.indexOf(param_id) , 1) 
}
</script>
{% endblock %}