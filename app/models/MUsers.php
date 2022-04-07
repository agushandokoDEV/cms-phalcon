<?php

use Phalcon\Mvc\Model\Validator\Email as Email;

class MUsers extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var string
     * @Primary
     * @Column(type="string", length=50, nullable=false)
     */
    public $username;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=true)
     */
    public $email;

    /**
     *
     * @var string
     * @Column(type="string", length=150, nullable=true)
     */
    public $password;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=true)
     */
    public $roles;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $create_at;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $last_login;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=true)
     */
    public $status;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=true)
     */
    public $mapping_author;
    public $full_name;
    public $acces_post_type;
    public $show_all_author;
    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'm_users';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return MUsers[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return MUsers
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
