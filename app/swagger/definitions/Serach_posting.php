<?php

/**
 * @SWG\Definition()
 */
class Search_posting
{
    /**
     * @SWG\Property()
     * @var integer
     */
    public $page;
    
    /**
     * @SWG\Property()
     * @var string
     */
    public $q;
}