<?php

//echo "AAA ".getenv('DATABASE_NAME');
/*
 * Modified: preppend directory path of current file, because of this file own different ENV under between Apache and command line.
 * NOTE: please remove this comment.
 */
defined('BASE_PATH') || define('BASE_PATH', getenv('BASE_PATH') ?: realpath(dirname(__FILE__) . '/../..'));
defined('APP_PATH') || define('APP_PATH', BASE_PATH . '/app');

include BASE_PATH . '/vendor/autoload.php';
$dotenv = new Dotenv\Dotenv(APP_PATH.'/config/env');
$dotenv->load();

return new \Phalcon\Config([
    'database' => [
        'adapter'     => 'Mysql',
        'host'        => getenv('DB_HOST'),
        'port'        => getenv('DB_PORT'),
        'username'    => getenv('DB_USER'),
        'password'    => getenv('DB_PASS'),
        'dbname'      => getenv('DB_NAME'),
        'charset'     => 'utf8',
    ],
    'application' => [
        'appDir'         => APP_PATH . '/',
        'controllersDir' => APP_PATH . '/controllers/',
        'modelsDir'      => APP_PATH . '/models/',
        'migrationsDir'  => APP_PATH . '/migrations/',
        'viewsDir'       => APP_PATH . '/views/',
        'pluginsDir'     => APP_PATH . '/plugins/',
        'helpersDir'     => APP_PATH . '/helpers/',
        'libraryDir'     => APP_PATH . '/library/',
        'swaggerDir'     => APP_PATH . '/swagger/',
        'siteViewsDir'   => APP_PATH . '/views/site/',
        'baseUri'        => '/',
    ],
    'apps'=>[
        'title'=>getenv('APP_TITLE'),
        'blogname'=>getenv('APP_BLOGNAME'),
        'site_url'=>getenv('APP_SITEURL'),
        'blogdescription'=>getenv('APP_BLOG_DESCRIPTION'),
        'admin_email'=>getenv('APP_ADMIN_EMAIL'),
        'posts_per_page'=>(int)getenv('APP_POST_PER_PAGE'),
        'copyright'=>"2017-2018",
        'version'=>"1.0"
    ],
    'mailserver'=>[
        'url'=>getenv('MAIL_URL'),
        'user'=>getenv('MAIL_USER'),
        'pass'=>getenv('MAIL_PASS'),
        'port'=>getenv('MAIL_PORT')
    ],
    'api'=>[
        'google'=>[
            'key'=>getenv('GOOGLE_KEY'),
            'client_id'=>getenv('GOOGLE_CLIENTID'),
            'maps'=>[
                'src'=>'https://maps.googleapis.com/maps/api/js?key='.getenv('GOOGLE_KEY').'&libraries=places',
                'default'=>[
                    'lat'=>'-6.416282861292479',
                    'lng'=>'106.94641718749995',
                    'zoom'=>4,
                    'mapTypeId'=>'roadmap'
                ]
            ],
            'calendar'=>[
                'src'=>'https://apis.google.com/js/api.js',
                'discovery_docs'=>'https://www.googleapis.com/discovery/v1/apis/calendar/v3/rest',
                'scopes'=>'https://www.googleapis.com/auth/calendar',
                'reminder'=>[
                    'email'=>(int)getenv('REMINDER_EMAIL'), // minutes
                    'popup'=>(int)getenv('REMINDER_POPUP') // minutes
                ]
            ]
        ],
        'facebook'=>[
            
        ],
        'twiiter'=>[
        
        ]
    ],
    'logs'=>[
        'dir'           => APP_PATH . '/logs/',
        'filename'      => date('Y-m-d').'.log',
        'foldername'    => date('Ym')
    ],
    'cache'=>[
        'dir'           => BASE_PATH . '/cache/',
        'compileAlways' => getenv('COMPILE'),
    ],
    'redis'=>[
        'host'          => getenv("REDIS_HOST"),
        'port'          => getenv("REDIS_PORT"),
        'keys'          => getenv("REDIS_KEYS"),
        'prefix'        => getenv("REDIS_PREFIX"),
        'lifetime'      => getenv("REDIS_LIFETIME"),
        'persistent'    => getenv("REDIS_PERSISTENT")
    ]
]);
