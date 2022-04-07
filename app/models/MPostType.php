<?php

class MPostType extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var string
     * @Primary
     * @Column(type="string", length=100, nullable=false)
     */
    public $post_type;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=true)
     */
    public $post_type_des;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $post_type_status;

    /**
     *
     * @var string
     * @Column(type="string", length=30, nullable=true)
     */
    public $post_title;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=true)
     */
    public $post_icon;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'm_post_type';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return MPostType[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return MPostType
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
