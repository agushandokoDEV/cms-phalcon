<?php

class RRelationPostMedia extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var string
     * @Primary
     * @Identity
     * @Column(type="string", length=20, nullable=false)
     */
    public $r_media_id;

    /**
     *
     * @var string
     * @Column(type="string", length=20, nullable=true)
     */
    public $post_id;

    /**
     *
     * @var string
     * @Column(type="string", length=20, nullable=true)
     */
    public $media_id;
    public $post_parent;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'r_relation_post_media';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RRelationPostMedia[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RRelationPostMedia
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
