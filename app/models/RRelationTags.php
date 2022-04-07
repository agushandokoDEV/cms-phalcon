<?php

class RRelationTags extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     * @Primary
     * @Identity
     * @Column(type="integer", length=11, nullable=false)
     */
    public $id_relation_tags;

    /**
     *
     * @var string
     * @Column(type="string", length=20, nullable=true)
     */
    public $post_id;

    /**
     *
     * @var string
     * @Column(type="string", length=255, nullable=true)
     */
    public $tags_slug;

    /**
     *
     * @var string
     * @Column(type="string", length=20, nullable=true)
     */
    public $post_parent;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'r_relation_tags';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return RRelationTags[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return RRelationTags
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
