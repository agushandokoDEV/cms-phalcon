<?php
use Phalcon\Mvc\Controller;
use Phalcon\Mvc\Dispatcher;
use Phalcon\Db;

class AuthController extends Controller
{
    public function beforeExecuteRoute(Dispatcher $dispatcher)
    {
        
        if($this->session->has('auth') && $dispatcher->getActionName() !='logout')
        {
            $this->dispatcher->forward(
                [
                    "controller" => 'dashboard',
                    "action"     => "index",
                ]
            );
        }
    }
    public function indexAction()
    {
        $this->assets->collection("cssHeader")
            ->addCss('theme/lte/bootstrap/css/bootstrap.min.css')
            ->addCss('https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css')
            ->addCss('https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css')
            ->addCss('theme/lte/dist/css/AdminLTE.min.css')
            ->addCss('theme/lte/plugins/iCheck/square/blue.css');
        $this->assets->collection('jsHeader')
            ->addJs('theme/lte/plugins/jQuery/jquery-2.2.3.min.js')
            ->addJs('theme/lte/bootstrap/js/bootstrap.min.js')
            ->addJs('theme/lte/plugins/iCheck/icheck.min.js')
            ->addJs('js/jquery.form.min.js');
        $this->loginPage();
    }
    
    private function loginPage()
    {
        if($this->session->has('auth'))
        {
            //$this->show404();
        }
    }
    
    protected function set_activity($author,$msg='')
    {
        $data=new MUsersActivity();
        $data->author=$author;
        $data->activity=$msg;
        $data->last_activity=date('Y-m-d H:i:s');
        $data->save();
    }
    
    public function dologinAction()
    {
        if($this->request->isPost())
        {
            $msg='';
            $username=$this->request->getPost('username');
            $password=$this->request->getPost('password');
            $session=[];
            if($username !='' && $password !='')
            {
                
                $users=MUsers::findFirst(
                    [
                        "username = :username:",
                        "bind"=>
                            [
                                "username"=>$username
                            ]
                    ]
                );
                
                if($users)
                {
                    if($this->security->checkHash($password, $users->password))
                    {
                        $users->last_login=date("Y-m-d h:i:s");
                        $users->update();
                        
                        $my_post_type=null;
                        if($users->acces_post_type != null)
                        {
                            $my_post_type=json_decode($users->acces_post_type);
                        }
                        $roles=MRoles::findFirst([
                            "roles='$users->roles'"
                        ]);
                        
                        $list_mapping_author=null;
                        if($users->show_all_author == 'Y')
                        {
                            $list_mapping_author=$users->mapping_author;
                        }
                        else
                        {
                            if(count(json_decode($users->mapping_author) > 0))
                            {
                                $list_mapping_author=json_decode($users->mapping_author);
                            }
                        }
                        
                        $session['username']=$users->username;
                        $session['fullname']=$users->full_name;
                        $session['email']=$users->email;
                        $session['roles']=$users->roles;
                        $session['roles_name']=$roles->roles_name;
                        $session['status']=$users->status;
                        $session['my_post_type']=$my_post_type;
                        $session['show_all_author']=$users->show_all_author;
                        $session['mapping_author']=$list_mapping_author;
                        
                        $this->session->set('auth',(object)$session);
                        $this->set_activity($users->username,'login success');
                        $this->flashSession->success("Login berhasil...");
                        //$this->session->set('auth',(object)$session);
                        //$this->db->query("DELETE FROM c_post WHERE post_status='autosave' AND post_author='$users->username'");
                    }
                    else
                    {
                        $this->flashSession->error("username dan password salah");
                    }
                }
                else
                {
                    $this->flashSession->error("username dan password salah");
                }
            }
            else
            {
                $this->flashSession->error("username dan password tidak boleh kosong");
            }
            $this->response->redirect('/auth');
        }
    }
    
    public function logoutAction()
    {
        $this->view->disable();
        $auth=$this->session->get('auth');
        $this->set_activity($auth->username,'logout success');
        //$this->db->query("DELETE FROM c_post WHERE post_status='autosave' AND post_author='$auth->username'");
        $this->session->destroy();
        $this->response->redirect('/auth');
    }
}