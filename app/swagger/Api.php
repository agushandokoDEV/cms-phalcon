<?php

class Api
{
    /**
     *
     * @SWG\Get(
     *   path="api/list_page",
     *   tags={"I. PAGE"},
     *   summary="list menu (post type = page)",
     *   produces={"application/json"},
     *   @SWG\Response(
     *     response=200,
     *     description="success"
     *   )
     * )
     * @return string
     */
     
     /**
     *
     * @SWG\Get(
     *   path="api/detail_page/{post_slug}",
     *   tags={"I. PAGE"},
     *   summary="detail page",
     *   produces={"application/json"},
     *     @SWG\Parameter(
     *     in="path",
     *     type="string",
     *     name="post_slug",
     *     required=true,
     *     @SWG\Schema(ref="#/definitions/Post_by_slug")
     *   ),
     *   @SWG\Response(
     *     response=200,
     *     description="success"
     *   )
     * )
     * @return string
     */
     
     /**
     *
     * @SWG\Get(
     *   path="api/list_posting",
     *   tags={"II. POSTING"},
     *   summary="list posting",
     *   produces={"application/json"},
     *     @SWG\Parameter(
     *     in="query",
     *     type="integer",
     *     name="page",
     *     required=false,
     *     @SWG\Schema(ref="#/definitions/List_post_content")
     * ),
     *   @SWG\Response(
     *     response=200,
     *     description="success"
     *   )
     * )
     * @return string
     */
     
     /**
     *
     * @SWG\Get(
     *   path="api/search_posting",
     *   tags={"II. POSTING"},
     *   summary="pencarian posting",
     *   produces={"application/json"},
     *     @SWG\Parameter(
     *     in="query",
     *     type="integer",
     *     name="page",
     *     required=false,
     *     @SWG\Schema(ref="#/definitions/Search_posting")
     * ),
     *     @SWG\Parameter(
     *     in="query",
     *     type="string",
     *     name="q",
     *     required=true,
     *     @SWG\Schema(ref="#/definitions/Search_posting")
     * ),
     *   @SWG\Response(
     *     response=200,
     *     description="success"
     *   )
     * )
     * @return string
     */
     
     /**
     *
     * @SWG\Get(
     *   path="api/list_post_media_attachment/{post_id}",
     *   tags={"II. POSTING"},
     *   summary="list media attachment (galery foto pada konten)",
     *   produces={"application/json"},
     *     @SWG\Parameter(
     *     in="path",
     *     type="integer",
     *     name="post_id",
     *     required=true,
     *     @SWG\Schema(ref="#/definitions/Post_by_id")
     *   ),
     *   @SWG\Response(
     *     response=200,
     *     description="success"
     *   )
     * )
     * @return string
     */
     
     /**
     *
     * @SWG\Get(
     *   path="api/detail_posting/{post_slug}",
     *   tags={"II. POSTING"},
     *   summary="detail posting",
     *   produces={"application/json"},
     *     @SWG\Parameter(
     *     in="path",
     *     type="string",
     *     name="post_slug",
     *     required=true,
     *     @SWG\Schema(ref="#/definitions/Post_by_slug")
     *   ),
     *   @SWG\Response(
     *     response=200,
     *     description="success"
     *   )
     * )
     * @return string
     */
     
     /**
     *
     * @SWG\Get(
     *   path="api/list_post_by_tags",
     *   tags={"II. POSTING"},
     *   summary="list post by (kategori)",
     *   produces={"application/json"},
     *     @SWG\Parameter(
     *     in="query",
     *     type="integer",
     *     name="page",
     *     required=false,
     *     @SWG\Schema(ref="#/definitions/Post_by_tags_slug")
     * ),
     *     @SWG\Parameter(
     *     in="query",
     *     type="string",
     *     name="tags",
     *     required=true,
     *     @SWG\Schema(ref="#/definitions/Post_by_tags_slug")
     * ),
     *   @SWG\Response(
     *     response=200,
     *     description="success"
     *   )
     * )
     * @return string
     */
     
     /**
     *
     * @SWG\Get(
     *   path="api/list_tags",
     *   tags={"III. TAGS"},
     *   summary=" list post tags(kategori)",
     *   produces={"application/json"},
     *   @SWG\Response(
     *     response=200,
     *     description="success"
     *   )
     * )
     * @return string
     */
     
     /**
     *
     * @SWG\Get(
     *   path="api/list_post_related",
     *   tags={"III. TAGS"},
     *   summary="list post konten terkait",
     *   produces={"application/json"},
     *     @SWG\Parameter(
     *     in="query",
     *     type="integer",
     *     name="page",
     *     required=true,
     *     @SWG\Schema(ref="#/definitions/List_post_related")
     *   ),
     *     @SWG\Parameter(
     *     in="query",
     *     type="integer",
     *     name="post_id",
     *     required=true,
     *     @SWG\Schema(ref="#/definitions/List_post_related")
     *   ),
     *   @SWG\Response(
     *     response=200,
     *     description="success"
     *   )
     * )
     * @return string
     */
     
     /**
     *
     * @SWG\Get(
     *   path="api/list_post_date",
     *   tags={"IV. POST BY DATE"},
     *   summary="list post bulan berdasarakan tahun sekarang",
     *   produces={"application/json"},
     *   @SWG\Response(
     *     response=200,
     *     description="success"
     *   )
     * )
     * @return string
     */
     
     /**
     *
     * @SWG\Get(
     *   path="api/list_post_by_date",
     *   tags={"IV. POST BY DATE"},
     *   summary="list post by date (Y-m)",
     *   produces={"application/json"},
     *     @SWG\Parameter(
     *     in="query",
     *     type="integer",
     *     name="page",
     *     required=true,
     *     @SWG\Schema(ref="#/definitions/List_post_by_date")
     * ),
     *     @SWG\Parameter(
     *     in="query",
     *     type="string",
     *     name="date",
     *     required=true,
     *     @SWG\Schema(ref="#/definitions/List_post_by_date")
     * ),
     *   @SWG\Response(
     *     response=200,
     *     description="success"
     *   )
     * )
     * @return string
     */
}