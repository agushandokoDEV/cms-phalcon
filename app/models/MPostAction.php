<?php

class MPostAction extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var string
     * @Primary
     * @Identity
     * @Column(type="string", length=20, nullable=false)
     */
    public $id;

    /**
     *
     * @var string
     * @Column(type="string", length=20, nullable=true)
     */
    public $post_id;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=true)
     */
    public $author;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $ket;

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'm_post_action';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return MPostAction[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return MPostAction
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
