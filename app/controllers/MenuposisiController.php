<?php
use Phalcon\Forms\Form;
use Phalcon\Forms\Element\Select;

class MenuposisiController extends ControllerBase
{
    /**
     * laman index menu posisi
     */
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
        $this->myassets->nestable();
        $this->view->setVar("menuItem",$this->get_list_nestable());
    }
    
    private function get_list_nestable()
    {
        $menuItem=MMenu::find([
            "show_menu = 'Y' AND resources_name !='post'",
            'order'=>'menu_order ASC'
        ]);
        $menu = new MenuGenerate($menuItem);
        return $menu->nesTable();
        
    }
    private function load_list_menu()
    {
        $this->rs->success=true;
        $this->rs->data=$this->get_list_nestable();
        $this->rs->send();
    }
    public function editAction($param=false)
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
    }
    
    /**
     * parsing json dari nestable
     */
    private function parseJsonArray($jsonArray, $parentID = 0) {
      $return = array();
      foreach ($jsonArray as $subArray) {
        $returnSubSubArray = array();
        if (isset($subArray->children)) {
     		$returnSubSubArray = $this->parseJsonArray($subArray->children, $subArray->id);
        }
        $return[] = array('id' => $subArray->id, 'parentID' => $parentID);
        $return = array_merge($return, $returnSubSubArray);
      }
      return $return;
    }
    
    /**
     * proses set menu posisi
     */
    private function setPosition()
    {
        $req=$this->request->getPost('data');
        $toArr=json_decode($req);
        $data = $this->parseJsonArray($toArr);
        try{
            $rs=[];
            $i=0;
            foreach($data as $v)
            {
                
                $upd=MMenu::findFirst([
                    "menu_id=:menu:",
                    "bind"=>[
                        "menu"=>$v['id']
                    ]
                ]);
                $upd->menu_parent_id=$v['parentID'];
                $upd->menu_order=$i;
                $upd->save();
                $i++;
            }
            
            $this->rs->success=true;
            //$this->rs->data=$rs;
        }catch(Exception $e)
        {
            $this->rs->message=$e->getMessage();
        }
        $this->rs->send();
    }
}