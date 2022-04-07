<?php
use Phalcon\Mvc\User\Component;

class Myassets extends Component
{
    public function assetsBase()
    {
        $this->assets->collection("cssHeader")
            ->addCss('theme/lte/bootstrap/css/bootstrap.min.css')
            ->addCss('css/fontawesome/css/font-awesome.min.css')
            ->addCss('https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css')
            ->addCss('theme/lte/dist/css/AdminLTE.min.css')
            ->addCss('theme/lte/dist/css/skins/skin-blue.min.css')
            ->addCss('css/loader-body.css');
        $this->assets->collection('jsHeader')
            ->addJs('theme/lte/plugins/jQuery/jquery-2.2.3.min.js')
            ->addJs('theme/lte/bootstrap/js/bootstrap.min.js')
            ->addJs('theme/lte/plugins/slimScroll/jquery.slimscroll.min.js')
            ->addJs('theme/lte/plugins/fastclick/fastclick.js')
            ->addJs("plugin/bootstrap-datetimepicker/moment.js")
            ->addJs("plugin/bootstrap-datetimepicker/moment-with-locales.js")
            ->addJs('theme/lte/dist/js/app.min.js');
    }
    
    public function assetDataTable()
    {
        $this->assets->collection("cssHeader")
            ->addCss('plugin/datatables/responsive/dataTables.bootstrap.min.css')
            ->addCss('plugin/datatables/responsive/responsive.bootstrap.min.css')
            ->addCss('plugin/datatables/jquery.dataTables_themeroller.css')
            ->addCss('plugin/datatables/fixedHeader.dataTables.min.css');
        $this->assets->collection('jsHeader')
            ->addJs('plugin/datatables/responsive/jquery.dataTables.min.js')
            ->addJs('plugin/datatables/dataTables.bootstrap.min.js')
            ->addJs('plugin/datatables/responsive/dataTables.responsive.min.js')
            ->addJs('plugin/datatables/responsive/responsive.bootstrap.min.js')
            ->addJs('plugin/datatables/dataTables.fixedHeader.min.js');
    }
    
    public function assetsFormValidation()
    {
        $this->assets->collection("cssHeader")
            ->addCss('plugin/formvalidation/css/formValidation.min.css');
        $this->assets->collection('jsHeader')
            ->addJs('plugin/formvalidation/js/formValidation.min.js')
            ->addJs('plugin/formvalidation/js/framework/bootstrap.min.js')
            ->addJs('plugin/formvalidation/js/language/id_ID.js');
    }
    
    public function treeTable()
    {
        $this->assets->collection("cssHeader")
            ->addCss('plugin/treetable/css/jquery.treetable.theme.default.css')
            ->addCss('plugin/treetable/css/jquery.treetable.css');
        $this->assets->collection('jsHeader')
            ->addJs('plugin/treetable/jquery.treetable.js');
    }
    
    public function selectPicker()
    {
        $this->assets->collection("cssHeader")
            ->addCss('plugin/selectpicker/bootstrap-select.min.css');
        $this->assets->collection('jsHeader')
            ->addJs('plugin/selectpicker/bootstrap-select.min.js');
    }
    
    public function dflip()
    {
        $this->assets->collection("cssHeader")
            ->addCss('plugin/dflip/css/dflip.css')
            ->addCss('plugin/dflip/css/themify-icons.css');
        $this->assets->collection('jsHeader')
            ->addJs('plugin/dflip/js/dflip.js');
    }
    
    public function jstree()
    {
        $this->assets->collection("cssHeader")
            ->addCss('plugin/jstree/dist/themes/default/style.min.css');
        $this->assets->collection('jsHeader')
            ->addJs('plugin/jstree/dist/jstree.min.js');
    }
    
    public function datepicker()
    {
        $this->assets->collection("cssHeader")
            ->addCss('plugin/datepicker/datepicker3.css');
        $this->assets->collection('jsHeader')
            ->addJs('plugin/datepicker/bootstrap-datepicker.js')
            ->addJs('plugin/datepicker/locales/bootstrap-datepicker.id.js');
    }
    
    public function select2()
    {
        $this->assets->collection("cssHeader")
            ->addCss('plugin/select2/select2.min.css');
        $this->assets->collection('jsHeader')
            ->addJs('plugin/select2/select2.full.min.js');
    }
    
    public function chosenAjax()
    {
        $this->assets->collection("cssHeader")
             ->addCss("plugin/chosen-ajax-addition/vendor/chosen.css");
        $this->assets->collection('jsHeader')
            ->addJs("plugin/chosen-ajax-addition/vendor/chosen.jquery-1.0.js")
            ->addJs("plugin/chosen-ajax-addition/chosen.ajaxaddition.jquery.js");
    }
    
    public function chosen()
    {
        $this->assets->collection("cssHeader")
            ->addCss('plugin/chosen/chosen.min.css');
        $this->assets->collection('jsHeader')
            ->addJs('plugin/chosen/chosen.jquery.min.js');
    }
    
    public function nestable()
    {
        $this->assets->collection("cssHeader")
            ->addCss('plugin/nestable/style.nestable.css');
        $this->assets->collection('jsHeader')
            ->addJs('plugin/nestable/jquery.nestable.js');
    }
    
    public function easyAutocomplete()
    {
        $this->assets->collection("cssHeader")
            ->addCss('plugin/EasyAutocomplete/easy-autocomplete.min.css')
            ->addCss('plugin/EasyAutocomplete/easy-autocomplete.themes.min.css');
        $this->assets->collection('jsHeader')
            ->addJs('plugin/EasyAutocomplete/jquery.easy-autocomplete.min.js');
    }
    
    public function dateTimePicker()
    {
        $this->assets->collection("cssHeader")
            ->addCss('plugin/bootstrap-datetimepicker/build/css/bootstrap-datetimepicker.min.css');        
        $this->assets->collection('jsHeader')
            ->addJs("plugin/bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js");
    }
    
    public function prismjs()
    {
        $this->assets->collection("cssHeader")
            ->addCss('plugin/prismjs/prism.css');
        $this->assets->collection('jsHeader')
            ->addJs('plugin/prismjs/prism.js');
    }
    
    public function highcharts()
    {
        $this->assets->collection("cssHeader")
            ->addCss('plugin/highcharts/code/css/highcharts.css');
        $this->assets->collection('jsHeader')
            ->addJs('plugin/highcharts/code/js/highcharts.js')
            ->addJs('plugin/highcharts/code/js/modules/exporting.js')
            ->addJs('plugin/highcharts/code/js/modules/offline-exporting.js');
    }
}