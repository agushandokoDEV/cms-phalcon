<?php
use Phalcon\Di\FactoryDefault;
date_default_timezone_set('Asia/Jakarta');
error_reporting(E_ALL);

define('BASE_PATH', dirname(__DIR__));
define('APP_PATH', BASE_PATH . '/app');
include BASE_PATH . '/vendor/autoload.php';
$dotenv = new Dotenv\Dotenv(APP_PATH.'/config/env');
$dotenv->load();

try {

    /**
     * The FactoryDefault Dependency Injector automatically registers
     * the services that provide a full stack framework.
     */
    $di = new FactoryDefault();

    /**
     * Read services
     */
    include APP_PATH . "/config/services.php";

    /**
     * Get config service for use in inline setup below
     */
    $config = $di->getConfig();

    /**
     * Include Autoloader
     */
    include APP_PATH . '/config/loader.php';

    /**
     * Handle the request
     */
    $application = new \Phalcon\Mvc\Application($di);
    echo $application->handle()->getContent();

} catch (\Exception $e) {
    new MyException($e->getMessage(),$e->getCode());
    /*
    echo '<br>';
    echo $e->getMessage() . '<br>';
    echo '<pre>' . $e->getTraceAsString() . '</pre>';
    */
}
