<?php
use Phalcon\Mvc\User\Component;
require_once(APP_PATH.'/library/getid3/getid3/getid3.php');
class MyMedia extends Component
{
    private $isfile=false;
    private $pathfile;
    private $mediaDir='multimedia/';
    private $maxSizeImage='1MB';
    private $maxSizeVideo='100MB';
    private $maxSizeDoc='10MB';
    private $archive='10MB';
    public $errors=false;
    public $fileinfo=null;
    public $dir_date='';
    public $save_file=true;
    public $del_file=true;
    
    /**
     * register mime file upload
     */
    private function allow_mimes_upload()
    {
        $data=array(
            'jpg'=>'image/jpg',
            'jpeg'=>'image/jpeg',
            'JPG'=>'image/JPG',
            'png'=>'image/png',
            'pdf'=>'application/pdf',
            'mp4'=>'video/mp4',
            'zip'=>'application/zip'
        );
        return $data;
    }
    
    public function list_mime($key=null)
    {
        $data['image']=array(
            'ext'=>array('jpeg','jpg','png','JPG'),
            'maxsize'=>$this->maxSizeImage
        );
        $data['video']=array(
            'ext'=>array('mp4'),
            'maxsize'=>$this->maxSizeVideo
        );
        $data['doc']=array(
            'ext'=>array('pdf','doc','docx'),
            'maxsize'=>$this->maxSizeDoc
        );
        $data['archive']=array(
            'ext'=>array('zip'),
            'maxsize'=>$this->archive
        );
        $rs=$data;
        if($key != null)
        {
            $rs=$data[$key];
        }
        return $rs;
    }
    
    private function formatSizeUnits($bytes)
    {
        if ($bytes >= 1073741824)
        {
            $bytes = number_format($bytes / 1073741824, 2) . ' GB';
        }
        elseif ($bytes >= 1048576)
        {
            $bytes = number_format($bytes / 1048576, 2) . ' MB';
        }
        elseif ($bytes >= 1024)
        {
            $bytes = number_format($bytes / 1024, 2) . ' KB';
        }
        elseif ($bytes > 1)
        {
            $bytes = $bytes . ' bytes';
        }
        elseif ($bytes == 1)
        {
            $bytes = $bytes . ' byte';
        }
        else
        {
            $bytes = '0 bytes';
        }

        return $bytes;
    }
    
    private function convertToBytes($from){
        $number=substr($from,0,-2);
        switch(strtoupper(substr($from,-2))){
            case "KB":
                return $number*1024;
            case "MB":
                return $number*pow(1024,2);
            case "GB":
                return $number*pow(1024,3);
            case "TB":
                return $number*pow(1024,4);
            case "PB":
                return $number*pow(1024,5);
            default:
                return $from;
        }
    }
    
    private function media_type($type)
    {
        $doc=$this->list_mime('doc')['ext'];
        $img=$this->list_mime('image')['ext'];
        $video=$this->list_mime('video')['ext'];
        $archive=$this->list_mime('archive')['ext'];
        if(in_array($type,$doc))
        {
            $rs='doc';
        }
        elseif(in_array($type,$img))
        {
            $rs='image';
        }
        elseif(in_array($type,$video))
        {
            $rs='video';
        }
        elseif(in_array($type,$archive))
        {
            $rs='archive';
        }
        else
        {
            $rs='unknown';
        }
        return $rs;
    }
    
    private function generateFilename($file){
        $filname=preg_replace('/[^a-zA-Z0-9_.-]/', '_', $file);
        return date('YmdHis').strtolower($filname);
    }
    
    private function list_thumb_size(){
        $dt=array(
            'xs'=>'100x100',
            'sm'=>'225x120',
            'md'=>'440x220',
            'lg'=>'1024x768',
            'xlg'=>'1280x720'
        );
        return $dt;
    }
    
    public function setup($filetype)
    {
        if($this->dir_date == '')
        {
            $this->dir_date=date('Ymd');
        }
        $files = $this->request->getUploadedFiles();
        $this->isfile=$files[0];
        $type=$this->media_type($this->isfile->getExtension());
        if($type !='unknown')
        {
            $maxSize=$this->list_mime($type)['maxsize'];
            $this->prepareSingleFile($filetype,$maxSize);
        }
        else
        {
            $this->errors='file tidak dikenal';
        }
    }
    
    private function prepareSingleFile($filetype,$allowmaxsize='300KB')
    {
        $allowType=[];
        $maxSize=$this->convertToBytes($allowmaxsize);
        if(is_array($filetype))
        {
            $str=join(",",$filetype);
            foreach($filetype as $t)
            {
                $allowType[]=$this->allow_mimes_upload()[$t];
            }
        }
        else
        {
            $str=$filetype;
            $allowType=array($this->allow_mimes_upload()[$filetype]);
        }
        
        if(!in_array($this->isfile->getType(),$allowType))
        {
            $this->errors='file tipe tidak valid ('.$str.')';
        }
        elseif($this->isfile->getSize() > $maxSize)
        {
            $this->errors='file upload '.$this->formatSizeUnits($this->isfile->getSize()).', maksimal file upload '.$this->formatSizeUnits($maxSize);
        }       
    }
    
    public function saveFile()
    {
        $file=$this->isfile;
        $ext = $file->getExtension();
        
        if(!is_dir($this->mediaDir))
        {
            mkdir($this->mediaDir,0755,true);
        }
        $dir_type=$this->mediaDir.$this->media_type($ext).'/';
        if(!is_dir($dir_type))
        {
            mkdir($dir_type,0755,true);
        }
        $dir_date=$dir_type.$this->dir_date.'/';
        if(!is_dir($dir_date))
        {
            mkdir($dir_date,0755,true);
        }
        
        $filename= $this->generateFilename($file->getName());
        $data=array(
            'realname'=>$file->getName(),
            'realsize'=>$file->getSize(),
            'type'=>$file->getType(),
            'm_type'=>$this->media_type($ext),
            'extension'=>$file->getExtension(),
            'temp'=>$file->getTempName(),
            'filename'=>$filename,
            'filesize'=>$this->formatSizeUnits($file->getSize()),
            'path'=>$dir_date,
            'fullpath'=>'/'.$dir_date.$filename,
            'dirpath'=>$dir_date.$filename,
            'video_duration'=>null
        );
        $this->fileinfo=$data;
        if($this->save_file)
        {
            $file->moveTo($dir_date.$filename);
        }
        $this->saveThumb();
        $this->get_video_dtl();
    }
    
    private function saveThumb()
    {
        $file=(object)$this->fileinfo;
        if($file->m_type =='image')
        {
            $list_thumb=$this->list_thumb_size();
            $path=$file->path.$file->filename;
            foreach($list_thumb as $k=>$v)
            {
                $size=explode('x',$v);
                $dir_size=$file->path.$v.'/';
                if(!is_dir($dir_size))
                {
                    mkdir($dir_size,0755,true);
                }
                $filename=$v.'_'.$file->filename;
                $image = new \Phalcon\Image\Adapter\GD($path);
                $image->resize($size[0],$size[1]);
                $image->save($dir_size.$filename);
            }
            $this->fileinfo['fullpath']=$this->get_img_uri($file->filename,'sm');
            if($this->del_file)
            {
                unlink($path);
            }
        }
    }
    
    private function get_video_dtl()
    {
        $file=(object)$this->fileinfo;
        if($file->m_type =='video')
        {
            $getID3 = new getID3;
            $path=$file->path.$file->filename;
            $files = $getID3->analyze($path);
            $this->fileinfo['video_duration']=$files['playtime_string'];
        }
    }
    
    public function get_img_uri($filename,$size='md')
    {
        $dir_date=substr($filename,0,8);
        $dir_size=$this->list_thumb_size()[$size];
        $uri='/'.$this->mediaDir.'image/'.$dir_date.'/'.$dir_size.'/'.$dir_size.'_'.$filename;
        return $uri;
    }
    
    public function get_media_uri($filename,$type,$path,$size='md')
    {
        $media['image']='<img src="'.$this->get_img_uri($filename,$size).'" class="img-thumbnail" style="100%"/>';
        $media['video']='<video class="img-thumbnail" style="100%" controls="controls"><source src="'.$path.'" type="video/mp4">Your browser does not support the video tag.</video>';
        $media['doc']='<a href="'.$path.'" target="_blank"><i class="fa fa-download"></i> '.$filename.'</a>';
        return $media[$type];
    }
}