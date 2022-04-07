<?php
use Dompdf\Dompdf;
use Dompdf\Options;

class Mydompdf
{
    public $html='';
    private $title;
    
    public function __construct($title='noname')
    {
        $this->title=$title;
    }
    
    public function header($subtitle='')
    {
        $html ='<!DOCTYPE HTML>
                <html>
                <head>
                	<meta http-equiv="content-type" content="text/html" />
                	<title>'.strtoupper($this->title).'</title>
                </head>
                <style>
                *{
                    margin:0;
                    font-family: Arial, "Helvetica Neue", Helvetica, sans-serif;
                    font-weight: normal;
                }
                body {
                    padding:30px 50px 50px50px;
                    background-image: url("img/logoblack2.jpg");
                    background-repeat: no-repeat;
                    background-position: center;
                }
                .center{
                    text-align: center;
                }
                .right{
                    text-align: right;
                }
                .left{
                    text-align: left;
                }
                .header{
                    padding: 5px;
                    height: 50px;
                    width: 100%;
                    margin-bottom: 10px;
                }
                .title{
                    text-align: center;
                    font-size: 20px;
                    text-transform: uppercase;
                }
                table{
                    width:100%;
                }
                table.tbl-header tr td{
                    font-size: 15px;
                }
                table.tbl-header tr td.td-logo{
                    width:10%;
                    text-align: center;
                }
                table.tbl-header tr td.td-logo img.img-logo{
                    width:40px;
                    height:40px;
                }
                hr.hr-header{
                    border:1px solid #ddd;
                    border-bottom:0;
                    margin:10px;
                }
                div.sub-header{
                    margin-bottom:20px;
                }
                table.tbl-sub-header,table.tbl-sub-header tr td{
                    font-size:12px;
                }
                div.content table{
                    font-size:10px;
                }
                div.content table thead{
                    border: 1px solid #ddd;
                    border-right: 0;
                    border-left: 0;
                }
                div.content table thead tr th,div.content table tbody tr td{
                    padding:3px;
                    text-align: center;
                }
                div.content table tbody tr td{
                    font-size:10px;
                    border-bottom: 1px solid #ddd;
                }
                div.content table thead tr th.left,div.content table tbody tr td.left{
                    text-align: left;
                }
                div.content-footer{
                    margin-top:10px;
                }
                </style>
                <body>
                <div class="header">
                    <table class="tbl-header">
                        <tr>
                            <td class="td-logo"><img class="img-logo" src="img/logoblack.jpg"/></td>
                            <td class="td-judul">
                                SEKOLAH TINGGI PARIWISATA BANDUNG
                                <p style="font-size:12px;text-transform: uppercase;">'.$subtitle.'</p>
                            </td>
                        </tr>
                    </table>
                </div>
                <h3 class="title">'.$this->title.'</h3>
                <hr class="hr-header">
                
                </body>
                </html>';
        return $html;
    }
    
    public function subHeader($box1='',$box2='')
    {
        $html='
            <div class="sub-header">
                <table class="tbl-sub-header">
                    <tr>
                        <td>
                            '.$box1.'
                            
                        </td>
                        <td>
                            '.$box2.'
                        </td>
                    </tr>
                </table>
            </div>
        ';
        return $html;
    }
    
    public function content($content='')
    {
        $html='
            <div class="content">
                '.$content.'
            </div>
        ';
        return $html;
    }
    
    public function content_footer($content='')
    {
        $html='
            <div class="content-footer">
                '.$content.'
            </div>
        ';
        return $html;
    }
    
    public function send()
    {
        $options = new Options();
        $options->set('defaultFont', 'Arial');
        $options->set('isRemoteEnabled', TRUE);
        $options->set('debugKeepTemp', TRUE);
        $options->set('isHtml5ParserEnabled', true);
        $dompdf = new Dompdf($options);
        //$html=$this->tes('LAPORAN NILAI MATA KULIAH',$box1,$box2,$content,$cont_footer);
        $dompdf->loadHtml($this->html);
        
        // (Optional) Setup the paper size and orientation
        $dompdf->setPaper('A4', 'potrait');
        
        // Render the HTML as PDF
        $dompdf->render();
        // Output the generated PDF to Browser
        $dompdf->stream($this->title.' '.date('Y-m-d_h-i-s').".pdf", array("Attachment"=>0));
    }
}