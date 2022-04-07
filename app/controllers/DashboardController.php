<?php
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Select;

class DashboardController extends ControllerBase
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
        $this->myassets->highcharts();
        $author=$this->auth->username;
        $data['list_fil_post_view']=$this->get_list_fil_post_view()->render('list_fil_post_view',['class'=>'form-control','id'=>'list_fil_post_view','onchange'=>'_on_load_post_view(this.value)']);
        $data['total_post']=CPost::count(["post_author='$author' AND post_status !='autosave'"]);
        $data['total_media']=CMedia::count(["media_author='$author'"]);
        $data['total_user']=MUsers::count();
        $data['total_comment']=0;
        $this->view->setVar("data",(object)$data);
    }
    
    private function get_list_fil_post_view(){
        $form=new Form();
        $dt=CPostViews::find([
            "columns"=>"DATE_FORMAT(last_read,'%Y') as thn",
            "group"=>"thn"
        ]);
        $select = new Select("list_fil_post_view",$dt,["useEmpty"  =>  true,"emptyText" =>  "Tahun",'using'=>['thn','thn']]);
        return $form->add($select);
    }
    
    private function grafik_total_post_view()
    {
        $thn=$this->request->get('thn');
        $cat=array(
            '01'=>'Jan',
            '02'=>'Feb',
            '03'=>'Mar',
            '04'=>'Apr',
            '05'=>'May',
            '06'=>'Jun',
            '07'=>'Jul',
            '08'=>'Aug',
            '09'=>'Sep',
            '10'=>'Oct',
            '11'=>'Nov',
            '12'=>'Dec'
        );
        $dt_val=[];
        foreach($cat as $dk=>$dv)
        {
            $dt=CPostViews::findFirst([
                "columns"=>"COUNT(ip_addr) as total",
                "DATE_FORMAT(last_read,'%Y-%m')='$thn-$dk'"
            ]);
            $dt_val[]=(int)$dt->total;
        }
        
        $series=array(
            'data'=>$dt_val,
            'name'=>'Total'
        );
        $data=array(
            'categories'=>array_values($cat),
            'series'=>$series
        );
        $this->rs->data=$data;
        $this->rs->success=true;
        $this->rs->send();
    }
}