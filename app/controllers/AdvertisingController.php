<?php
use \DataTables\DataTable;

class AdvertisingController extends ControllerBase 
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
    }
    
    private function all_data()
    {
        $builder = $this->modelsManager->createBuilder()
                      ->columns('id, advertiser,start_date,end_date,status,url_web,post_location')
                      ->from('MAdvertisement');

        $dataTables = new DataTable();
        $dataTables->fromBuilder($builder)->sendResponse();
    }
    
    public function addAction()
    {
        if($this->request->isPost())
        {
            $this->view->disable();
            $media_attach=$this->request->getPost('list_media_attch');
            $dt=new MAdvertisement();
            $dt->advertiser=$this->request->getPost('advertiser');
            $dt->start_date=$this->request->getPost('start_date');
            $dt->end_date=$this->request->getPost('end_date');
            $dt->status=$this->request->getPost('status');
            $dt->url_web=$this->request->getPost('url_web');
            $dt->post_location=$this->request->getPost('post_location');
            $dt->contract=$this->request->getPost('contract');
            $dt->price=$this->request->getPost('price');
            $dt->save();
            if(count($media_attach) > 0)
            {
                foreach($media_attach as $m)
                {
                    $newm=new MMediaAdvertisement();
                    $newm->media_id=$m;
                    $newm->id_advertisement=$dt->id;
                    $newm->save();
                }
            }
            $this->flashSession->success("advertiser ".$this->request->getPost('advertiser')." berhasil ditambahkan !!! ");
            $this->response->redirect('/advertising');
            
        }
        else
        {
            $this->assets->collection("jsHeader")
                ->addJs("plugin/jquery.form.min.js");
            $this->myassets->jstree();
            $this->myassets->datepicker();
        }
    }
    
    public function editAction($pk=null)
    {
        $row=MAdvertisement::findFirstByid($pk);
        if(!$row)
        {
            $this->nocontent('no content');
        }
        else
        {
            if($this->request->isPost())
            {
                $this->view->disable();
                $post_location=$this->request->getPost('post_location');
                $status=$this->request->getPost('status');
                if($status == 'Y')
                {
                    $this->db->query("UPDATE m_advertisement SET status='N' WHERE post_location='$post_location'");
                }
                $media_attach=$this->request->getPost('list_media_attch');
                $row->advertiser=$this->request->getPost('advertiser');
                $row->start_date=$this->request->getPost('start_date');
                $row->end_date=$this->request->getPost('end_date');
                $row->status=$status;
                $row->url_web=$this->request->getPost('url_web');
                $row->post_location=$post_location;
                $row->contract=$this->request->getPost('contract');
                $row->price=$this->request->getPost('price');
                $row->update();
                $this->db->query("DELETE FROM m_media_advertisement WHERE id_advertisement=$pk");
                if(count($media_attach) > 0)
                {
                    foreach($media_attach as $m)
                    {
                        $newm=new MMediaAdvertisement();
                        $newm->media_id=$m;
                        $newm->id_advertisement=$pk;
                        $newm->save();
                    }
                }
                $this->flashSession->notice("update advertiser ".$this->request->getPost('advertiser')." OK !!! ");
                $this->response->redirect('/advertising');
                
            }
            else
            {
                $this->assets->collection("jsHeader")
                    ->addJs("plugin/jquery.form.min.js");
                $this->myassets->jstree();
                $this->myassets->datepicker();
                $list_media_attach=[];
                $list_media_dr_attach=[];
                $dt_media_attach=$this->modelsManager->createBuilder()
                    ->from("MMediaAdvertisement")
                    ->join("CMedia","CMedia.media_id=MMediaAdvertisement.media_id")
                    ->where("MMediaAdvertisement.id_advertisement=:id_advertisement:",
                        [
                            "id_advertisement"=>$pk
                        ]
                    )
                    ->getQuery()
                    ->execute();
                if(count($dt_media_attach) > 0)
                {
                    $ar_attch_id=[];
                    $ar_media=[];
                    foreach($dt_media_attach as $m)
                    {
                        $ar_attch_id[]=$m->media_id;
                        $list_media_dr_attach[]=array(
                            'media_id'=>$m->media_id,
                            'media_type'=>$m->media_type,
                            'media_author'=>$m->media_author,
                            'media_date'=>$m->media_date,
                            'media_path'=>$m->media_path,
                            'media_caption'=>$m->media_caption
                        );
                    }
                    $list_media_attach=array_values($ar_attch_id);
                }
                
                $data['list_attach']=join(',',$list_media_attach);
                $data['list_dt_attach']=$list_media_dr_attach;
                $data['row']=$row;
                $this->view->setVar('data',(object)$data);
            }
        }
    }
    
    private function list_media_attach()
    {
        $dt_media=$this->request->get('media_attach');
        $rs='';
        if(count($dt_media) > 0)
        {
            foreach($dt_media as $k=>$v)
            {
                $media=CMedia::findFirstBymedia_id($v);
                if($media)
                {
                    $img_uri=$this->mymedia->get_media_uri($media->media_guide,$media->media_type,$media->media_path,'xs');
                    $rs .='
                        <li class="item" id="media-list-item-'.$media->media_id.'">
                          <div class="product-img">
                            '.$img_uri.'
                          </div>
                          <div class="product-info">
                            <div class="product-title">'.$media->media_caption.'
                              <a onclick="del_item_media_attach('."'".$media->media_id."'".')" href="javascript:void(0)" class="label label-danger pull-right"><i class="fa fa-trash"></i></a></div>
                                <span class="product-description text-sm">Author : '.$media->media_author.'</span>
                          </div>
                        </li>
                    ';
                }
            }
        }
        $this->rs->success=true;
        $this->rs->data=$rs;
        $this->rs->send();
    }
}