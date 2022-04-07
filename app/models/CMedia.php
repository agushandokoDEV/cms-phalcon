<?php

class CMedia extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var string
     * @Primary
     * @Identity
     * @Column(type="string", length=20, nullable=false)
     */
    public $media_id;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=true)
     */
    public $media_type;

    /**
     *
     * @var string
     * @Column(type="string", length=200, nullable=true)
     */
    public $media_name;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=true)
     */
    public $media_author;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $media_date;

    /**
     *
     * @var string
     * @Column(type="string", length=200, nullable=true)
     */
    public $media_path;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $file_size;

    /**
     *
     * @var string
     * @Column(type="string", length=50, nullable=true)
     */
    public $file_extension;

    /**
     *
     * @var string
     * @Column(type="string", nullable=true)
     */
    public $media_caption;

    /**
     *
     * @var integer
     * @Column(type="integer", length=11, nullable=true)
     */
    public $album_id;
    public $media_guide;
    public $video_duration;
    public $video_cover;
    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'c_media';
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return CMedia[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return CMedia
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

}
