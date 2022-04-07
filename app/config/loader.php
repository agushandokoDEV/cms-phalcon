<?php
require_once $config->application->libraryDir.'/dompdf/autoload.inc.php';
$loader = new \Phalcon\Loader();

/**
 * We're a registering a set of directories taken from the configuration file
 */
$loader->registerDirs(
    [
        $config->application->controllersDir,
        $config->application->modelsDir,
        $config->application->viewsDir,
        $config->application->libraryDir,
        $config->application->pluginsDir,
        $config->application->helpersDir
    ]
);
$loader->register();
