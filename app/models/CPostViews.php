<?php

class CPostViews extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var string
     * @Primary
     * @Identity
     * @Column(type="string", length=20, nullable=false)
     */
    public $id_post_views;

    /**
     *
     * @var string
     * @Column(type="string", length=30, nullable=true)
     */
    public $ip_addr;

    /**
     *
     * @var string
     * @Column(type="string", length=20, nullable=true)
     */
    public $post_id;
    public $total_views;
    public $last_read;
    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'c_post_views';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return CPostViews[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return CPostViews
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
