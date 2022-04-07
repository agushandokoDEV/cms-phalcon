<?php
use \DataTables\DataTable;

class TemplateController extends ControllerBase 
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
    
    /**
     * get all roles on dataTable
     */
    private function all_data()
    {
        $builder = $this->modelsManager->createBuilder()
                      ->columns('name,title,active,screenshot')
                      ->from('MTemplate');
        $dataTables = new DataTable();
        $dataTables->fromBuilder($builder)->sendResponse();
    }
    
    public function addAction()
    {
        if($this->request->isPost())
        {
            $this->view->disable();
            if($this->request->hasFiles(true))
            {
                $path=$this->request->getPost('template_name');
                //$this->mymedia->save_file=false;
                $this->mymedia->setup(array('zip'));
                if($this->mymedia->errors != false)
                {
                    $this->flashSession->error($this->mymedia->errors);
                    $this->response->redirect('/template/add');
                }
                else
                {
                    $data=MTemplate::findFirstByname($path);
                    if($data)
                    {
                        $this->flashSession->error('template '.$path.' sudah tersedia');
                        $this->response->redirect('/template/add');
                    }
                    else
                    {
                        $this->mymedia->saveFile();
                        $info=(object)$this->mymedia->fileinfo;
                        $zip = new ZipArchive;
                        $res = $zip->open($info->dirpath);
                        if ($res === TRUE) {
                            $zip->extractTo('temp_layout');
                            $zip->close();
                            if(is_dir('site/'.$path))
                            {
                                $this->flashSession->error('direktori '.$path.' sudah tersedia');
                                $this->response->redirect('/template/add');
                            }
                            else
                            {
                                mkdir('site/'.$path,0775,true);
                                mkdir($this->config->application->siteViewsDir.$path,0775,true);
                                if(!is_dir('temp_layout/'.$path))
                                {
                                    rmdir('site/'.$path);
                                    rmdir($this->config->application->siteViewsDir.$path);
                                    $this->del_all('temp_layout/'.$path);
                                    $this->flashSession->error('direktori '.$path.' tidak tersedia');
                                    $this->response->redirect('/template/add');
                                }
                                elseif(!is_dir('temp_layout/'.$path.'/views'))
                                {
                                    rmdir('site/'.$path);
                                    rmdir($this->config->application->siteViewsDir.$path);
                                    $this->del_all('temp_layout/'.$path);
                                    $this->flashSession->error('direktori views tidak tersedia');
                                    $this->response->redirect('/template/add');
                                }
                                else
                                {
                                    $this->rcopy('temp_layout/'.$path.'/assets','site/'.$path);
                                    $this->rcopy('temp_layout/'.$path.'/views',$this->config->application->siteViewsDir.$path);
                                    unlink($info->dirpath);
                                    $this->del_all('temp_layout/'.$path);
                                    
                                    $data=new MTemplate();
                                    $data->name=$path;
                                    $data->title=$this->request->getPost('title');
                                    $data->save();
                                    $this->flashSession->success("Template ".$this->request->getPost('title')." berhasil ditambahkan !!! ");
                                    $this->response->redirect('template');
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    public function editAction($pk,$param=false)
    {
        $row=MTemplate::findFirstByname($pk);
        if($pk == '' || $row == false)
        {
            throw new Exception('konten tidak tersedia');
        }
        if($this->request->isAjax())
        {
            $this->view->disable();
            if(method_exists(__CLASS__,$param))
            {
                $this->{$param}();
            }
            else
            {
                throw new Exception("konten tidak tersedia");
            }
        }
        elseif($this->request->isPost())
        {
            $row->title=$this->request->getPost('title');
            $row->update();
            $this->flashSession->notice("Edit template ".$this->request->getPost('title')." berhasil !!! ");
            $this->response->redirect('template');
        }
        else
        {
            $data['row']=$row;
            $this->view->setVar('data',(object)$data);
        }
    }
    
    private function set_active()
    {
        $pk=$this->request->getPost('pk');
        $row=MTemplate::findFirstByname($pk);
        if($pk == '' || $row == false)
        {
            throw new Exception('konten tidak tersedia');
        }
        $this->db->execute("UPDATE m_template SET active=0");
        $row->active=$this->request->getPost('stts');
        $row->update();
        $this->rs->success=true;
        $this->rs->send();
    }
    
    public function deleteAction()
    {
        if($this->request->isAjax())
        {
            $this->view->disable();
            $pk=$this->request->getPost('pk');
            $row=MTemplate::findFirstByname($pk);
            if($pk == '' || $row == false)
            {
                throw new Exception('konten tidak tersedia');
            }
            $row->delete();
            if(is_dir('site/'.$pk))
            {
                $this->del_all('site/'.$pk);
            }
            if(is_dir($this->config->application->siteViewsDir.$pk))
            {
                $this->del_all($this->config->application->siteViewsDir.$pk);
            }
            
            $this->rs->success=true;
            $this->rs->message='Hapus template '.$pk.' berhasil...!!!';
            $this->rs->send();
        }
        else
        {
            $this->show404();
        }
    }
    
    private function del_all($dirname)
    {
        if (is_dir($dirname))
           $dir_handle = opendir($dirname);
    	 if (!$dir_handle)
    	      return false;
    	 while($file = readdir($dir_handle)) {
    	       if ($file != "." && $file != "..") {
    	            if (!is_dir($dirname."/".$file))
    	                 unlink($dirname."/".$file);
    	            else
    	                 $this->del_all($dirname.'/'.$file);
    	       }
    	 }
    	 closedir($dir_handle);
    	 rmdir($dirname);
    	 return true;
    }
    // Function to remove folders and files 
    private function rrmdir($dir) {
        if (is_dir($dir)) {
            $files = scandir($dir);
            foreach ($files as $file)
                if ($file != "." && $file != "..") $this->rrmdir("$dir/$file");
            rmdir($dir);
        }
        else if (file_exists($dir)) unlink($dir);
    }

    // Function to Copy folders and files       
    private function rcopy($src, $dst) {
        if (file_exists ( $dst ))
            $this->rrmdir( $dst );
        if (is_dir ( $src )) {
            mkdir ( $dst );
            $files = scandir ( $src );
            foreach ( $files as $file )
                if ($file != "." && $file != "..")
                    $this->rcopy( "$src/$file", "$dst/$file" );
        } else if (file_exists ( $src ))
            copy ( $src, $dst );
    }
}