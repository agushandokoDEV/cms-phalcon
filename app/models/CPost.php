<?php
use Phalcon\Db;
class CPost extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var string
     * @Primary
     * @Identity
     * @Column(type="string", length=20, nullable=false)
     */
    public $post_id;
    public $post_parent;
    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=true)
     */
    public $post_author;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $post_title;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $post_content;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $post_status;

    /**
     *
     * @var string
     * @Column(type="string", length=200, nullable=true)
     */
    public $post_slug;

    /**
     *
     * @var string
     * @Column(type="string", length=100, nullable=true)
     */
    public $post_type;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $post_create;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $post_modified;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=true)
     */
    public $post_modified_by;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $menu_order;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $post_cover;

    /**
     *
     * @var integer
     * @Column(type="integer", length=4, nullable=true)
     */
    public $post_comment_status;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $publish_on;
    public $post_language;
    public $visibility;
    public $post_relation_lang;
    public $post_reference;
    public $event_location_name;
    public $event_location_addres;
    public $event_date_start;
    public $event_date_end;
    public $event_location_long;
    public $event_location_lat;
    public $post_category;
    public $post_reminder;
    public $publish_schedule;
    public $custom_url;
    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'c_post';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return CPost[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return CPost
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }
    
    public function afterUpdate()
    {
        $this->post_action('update');
        //$this->content_tags();
    }
    public function afterDelete()
    {
        $this->post_action('delete');
    }
    
    public function beforeDelete()
    {
        //$this->getDi()->getShared('db')->query("DELETE FROM r_relation_post_media WHERE post_id=$this->post_id");
        $this->getDi()->getShared('db')->query("DELETE FROM c_post_category WHERE post_id=$this->post_id");
    }
    
    private function post_action($ket)
    {
        $post_act=new MPostAction();
        $post_act->post_id=$this->post_id;
        $post_act->author=$this->post_modified_by;
        $post_act->ket=$ket;
        $post_act->save();
    }
    
    private function content_tags()
    {
        if(count($this->post_reference) > 0)
        {
            $this->getDi()->getShared('db')->query("DELETE FROM r_relation_tags WHERE post_parent=$this->post_id");
            $this->getDi()->getShared('db')->query("
                insert into r_relation_tags (post_id,tags_slug,post_parent)
                SELECT
                	post_id,
                	post_reference,
                    $this->post_id
                FROM
                	c_post
                WHERE
                	post_id <> $this->post_id
                AND (
                	MATCH (post_reference) AGAINST (
                		'$this->post_reference' IN NATURAL LANGUAGE MODE
                	)
                ) > 0
                ORDER BY
            	(
            		MATCH (post_reference) AGAINST (
            			'$this->post_reference' IN NATURAL LANGUAGE MODE
            		)
            	) DESC
            ");
        }
    }
}
