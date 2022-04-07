<?php

use Phalcon\Mvc\View;
use Phalcon\Mvc\View\Engine\Php as PhpEngine;
use Phalcon\Mvc\Url as UrlResolver;
use Phalcon\Mvc\View\Engine\Volt as VoltEngine;
use Phalcon\Mvc\Model\Metadata\Memory as MetaDataAdapter;
use Phalcon\Session\Adapter\Files as SessionAdapter;
use Phalcon\Flash\Session as Flash;
use Phalcon\Logger\Adapter\File as FileAdapter;
use Phalcon\Mvc\Dispatcher as PhDispatcher;
use Phalcon\Logger\Formatter\Line as LineFormatter;
use Phalcon\Http\Request;
use Phalcon\Cache\Backend\Memcache;
use Phalcon\Cache\Frontend\Data as FrontData;

/**
 * Shared configuration service
 */
$di->setShared('config', function () {
    return include APP_PATH . "/config/config.php";
});

/**
 * The URL component is used to generate all kind of urls in the application
 */
$di->setShared('url', function () {
    $config = $this->getConfig();

    $url = new UrlResolver();
    $url->setBaseUri($config->application->baseUri);

    return $url;
});

/**
 * Setting up the view component
 */
$di->setShared('view', function () {
    $config = $this->getConfig();

    $view = new View();
    $view->setDI($this);
    $view->setViewsDir($config->application->viewsDir);
    $view->registerEngines([
        '.volt' => function ($view) {
            $config = $this->getConfig();

            $volt = new VoltEngine($view, $this);

            $volt->setOptions([
                'compiledPath' => $config->cache->dir,
                'compiledSeparator' => '_',
                'compileAlways' => (bool)$config->cache->compileAlways
            ]);

            return $volt;
        }
    ]);

    return $view;
});

/**
 * Database connection is created based in the parameters defined in the configuration file
 */
$di->setShared('db', function () {
    $config = $this->getConfig();

    $class = 'Phalcon\Db\Adapter\Pdo\\' . $config->database->adapter;
    $connection = new $class([
        'host'     => $config->database->host,
        'username' => $config->database->username,
        'password' => $config->database->password,
        'dbname'   => $config->database->dbname,
        'port'   => $config->database->port,
        'charset'  => $config->database->charset
    ]);

    return $connection;
});


/**
 * If the configuration specify the use of metadata adapter use it or use memory otherwise
 */
$di->setShared('modelsMetadata', function () {
    return new MetaDataAdapter();
});

/**
 * Register the session flash service with the Twitter Bootstrap classes
 */
$di->set('flash', function () {
    return new Flash([
        'error'   => 'alert alert-danger',
        'success' => 'alert alert-success',
        'notice'  => 'alert alert-info',
        'warning' => 'alert alert-warning'
    ]);
});

/**
 * Start the session the first time some component request the session service
 */
$di->setShared('session', function () {
    $session = new SessionAdapter();
    $session->start();

    return $session;
});

/**
 * LOGGER USERS ACTIVITY
 * FORMAT : [days, 05 May 17 23:57:49 +0700][log status] log message
 */
$di->setShared('logger',function(){
    $config = $this->getConfig();
    $path=$config->logs->dir;
    $foldername=$config->logs->foldername.'/';
    $filename=$config->logs->filename;
    if(!is_dir($path.$foldername)){
        mkdir($path.$foldername,0775,true);
    }
    $request=new Request();
    $session = new SessionAdapter();
    $users='unknown users';
    if($session->has('auth'))
    {
        $users = $session->auth->username;
    }
    $milliseconds = round(microtime(true) * 1000);
    $formatter = new LineFormatter('%date% : '.$milliseconds.' - [%type%]['.$request->getClientAddress().']['.$users.'] - %message%');
    $logger = new FileAdapter($path.$foldername.$filename);//$path.$foldername.$filename
    $logger->setFormatter($formatter);
    return $logger;
});

/**
 * CACHE REDIS
 */
$di->set('redis',function(){
    $config = $this->getConfig();
    $frontCache = new Phalcon\Cache\Frontend\Data([
        "lifetime" => (int)$config->redis->lifetime
    ]);
    
    $cache = new Phalcon\Cache\Backend\Redis($frontCache, [
        "host" => $config->redis->host,
        "port" => $config->redis->port,
        "prefix"=>$config->redis->prefix,
        "statsKey"=>'_mycms',
        "index"      => 0
    ]);
    return $cache;
});

$di->setShared('mycache', function () {
    $frontCache = new FrontData(
        [
            "lifetime" => 3600,
        ]
    );
    
    // Create the Cache setting memcached connection options
    $cache = new Memcache(
    $frontCache,
        [
            "host"       => "localhost",
            "port"       => 11211,
            "persistent" => false,
        ]
    );
    return $cache;
});

/**
 * DISPATCH APPS
 * ERROR HANDLING
 * ACCESS CONTROL LISTS (ACL)
 */
$di->set(
    'dispatcher',
    function() use ($di) {
        try{
            $evManager = $di->getShared('eventsManager');
            $evManager->attach('dispatch:beforeDispatch',new SecurityPlugin());
            $evManager->attach('dispatch:beforeException',new ExceptionPlugin());
            $dispatcher = new PhDispatcher();
            $dispatcher->setEventsManager($evManager);
            return $dispatcher;
        }catch(\Exception $e)
        {
            echo $e->getMessage();
        }
    },
    true
);
//$di->set('uploader', '\Uploader\Uploader');

/**
 * standard response API
 */
$di->setShared('rs', function () {
    return new AjaxResponse();
});

/**
 * app helpers
 */
$di->setShared('myhelp', function () {
    return new MyHelpers();
});

$di->setShared('multimenu', function () {
    return new Multimenu();
});

$di->setShared('myassets', function () {
    return new Myassets();
});
$di->setShared('mymedia', function () {
    return new MyMedia();
});
$di->setShared('algolia', function () {
    $client = new \AlgoliaSearch\Client('U41C6YBXVL', 'c76b6585a7a918f48ba579de8b9c1564');
    $index = $client->initIndex('my_cms');
    return $index;
});