<?php

class MAdvertisement extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=11, nullable=false)
     */
    public $id;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=true)
     */
    public $advertiser;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $start_date;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $end_date;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $status;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=true)
     */
    public $url_web;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $post_location;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $contract;

    /**
     *
     * @var double
     * @Column(type="double", length=10, nullable=true)
     */
    public $price;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'm_advertisement';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return MAdvertisement[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return MAdvertisement
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
