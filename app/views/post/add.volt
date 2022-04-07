{% extends "layouts/base.volt" %}

{% block pagetop %}
<a onclick="_onBack()" href="/post/index/{{row_post.post_type}}" title="Back" class="btn btn-default"><span class="glyphicon glyphicon-arrow-left"></span></a>
{% endblock %}
{% block content %}
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
#mymap {
    height: 300px;
}

</style>
{{ flash.output() }}

<form id="form-add-post" onsubmit="setFormSubmitting()" method="POST" action="/post/add/{{row_post.post_type}}">
<div class="row">
    <div class="col-md-8">
        <?php $this->partial("layouts/html/box/start",['icon'=>$row_post->post_icon,'box_title'=>$row_post->post_title]); ?>
        <div class="form-group">
            <label for="exampleInputEmail1">Title : </label>
            <div class="input-group input-group">
                <input id="post-title" type="text" class="form-control" placeholder="Title" name="title" id="post-title" autofocus required>
                    <span class="input-group-btn">
                      <button title="Generate slug" onclick="create_post_slug()" type="button" class="btn btn-default btn-flat"><span class="glyphicon glyphicon-link"></span></button>
                    </span>
            </div>
            <span class="text-sm" id="txt-slug"></span>
            <input type="hidden" name="post_id" value="{{data.post_id}}"/>
            <input type="hidden" name="post_slug" id="post-slug"/>
            <input type="hidden" id="media-post-cover" name="media_cover"/>
            <div class="hiddenx" id="list-media-attch"></div>
        </div>
        <div class="form-group">
            <label for="exampleInputEmail1">Category : </label>
            {{list_category}}
        </div>
        <div class="form-group">
            <label for="exampleInputEmail1">Tags : </label>
            {{list_post_tags}}
        </div>
        
        <div class="form-group hidden">
            <label for="exampleInputEmail1">Relation : </label>
            <select class="form-control input-smx" id="relasi-post" name="relasi_post" data-placeholder="Post Relation..."></select>
        </div>
        <div class="form-group">
            <label for="exampleInputEmail1">Location : </label>
            <div class="input-group input-group">
                <input id="pac-input" class="controls-maps form-control" type="text" placeholder="Masukan nama lokasi">
                    <span class="input-group-btn">
                      <button type="button" id="btn-togle-maps" class="btn btn-default btn-flat"><i class="fa fa-map-marker"></i></button>
                    </span>
            </div>
        </div>
        <div class="form-group">
            <div id="mymap" class="hidden"></div>
            <div id="infowindow-content">
              <img src="" width="20" height="20" class="img-circle hidden" id="place-icon">
              <span id="place-name" class="title"></span>
              <p id="place-address"></p>
            </div>
            <input type="hidden" id="location-name" name="location-name"/>
            <input type="hidden" id="location-addres" name="location-addres"/>
            <input type="hidden" id="location-lat" name="location-lat"/> 
            <input type="hidden" id="location-long" name="location-long"/>     
        </div>
        <div class="form-group">
            <!--<label for="exampleInputEmail1"><a href="javascript:void(0)" onclick="open_media()" class="btn btn-sm btn-success" style="border-radius: 2px;"><i class="fa fa-external-link"></i> File Manager</a></label>-->
            <textarea id="wysiwyg" class="form-control" rows="5" name="content"></textarea>
        </div>
        <?php $this->partial("layouts/html/box/end"); ?>
    </div>
    <div class="col-md-4">
        <?php $this->partial("layouts/html/box/start",['icon'=>$row_post->post_icon,'box_title'=>$row_post->post_title.' atribute']); ?>
        <div class="form-group">
            <label for="exampleInputEmail1">Language : </label>
            <select class="form-control" id="fil_lang" name="post_lang">
                <option value="id">Indonesia</option>
                <option value="en">English</option>                        
            </select>
        </div>
        <div class="form-group">
            <label for="exampleInputEmail1">Status : </label>
            <select class="form-control" name="status" id="post-stts">
                <option value="draft">Draft</option>
                <option value="publish">Publish</option>
            </select>
        </div>
        <div class="form-group">
            <label for="exampleInputEmail1">Schedule : </label>
            <input type="text" class="form-control dp2" name="schedule" id="post-schedule"/>
        </div>
        <div class="form-group">
            <div class="checkbox">
                <label>
                  <input id="input-reminder" name="input_reminder" type="checkbox" value="N"> Reminder
                </label>
            </div>
        </div>
        <div class="form-group hidden" id="box-input-reminder">
            <label for="exampleInputEmail1">Date : </label>
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group">
                        <input name="event_start" id="event_start" class="controls-maps form-control dp2" type="text" placeholder="Start">
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="form-group">
                        <input name="event_end" id="event_end" class="controls-maps form-control dp2" type="text" placeholder="End">
                    </div>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label for="exampleInputEmail1">Cover : </label>
            <div id="box-post-cover"></div>
        </div>
        <hr />
        <button class="btn btn-primary" id="btn-submit" style="width: 100%;" disabled>Publish</button>
        <?php $this->partial("layouts/html/box/end"); ?>
        
        <div class="box box-info hidden" id="box-media-attach">
            <div class="box-header with-border">
              <h3 class="box-title"><i class="fa fa-newspaper-o"></i> Media attachment</h3>
            </div>
            <div class="box-body">
                <ul class="products-list product-list-in-box" id="li-box-media-attach">
                    
                </ul>
            </div>
        </div>
        
    </div>
</div>
</form>
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
                    <li role="presentation" id="li-tab-cover"><a onclick="open_tab('cover')" href="#tab-cover" aria-controls="tab-cover" role="tab" data-toggle="tab"><i class="fa fa-file-picture-o"></i> Cover</a></li>
                    <li role="presentation" id="li-tab-insert"><a onclick="open_tab('insert')" href="#tab-insert" aria-controls="tab-insert" role="tab" data-toggle="tab"><i class="fa fa-file"></i> Insert Media</a></li>
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
                    <div role="tabpanel" class="tab-pane" id="tab-cover">
                        <div class="thumbnail" style="border: 0; margin-top: 10px;">
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <div class="form-inline">
                                          <div class="form-group">
                                            <input type="text" class="form-control input-sm dp" id="fil-date-cover"/>
                                          </div>
                                          <div class="form-group">
                                            <input id="fil-search-cover" type="text" class="form-control input-sm" placeholder="Search item">
                                            <input type="hidden" id="list-mime-cover" value="image"/>
                                          </div>
                                          <button onclick="get_list_media()" type="button" class="btn btn-sm btn-default" style="background-color: #fff;border-radius: 0;"><i class="fa fa-search"></i></button>
                                        </div>
                                      </div>
                                      <div class="panel-body box-list-media" id="box-list-media-cover" onscroll="_on_scroll_box_media()">
                                        <div class="row">
                                            <div class="list-dt-media" id="list-dt-media-cover"></div>
                                        </div>
                                      </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="panel panel-default">
                                      <div class="panel-heading">Media Detail</div>
                                      <div class="panel-body" style="min-height: 200px;">
                                        <div id="row-media-dtl-cover" class="row-media-dtl">
                                            <p class="text-center">No media selected</p>
                                        </div>
                                        <div id="box-btn-set-cover"></div>
                                      </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div role="tabpanel" class="tab-pane" id="tab-insert">
                        <div class="thumbnail" style="border: 0; margin-top: 10px;">
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="panel panel-default">
                                      <div class="panel-heading">
                                        <div class="form-inline">
                                          <div class="form-group">
                                            {{list_mime_type}}
                                          </div>
                                          <div class="form-group">
                                            <input type="text" class="form-control input-sm dp" id="fil-date-insert"/>
                                          </div>
                                          <div class="form-group">
                                            <input id="fil-search-insert" type="text" class="form-control input-sm" placeholder="Search item">
                                          </div>
                                          <button onclick="get_list_media()" type="button" class="btn btn-sm btn-default" style="background-color: #fff;border-radius: 0;"><i class="fa fa-search"></i></button>
                                          <button onclick="checked_insert()" type="button" class="btn btn-sm btn-default" style="background-color: #fff;border-radius: 0;"><i class="fa fa-check"></i></button>
                                        </div>
                                      </div>
                                      <div class="panel-body box-list-media" id="box-list-media-insert" onscroll="_on_scroll_box_media()">
                                        <div class="row">
                                            <div class="list-dt-media" id="list-dt-media-insert"></div>
                                        </div>
                                      </div>
                                    </div>
                                    
                                </div>
                                <div class="col-md-4">
                                    <div class="panel panel-default">
                                      <div class="panel-heading">Media Detail</div>
                                      <div class="panel-body" style="min-height: 200px;">
                                        <div id="row-media-dtl-insert" class="row-media-dtl">
                                            <p class="text-center">No media selected</p>
                                        </div>
                                      </div>
                                    </div>
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

<div class="modal fade" tabindex="-1" role="dialog" id="mdl-youtube" data-keyboard="false" data-backdrop="static">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button onclick="_on_close_mdl_ytube()" type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-youtube"></i> Youtube</h4>
      </div>
      <div class="modal-body">
        <div class="row">
            <div class="col-md-8">
                <div class="input-group input-group">
                    <input onkeyup="serach_youtube(event)" id="query-youtube" type="text" class="form-control" placeholder="Masukan judul video...">
                        <span class="input-group-btn">
                          <button onclick="serach_youtube(event)" type="button" class="btn btn-default btn-flat"><i class="fa fa-search"></i></button>
                        </span>
                </div>
                <br />
                <div id="load-list-youtube"></div>
            </div>
            <div class="col-md-4">
                <div id="dtl-video-ytube">
                    <div class="panel panel-default">
                        <div class="panel-heading">Youtube video Detail</div>
                        <div class="panel-body" style="min-height: 200px;">
                            <div style="min-height: 150px;">
                                <p class="text-center">No video selected</p>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <button style="width:100%" type="button" class="btn btn-sm btn-default" onclick="_on_close_mdl_ytube()">Close</button>
                                </div>
                                <div class="col-md-6">
                                    <button style="width:100%" type="button" class="btn btn-sm btn-default" disabled>Insert to content</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<script>
var album=$('#tree-data-container');
var album_id=$('#album_id');
var is_open_mdl_media=false;
var media_attach=[];
var check_media_attach=false;
var tab_active='upload';
var myloading='<div class="text-center"><p><i class="fa fa-refresh fa-spin"></i><br/>Loading...</p></div>';
var media_cover_selected=null;
var media_last_selected=null;
var formSubmitting = true;
var setFormSubmitting = function() {
    formSubmitting = true; 
};
var map,
    geocoder,
    infowindow,
    infowindowContent,
    marker;

function bacaGambar(input) {
   if (input.files && input.files[0]) {
      var reader = new FileReader();
 
      reader.onload = function (e) {
          //$('#gambar_nodin').attr('src', e.target.result);
          //console.log(e.target.result);
      }
      //reader.readAsDataURL(input.files[0]);
      //console.log(input.files[0]);
   }
}

window.onload = function() {
    window.addEventListener("beforeunload", function (e) {
        if (formSubmitting) {
            return undefined;
            
        }else{
            var confirmationMessage = 'It looks like you have been editing something. '+ 'If you leave before saving, your changes will be lost.';

            (e || window.event).returnValue = confirmationMessage; //Gecko + IE
            return confirmationMessage; //Gecko + Webkit, Safari, Chrome etc.
        }
    });
};

$(document).ready(function(){
    initAutocomplete();
    $('#form-add-post').submit(function(e){
        if($('#post-slug').val() == ''){
            e.preventDefault();
            alert('Slug belum tersedia, silhkan klik generate slug');
        }
    });
    
    $('#post-title').keyup(function(){
        $('#post-slug').val('');
        $('#txt-slug').text('Slug : -');
    });
    
    $(window).load(function(){
        $('body').backDetect(function(){
            _onBack();
        });
    });
    $("#preview_gambar").change(function(){
       bacaGambar(this);
    });
    $(".dp").datepicker({
        autoclose:true,
        format: "yyyy-mm",
        viewMode: "months", 
        minViewMode: "months"
    });
    $(".dp2").datetimepicker({
        format: "YYYY-MM-DD HH:mm"
    });
    
    $("#event_start").on("dp.change", function (e) {
        //$('#event_end').data("DateTimePicker").minDate(e.date);
    });
    $("#event_end").on("dp.change", function (e) {
        //$('#event_start').data("DateTimePicker").maxDate(e.date);
    });
    $("#pac-input").keydown(function(ev) {
      if (ev.keyCode === 13) { 
        ev.preventDefault(); 
      }
    });
    $('#relasi-post').ajaxChosen({
       dataType: 'json',
       type: 'GET',
       url:'/post/index/{{row_post.post_type}}/list_post_relation',
       data: { lang:$('#fil_lang').val() },
       success: function(data, textStatus, jqXHR){
        //$('#txtlist_mk_chosen').addClass('form-control').css('width','100%');
        //var rs=jQuery.parseJSON(data);
        //console.log(data.results);
        $.each(data.results, function (i, val) {
            //$('#txtlist_mk').html('').append("<option value='"+val.id+"'>"+val.text+"</option>");
		});
       }
    },{
        loadingImg: '{{url("plugin/chosen-ajax-addition/vendor/loading.gif")}}'
    });
    var $mytags=$('#list-post-tags').select2({
        tags: true
    });
    $mytags.on("select2:select", function (e) {
        insertTags($('#list-post-tags').val());
    });
    $mytags.on("select2:unselecting", function (e) {
        //getTags($(this).val());
        //console.log($(this).val());
    });
    $('#btn-togle-maps').click(function(){
        $('#mymap').toggleClass('hidden');
    });
    
    $('input#input-reminder').click(function(){
        if($('input#input-reminder').is(':checked')){
            $('#input-reminder').val('Y');
            $('#box-input-reminder').removeClass('hidden');
            $('#event_start').attr('required','required');
            $('#event_end').attr('required','required');
        }else{
            $('#input-reminder').val('N');
            $('#box-input-reminder').addClass('hidden');
            $('#event_start').removeAttr('required');
            $('#event_end').attr('required');
        }
    });
    
    $('#post-stts').change(function(){
        if($(this).val() == 'draft'){
            $('#post-schedule').removeAttr('readonly');
        }else{
            $('#post-schedule')
            .val('')
            .attr('readonly','readonly');
        }
    });
    /*
    $('#set_media_attachement').click(function(){
        open_media_attach();
    });
    */
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
    tinymce.init({
      selector: 'textarea#wysiwyg',
      theme: 'modern',
      urlconverter_callback : 'myCustomURLConverter',
      paste_data_images: true,
      
      setup: function(editor){
        editor.on('focus', function(e) {
            $('button.btn-checkout-media').removeAttr('disabled');
            //console.log('focus');
        });
        editor.on('focusout', function(e) {
            //$('button.btn-checkout-media').attr('disabled','disabled');
            //console.log('focus out');
        });
      },
      menu: {
        file: {title: 'File', items: 'newdocument'},
        edit: {title: 'Edit', items: 'undo redo | cut copy paste pastetext | selectall'},
        //insert: {title: 'Insert', items: 'link media | template hr'},
        insert: {title: 'Insert', items: 'link template hr pagebreak'},
        view: {title: 'View', items: 'visualchars preview'},
        format: {title: 'Format', items: 'bold italic underline strikethrough superscript subscript | formats | removeformat'},
        table: {title: 'Table', items: 'inserttable tableprops deletetable | cell row column'},
        tools: {title: 'Tools', items: 'spellchecker code'}
      },
      plugins: [
        'autoresize advlist autolink lists link charmap preview hr anchor pagebreak',
        'searchreplace wordcount visualblocks visualchars code',
        'insertdatetime nonbreaking save table contextmenu directionality',
        'paste textcolor colorpicker textpattern myfilemanager myyouTube codesample'
      ],
      toolbar1: 'insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link | myfilemanager | myyouTube',
      toolbar2: 'preview | forecolor backcolor fontselect fontsizeselect | codesample',
      extended_valid_elements: "iframe[src|width|height|name|align], embed[width|height|name|flashvars|src|bgcolor|align|play|loop|quality|allowscriptaccess|type|pluginspage]"
      
    });
    
    var textArea_id="wysiwyg";
    //tinymce.execCommand('mceAddEditor', false, textArea_id);
    
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
    
    $('#Xbox-list-media-'+tab_active).scroll(function() {
        if($('#box-list-media-'+tab_active).scrollTop() == $('#box-list-media-'+tab_active).height() - $($('#box-list-media-'+tab_active)).height()) {
            // ajax call get data from server and append to the div
            //$('#box-list-media-'+tab_active).append('<h1>wkwk</h1>');
        }
        //console.log($('#box-list-media-'+tab_active).scrollTop());
        //console.log($(document).height());
        //console.log($('#box-list-media-'+tab_active).height());
        //console.log($('#box-list-media-'+tab_active).height() - $(document).height());
        //console.log("______________");
        
    });
 });

function _onBack(){
    /*
    $.post('/post/delete/{{row_post.post_type}}',{postid:'{{data.post_id}}',posttype:'autosave'},function(r){
        var rs=jQuery.parseJSON(r);
        if(!rs.success)
        {
            alert(rs.error.message);
        }
    });
    */
}
function on_search_folder(){
    var x = event.which || event.keyCode;
    if(x == 13){
        //console.log();
        album.jstree(true).show_all();
        album.jstree('search', $('#txt-search-folder').val());
    }
}

function myCustomURLConverter(url, node, on_save, name) {
  // Do some custom URL conversion
  url = url.substring(0);

  // Return new URL
  return url;
}

function insertTags(dt){
    $.post('/post/index/{{row_post.post_type}}/insert_post_tags',{dt_tags:dt,post_type:$('#list_category').val()},function(r){
        var rs=jQuery.parseJSON(r);
        if(!rs.success){
            alert(rs.error.message);
        }
    });
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

function open_selected_tab(){
    if(tab_active == 'attach'){
        open_media_attach();
    }else if(tab_active == 'insert'){
        open_insert_media();
    }else{
        open_cover_media();
    }
}

function open_media_attach(){
    check_media_attach=true;
    get_list_media(); 
}

function reset_media_attach(){
    media_attach=[];
    $('.img-list-media').removeClass('img-list-media-selected');
    //$('.checkbox-media-selected').prop('checked', false);
    $('.checkbox-media-selected').addClass('hidden');
    check_media_attach=false;
}

function set_media_attachXXX(){
    if ($('#set_media_attachement').prop('checked')) {
        set=true;
        $('#li-tab-attach').removeClass('hidden');
        $('.checkbox-media-selected').removeClass('hidden');
    }
    else
    {
        set=false;
        media_attach=[];
        $('#li-tab-attach').addClass('hidden');
        $('.img-list-media').removeClass('img-list-media-selected');
        $('.checkbox-media-selected').prop('checked', false);
        $('.checkbox-media-selected').addClass('hidden');
    }
    check_media_attach=set;
}

function open_media(){
    $('#li-tab-'+tab_active).addClass('active');
    $('#tab-'+tab_active).addClass('active');
    is_open_mdl_media=true;
    $('#mdl-media').modal('show');
    open_selected_tab();
    //open_insert_media();
}

function open_insert_media(){
    reset_media_attach();
    get_list_media();
}

function open_cover_media(){
    reset_media_attach();
    get_list_media();
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

function _on_scroll_box_media(){
    var scT=$('#box-list-media-'+tab_active).scrollTop();
    var inH=$('#box-list-media-'+tab_active).innerHeight();
    var scH=$('#box-list-media-'+tab_active)[0].scrollHeight;
    var tot=scT + inH;
    
    if(tot >= scH){
        //console.log('request...');
        var albm_id = album_id.val();
        var m_type=$('#list-mime-'+tab_active).val();
        var txt_search=$('#fil-search-'+tab_active).val();
        var m_date=$('#fil-date-'+tab_active).val();
        var last_id=$('.img-list-media').last().data('idmedia');
        //$('#list-dt-media-'+tab_active).html(myloading);
        $.get('/media/index/get_list_media',{album:albm_id,type:m_type,keyword:txt_search,m_date:m_date,offset:last_id},function(r){
            var rs=jQuery.parseJSON(r);
            if(rs.success){
                $('#list-dt-media-'+tab_active).append(rs.data);
                media_is_selected();
                if(check_media_attach){
                    $('.checkbox-media-selected').removeClass('hidden');
                }
            }else{
                alert(rs.error.message);
            }
        });
        //$('#list-dt-media-'+tab_active).append(myloading);
        //$('#list-dt-media-'+tab_active).append('<div class="col-md-3"><div style="position: relative;"><img id="media-selected-21" title="foto nganu" src="/multimedia/image/20171219/225x120/225x120_20171219101119dscf8591.jpg" class="img-thumbnail img-list-media" data-idmedia="21"><input class="checkbox-media-selected hidden" type="checkbox" style="position: absolute;top: -7px;right: -5px;" id="checkbox-media-selected-21" value="21"></div></div><div class="col-md-3"><div style="position: relative;"><img id="media-selected-21" title="foto nganu" src="/multimedia/image/20171219/225x120/225x120_20171219101119dscf8591.jpg" class="img-thumbnail img-list-media" data-idmedia="21"><input class="checkbox-media-selected hidden" type="checkbox" style="position: absolute;top: -7px;right: -5px;" id="checkbox-media-selected-21" value="21"></div></div><div class="col-md-3"><div style="position: relative;"><img id="media-selected-21" title="foto nganu" src="/multimedia/image/20171219/225x120/225x120_20171219101119dscf8591.jpg" class="img-thumbnail img-list-media" data-idmedia="21"><input class="checkbox-media-selected hidden" type="checkbox" style="position: absolute;top: -7px;right: -5px;" id="checkbox-media-selected-21" value="21"></div></div><div class="col-md-3"><div style="position: relative;"><img id="media-selected-21" title="foto nganu" src="/multimedia/image/20171219/225x120/225x120_20171219101119dscf8591.jpg" class="img-thumbnail img-list-media" data-idmedia="21"><input class="checkbox-media-selected hidden" type="checkbox" style="position: absolute;top: -7px;right: -5px;" id="checkbox-media-selected-21" value="21"></div></div>')
    }
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

function media_selected(dt_media_id){
    $('#box-btn-set-cover').html('');
    if(check_media_attach){
        if(media_attach.indexOf(dt_media_id) >= 0){
            var index=media_attach.indexOf(dt_media_id);
            media_attach.splice(index,1);
            $('#media-selected-'+dt_media_id).removeClass('img-list-media-selected');
            $('#checkbox-media-selected-'+dt_media_id).prop('checked', false);
            //$('.img-list-dt-'+id).removeAttr('style');
            //$('.img-list-dt-'+id).removeClass('img-box');
            //$('.img-list-dt-'+id).attr('style','margin-bottom: 10px; min-height: 100px; min-width: 100%;max-height: 100px;');
            //$('.img-list-dt-'+id).removeClass('box-shadow');
        }else{
            $('#media-selected-'+dt_media_id).addClass('img-list-media-selected');
            $('#checkbox-media-selected-'+dt_media_id).prop('checked', true);
            //$('.img-list-dt-'+id).addClass('box-shadow');
            //$('.img-list-dt-'+id).css('border-color','red');
            //$('.img-list-dt-'+id).css('box-shadow','inset 1px 1px 0px 12px rgba(30,140,190,1)');
            //$('.img-list-dt-'+id).addClass('img-box');
            //$('.img-list-dt-'+id).css('box-shadow','inset 0 0 0 3px #fff,inset 0 0 0 7px #1e8cbe');
            media_attach.push(dt_media_id);
            //get_selected_imgcover(id);
        }
        /*
        //$('#btn-media-move').attr('disabled','disabled');
        if(media_attach.length > 0){
            //console.log(media_attach);
            //$('#btn-media-move').removeAttr('disabled');
            //getSelectedMedia(arr_img);
            //$('#btn-insert-img').removeAttr('disabled');
            //$('#btn-insert-attachment').removeAttr('disabled');
        }else{
            //$('#box-media-selected').addClass('hidden');
            //$('#btn-insert-img').attr('disabled','disabled');
            //$('#btn-insert-attachment').attr('disabled','disabled');
        }
        */
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

function media_is_selected(){
    if(media_attach.length > 0){
        for(i=0;i<media_attach.length; i++){
            $('#media-selected-'+media_attach[i]).addClass('img-list-media-selected');
            $('#checkbox-media-selected-'+media_attach[i]).prop('checked', true);
        }
    }
}

function create_post_slug(){
    var post_title=$('#post-title');
    if(post_title.val() !=''){
        $('#btn-submit').removeAttr('disabled');
        $.get('/post/index/{{row_post.post_type}}/get_post_slug',{post_title:post_title.val(),postid:''},function(r){
            var rs=jQuery.parseJSON(r);
            if(rs.success){
                $('#txt-slug').html('Slug : <i>'+rs.data+'</i>');
                $('#post-slug').val(rs.data);
                formSubmitting=false;
            }else{
                alert(rs.message);
            }
        });
    }else{
        $('#btn-submit').attr('disabled','disabled');
        $('#txt-slug').html('Slug : -');
        $('#post-slug').val('');
    }
}

function _selected_cover(){
    if(media_last_selected.media_type = 'image'){
        media_cover_selected=media_last_selected;
        $('#media-post-cover').val(media_cover_selected.media_id);
        $('#box-post-cover').html('<img title="'+media_cover_selected.media_caption+'" class="img-thumbnail" src="'+media_cover_selected.media_path+'" style="width: 100%;height: 200px;"/> <a href="javascript:void(0)" onclick="delete_selected_cover()">Remove cover</a>');
        $('#btn-set-cover').text('Update post cover');
    }
}
function delete_selected_cover(){
    media_cover_selected=null;
    $('#box-post-cover').html('');
    $('#btn-set-cover').text('Set post cover');
}
function checked_insert(){
    if(media_last_selected != null){
        $.get('/post/index/{{row_post.post_type}}/insert_to_editor',{dt_media:media_last_selected},function(r){
            var rs=jQuery.parseJSON(r);
            if(rs.success){
                formSubmitting=false;
                tinymce.activeEditor.execCommand('mceInsertContent', false, rs.data);
                $('#mdl-media').modal('hide');
            }else{
                alert(rs.error.message);
            }
        });
    }
}
function checked_attach(){
    if(media_attach.length > 0){
        $('#box-media-attach').removeClass('hidden');
        $.get('/post/index/{{row_post.post_type}}/list_media_attach',{media_attach:media_attach},function(r){
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

function initAutocomplete() {
      map = new google.maps.Map(document.getElementById('mymap'), {
      center: {
        lat: parseInt('{{config.api.google.maps.default.lat}}'),
        lng: parseInt('{{config.api.google.maps.default.lng}}')
      },
      zoom: parseInt('{{config.api.google.maps.default.zoom}}'),
      mapTypeId: '{{config.api.google.maps.default.mapTypeId}}'
    });
    var geocoder = new google.maps.Geocoder();
    var infowindow = new google.maps.InfoWindow();
    var infowindowContent = document.getElementById('infowindow-content');
        infowindow.setContent(infowindowContent);
    var marker = new google.maps.Marker({
          map: map,
          anchorPoint: new google.maps.Point(0, -29)
        });
    // Create the search box and link it to the UI element.
    var pac_input = document.getElementById('pac-input');
    var searchBox = new google.maps.places.SearchBox(pac_input);
    //map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

    // Bias the SearchBox results towards current map's viewport.
    map.addListener('bounds_changed', function() {
      searchBox.setBounds(map.getBounds());
    });

    var markers = [];
    // Listen for the event fired when the user selects a prediction and retrieve
    // more details for that place.
    searchBox.addListener('places_changed', function() {
      var places = searchBox.getPlaces();

      if (places.length == 0) {
        return;
      }

      // Clear out the old markers.
      markers.forEach(function(marker) {
        marker.setMap(null);
      });
      markers = [];

      // For each place, get the icon, name and location.
      var bounds = new google.maps.LatLngBounds();
      places.forEach(function(place) {
        if (!place.geometry) {
          alert("Returned place contains no geometry");
          return;
        }
        var icon = {
          url: place.icon,
          size: new google.maps.Size(71, 71),
          origin: new google.maps.Point(0, 0),
          anchor: new google.maps.Point(17, 34),
          scaledSize: new google.maps.Size(25, 25)
        };

        // Create a marker for each place.
        markers.push(new google.maps.Marker({
          map: map,
          icon: icon,
          title: place.name,
          position: place.geometry.location
        }));

        if (place.geometry.viewport) {
          // Only geocodes have viewport.
          bounds.union(place.geometry.viewport);
          map.fitBounds(place.geometry.viewport);
        } else {
          bounds.extend(place.geometry.location);
          map.setCenter(place.geometry.location);
          map.setZoom(17);  // Why 17? Because it looks good.
        }
        marker.setPosition(place.geometry.location);
        marker.setVisible(true);
        
        var address = '';
          if (place.address_components) {
            address = [
              (place.address_components[0] && place.address_components[0].short_name || ''),
              (place.address_components[1] && place.address_components[1].short_name || ''),
              (place.address_components[2] && place.address_components[2].short_name || '')
            ].join(' ');
          }
          $('#place-icon').removeClass('hidden');
          infowindowContent.children['place-icon'].src = place.icon;
          infowindowContent.children['place-name'].textContent = place.name;
          infowindowContent.children['place-address'].textContent = place['formatted_address'];
          infowindow.open(map, marker);
          
        //console.log(place);
        $('#location-name').val(place['name']);
        $('#location-addres').val(place['formatted_address']);
        $('#location-lat').val(place.geometry.location.lat());
        $('#location-long').val(place.geometry.location.lng());
        //console.log(place['formatted_address']);
      });
      /*
      google.maps.event.addListener(map, 'click', function( event ){
          console.log(event);
          console.log("Latitude: "+event.latLng.lat()+" "+", longitude: "+event.latLng.lng());
          geocoder.geocode({
            'latLng': event.latLng
          }, function(results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
              if (results[0]) {
                //alert(results[0].formatted_address);
                console.log(results[0].formatted_address);
              }
            }
          });
      });
      */
      map.fitBounds(bounds);
    });
}
function open_media_youTube(){
    $('#mdl-youtube').modal('show');
}

function serach_youtube(event){
    //console.log(event);
    if($('#query-youtube').val() != '' && event.keyCode == 13 || event.type == 'click'){
        $('#load-list-youtube').html('<div class="text-center">Loading...<i class="fa fa-spinner fa-spin"></i></div>');
        $.get('https://www.googleapis.com/youtube/v3/search?part=snippet&q='+$('#query-youtube').val()+'&maxResults=5&order=viewCount&key=AIzaSyA0ml9hz_AtfDb5dNhzgC3wOZlkIbvAhJ0',function(){
            
        })
        .done(function(r){
            
            //load-list-youtube
            var list_yt=r.items;
            var rs,
                videoId,
                channelId,
                channelTitle,
                yttitle,
                ytdescription,
                thumbnails,
                publishedAt;
                
            //console.log(list_yt);
            if(list_yt.length > 0){
                $('#load-list-youtube').html('');
                for(i=0; i<list_yt.length; i++){
                    rs=list_yt[i];
                    videoId=rs['id']['videoId'];
                    channelId=rs.snippet.channelId;
                    channelTitle=rs.snippet.channelTitle;
                    yttitle=rs.snippet.title;
                    ytdescription=rs.snippet.description;
                    thumbnails=rs.snippet.thumbnails.default
                    
                    $('#load-list-youtube').append('<div class="media"><div class="media-left"><a href="javascript:void(0)" onclick="get_dlt_video('+"'"+videoId+"'"+','+"'"+yttitle+"'"+','+"'"+channelTitle+"'"+')"><img src="'+thumbnails.url+'" alt="64x64" class="media-object" style="width: 64px; height: 64px;"> </a> </div> <div class="media-body"><a href="javascript:void(0)" onclick="get_dlt_video('+"'"+videoId+"'"+','+"'"+yttitle+"'"+','+"'"+channelTitle+"'"+')"><h4 class="media-heading">'+yttitle+'</h4></a><span class="label label-default">'+channelTitle+'</span></br>'+ytdescription+'</div></div><hr style="margin: 3px;"/>');
                }
            }else{
                $('#load-list-youtube').html('<div class="text-center">Video tidak tersedia</div>');
            }
        });
    }
}

function get_dlt_video(vdeoid,yttitle,channelTitle){
    if(vdeoid !=''){
        $('#dtl-video-ytube').html('<div class="panel panel-default"><div class="panel-heading">Youtube video Detail</div><div class="panel-body" style="min-height: 200px;"><div><div class="embed-responsive embed-responsive-4by3"><iframe id="ytplayer" allowFullScreen="allowFullScreen" type="text/html" src="https://www.youtube.com/embed/'+vdeoid+'?enablejsapi=1&origin=https://www.google.com" frameborder="0"></iframe></div><address><strong>'+yttitle+'</strong><br><span class="label label-default">'+channelTitle+'</span></address></div><div class="row"><div class="col-md-6"><button style="width:100%" type="button" class="btn btn-sm btn-default" onclick="_on_close_mdl_ytube()">Close</button></div><div class="col-md-6"><button style="width:100%" onclick="_on_insert_video_ytube('+"'"+vdeoid+"'"+')" type="button" class="btn btn-sm btn-default">Insert to content</button></div></div></div></div>');
    }
}
function _on_insert_video_ytube(vdeoid){
    var dt='';
        dt+='<iframe style="width:100%" class="embed-responsive-item" id="ytplayer" type="text/html" src="https://www.youtube.com/embed/'+vdeoid+'?origin=https://www.google.com" frameborder="0"></iframe>';
    tinymce.activeEditor.execCommand('mceInsertContent', false, dt);
    _on_close_mdl_ytube();
}
function _on_close_mdl_ytube(){
    $('#dtl-video-ytube').html('');
    $('#mdl-youtube').modal('hide');
}
</script>
{% endblock %}