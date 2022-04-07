<?php
use \DataTables\DataTable;
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Select;

class MediaController extends ControllerBase 
{
    public function indexAction($param=false)
    {
        if($this->request->isAjax())
        {
            $this->view->disable();
            if(method_exists(__CLASS__,$param))
            {
                $this->{$param}();
            }
            else
            {
                throw new Exception("method tidak tersedia");
            }
        }
        $this->myassets->assetDataTable();
        $data['list_author']=$this->get_list_author()->render('list_author',['class'=>'form-control input-sm','id'=>'list_author','onchange'=>'filteringDt()']);
        $this->view->setVar("data",(object)$data);
    }
    
    /**
     * get list list post author (dropdown)
     */
    private function get_list_author(){
        $form=new Form();
        $dt=[];
        $empty=false;
        if($this->auth->show_all_author == 'Y')
        {
            $empty=true;
            $dt=MUsers::find([
                'columns'=>'username,full_name',
                'status=1',
                'order'=>'full_name ASC'
            ]);
        }
        else
        {
            if(count($this->auth->mapping_author) > 0)
            {
                $dt = $this->modelsManager->createBuilder()
                      ->columns('username,full_name')
                      ->from('MUsers')
                      ->inWhere('username',$this->auth->mapping_author)
                      ->orderBy('full_name ASC')
                      ->getQuery()
                      ->execute();
            }
        }
        
        $select = new Select("list_author",$dt,["useEmpty"  =>  $empty,"emptyText" =>  "All Author",'using'=>['username','full_name']]);
        $select->setDefault($this->auth->username);
        return $form->add($select);
    }
    
    /**
     * get all roles on dataTable
     */
    private function all_data()
    {
        $type=$this->request->get('type');
        $author=$this->request->get('author');
        $whr_auth='';        
        $builder = $this->modelsManager->createBuilder()
                      ->columns('media_id,media_type,media_name,media_author,media_date,media_path,file_size,media_caption,album_id,media_guide')
                      ->from('CMedia');
        if($author !='' AND $type !='')
        {
            $builder->where("media_author ='$author' AND media_type ='$type'");
        }
        else
        {
            if($author !='')
            {
                $builder->where("media_author ='$author'");
            }
            if($type !='')
            {
                $builder->where("media_type ='$type'");
            }
        }
        $dataTables = new DataTable();
        $dataTables->fromBuilder($builder)->sendResponse();
    }
    
    public function addAction()
    {
        if($this->request->isAjax())
        {
            $this->view->disable();
            if($this->request->hasFiles(true))
            {
                $this->mymedia->setup(array('jpeg','jpg','png','pdf','mp4'));
                if($this->mymedia->errors != false)
                {
                    $this->rs->message=$this->mymedia->errors;
                }
                else
                {
                    $this->mymedia->saveFile();
                    $info=(object)$this->mymedia->fileinfo;
                    $media=new CMedia();
                    $media->media_author=$this->auth->username;
                    $media->media_path=$info->fullpath;
                    $media->media_name=$info->realname;
                    $media->media_type=$info->m_type;
                    $media->file_size=$info->filesize;
                    $media->media_date=date('Y-m-d H:i:s');
                    $media->media_caption=$this->request->getPost('caption');
                    $media->media_guide=$info->filename;
                    $media->album_id=$this->request->getPost('album_id');
                    $media->video_duration=$info->video_duration;
                    $media->file_extension=$info->extension;
                    $media->save();
                    $this->rs->success=true;
                    $this->rs->data=$media;
                    //$this->flashSession->success("media berhasil ditambahkan !!! ");
                    //$this->response->redirect('/media');
                }
            }
            $this->rs->send();
        }
        $this->myassets->jstree();
        $this->assets->collection("jsHeader")->addJs("plugin/jquery.form.min.js");
    }
    
    public function editAction($pk=false)
    {
        $media=CMedia::findFirstBymedia_id($pk);
        if($pk == false AND $media == false)
        {
            $this->nocontent();
        }
        if($this->request->isAjax())
        {
            $this->view->disable();
            if($this->request->hasFiles(true))
            {
                $this->mymedia->setup(array('jpeg','jpg','png','pdf','mp4'));
                if($this->mymedia->errors != false)
                {
                    $this->rs->message=$this->mymedia->errors;
                }
                else
                {
                    $this->mymedia->saveFile();
                    $info=(object)$this->mymedia->fileinfo;
                    $media->media_name=$this->request->getPost('media_name');
                    $media->media_caption=$this->request->getPost('caption');
                    $media->media_path=$info->fullpath;
                    $media->media_type=$info->m_type;
                    $media->file_size=$info->filesize;
                    $media->media_guide=$info->filename;
                    $media->album_id=$this->request->getPost('album_id');
                    $media->video_duration=$info->video_duration;
                    $media->file_extension=$info->extension;
                    $media->save();
                    $this->rs->success=true;
                    $this->rs->data=$info;
                    //$this->flashSession->notice("edit media berhasil ok !!! ");
                    //$this->response->redirect('/media');
                }
            }
            else
            {
                $media->media_name=$this->request->getPost('media_name');
                $media->media_caption=$this->request->getPost('caption');
                $media->album_id=$this->request->getPost('album_id');
                $media->save();
                $this->rs->success=true;
                //$this->flashSession->notice("edit media berhasil ok !!! ");
                //$this->response->redirect('/media');
            }
            $this->rs->send();
        }
        $this->assets->collection("jsHeader")->addJs("plugin/jquery.form.min.js");
        $this->myassets->jstree();
        $data['row']=$media;
        $data['media_uri']=$this->mymedia->get_media_uri($media->media_guide,$media->media_type,$media->media_path);
        $this->view->setVar('data',(object)$data);
    }
    
    public function deleteAction()
    {
        if($this->request->isAjax())
        {
            $pk=$this->request->getPost('pk');
            $data=CMedia::findFirstBymedia_id($pk);
            $data->delete();
            $this->rs->success=true;
            $this->rs->send();
        }
    }
    
    private function rstree()
    {
        $this->view->disable();
        if(isset($_GET['operation'])) {
          try {
            $result = null;
            switch($_GET['operation']) {
              case 'get_node':
                $node = isset($_GET['id']) && $_GET['id'] !== '#' ? (int)$_GET['id'] : 0;
                $data_album = MAlbum::find([
                    "columns"=>"album_id as id,album_parent_id as parent_id,album_name as text"
                ]);
                if(count($data_album)> 0)
                {
                    foreach($data_album->toArray() as $row)
                    {
                        $data[]=$row;
                    }
                    // Build array of item references:
                    foreach($data as $key => &$item) {
                       $itemsByReference[$item['id']] = &$item;
                       // Children array:
                       $itemsByReference[$item['id']]['children'] = array();
                       // Empty data class (so that json_encode adds "data: {}" ) 
                       $itemsByReference[$item['id']]['data'] = new StdClass();
                    }
            
                    // Set items as children of the relevant parent item.
                    foreach($data as $key => &$item)
                       if($item['parent_id'] && isset($itemsByReference[$item['parent_id']]))
                        $itemsByReference [$item['parent_id']]['children'][] = &$item;
            
                    // Remove items that were added to parents elsewhere:
                    foreach($data as $key => &$item) {
                       if($item['parent_id'] && isset($itemsByReference[$item['parent_id']]))
                        unset($data[$key]);
                    }
                }
                $result = $data;
                break;
              case 'create_node':
                $node = isset($_GET['id']) && $_GET['id'] !== '#' ? (int)$_GET['id'] : 0;
                
                $nodeText = isset($_GET['text']) && $_GET['text'] !== '' ? $_GET['text'] : '';
                $new=new MAlbum();
                $new->album_name=$nodeText;
                $new->album_parent_id=$node;
                $new->save();
                $result = array('id' => $new->album_id);
        
                break;
              case 'rename_node':
                $node = isset($_GET['id']) && $_GET['id'] !== '#' ? (int)$_GET['id'] : 0;
                $nodeText = isset($_GET['text']) && $_GET['text'] !== '' ? $_GET['text'] : '';
                $upd=MAlbum::findFirstByalbum_id($node);
                $upd->album_name=$nodeText;
                $upd->update();
                break;
              case 'delete_node':
                $node = isset($_GET['id']) && $_GET['id'] !== '#' ? (int)$_GET['id'] : 0;
                if($node != 1)
                {
                    $del=MAlbum::findFirstByalbum_id($node);
                    $dt_media=CMedia::find([
                        "album_id=$node"
                    ]);
                    if(count($dt_media) > 0)
                    {
                        foreach($dt_media as $m)
                        {
                            $media=CMedia::findFirstBymedia_id($m->media_id);
                            $media->album_id=1;
                            $media->update();
                        }
                    }
                    $del->delete();
                }
                break;
              case 'move_node':
                $node = isset($_GET['id']) && $_GET['id'] !== '#' ? (int)$_GET['id'] : 0;
                if($node != 1)
                {
                    $cut=MAlbum::findFirstByalbum_id($node);
                    $cut->album_parent_id=$_GET['parent'];
                    $cut->update();
                }
              break;
              case 'copy_node':
                $result=$_GET;
              break;
              default:
                throw new Exception('Unsupported operation: ' . $_GET['operation']);
                break;
            }
            header('Content-Type: application/json; charset=utf-8');
            echo json_encode($result);
          }
          catch (Exception $e) {
            header($_SERVER["SERVER_PROTOCOL"] . ' 500 Server Error');
            header('Status:  500 Server Error');
            echo $e->getMessage();
          }
        }
    }
    
    private function get_list_media_show($media,$type)
    {
        $data['image']=$media->media_path;
        $data['video']='/img/ico-video.png';
        $data['doc']='/img/ico-document.png';
        return $data[$type];
    }
    
    private function get_list_media()
    {
        $album=$this->request->get('album');
        $type=$this->request->get('type');
        $txt_search=$this->request->get('keyword');
        $m_date=$this->request->get('m_date');
        $offset=$this->request->get('offset');
        $keyword='';
        $date='';
        $qof='';
        if($txt_search != '')
        {
            $keyword=' AND media_caption LIKE "%'.$txt_search.'%"';
        }
        if($m_date !='')
        {
            $date=' AND DATE_FORMAT(media_date,"%Y-%m")="'.$m_date.'"';
        }
        if($offset != 0){
            $qof=" AND media_id < $offset";
        }
        $m_type=array($type);
        if($type == '')
        {
            $m_type=array_keys($this->mymedia->list_mime());
        }
        $data = $this->modelsManager->createBuilder()
                      ->from('CMedia')
                      ->where('album_id ="'.$album.'"'.$keyword.$date.$qof)
                      ->inWhere('media_type',$m_type)
                      ->orderBy('media_id DESC')
                      ->limit(12)
                      //->offset($offset)
                      ->getQuery()
                      ->execute();
        $html='';
        
        if(count($data) > 0)
        {
            foreach($data as $media)
            {
                $path=$this->get_list_media_show($media,$media->media_type);
                $html .='<div class="col-md-3"><div style="position: relative;">';
                $html .='<img id="media-selected-'.$media->media_id.'" onclick="media_selected('."'".$media->media_id."'".')" title="'.$media->media_caption.'" src="'.$path.'" class="img-thumbnail img-list-media" data-idmedia="'.$media->media_id.'"/>';
                $html .='<input class="checkbox-media-selected hidden" type="checkbox" style="position: absolute;top: -7px;right: -5px;" id="checkbox-media-selected-'.$media->media_id.'" value="'.$media->media_id.'" onclick="media_selected('."'".$media->media_id."'".')"/>';
                $html .='</div></div>';
            }
        }
        else
        {
            //$html .='<div class="text-center"><p>Media not found</p></div>';
        }
        $this->rs->success=true;
        $this->rs->data=$html;
        $this->rs->send();
    }
    
    private function get_detail_media()
    {
        $pk=$this->request->get('pk');
        $media=$media=CMedia::findFirstBymedia_id($pk);
        $data=[];
        if(count($media) > 0)
        {
            $data=$media->toArray();
            $path=$this->get_list_media_show($media,$media->media_type);
            $data['media_uri']='<img src="'.$path.'" style="width: 100%;height: 200px;"/>';
            $data['media_date']=$this->myhelp->full_date($media->media_date);
        }
        $this->rs->success=true;
        $this->rs->data=$data;
        $this->rs->send();
    }
}