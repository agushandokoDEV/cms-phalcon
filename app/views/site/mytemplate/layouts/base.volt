<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>{{config.apps.blogname}} - {{title|stripslashes}}</title>
    
    <link rel="stylesheet" href="{{path_assets}}/style.css"/>
    <link rel="stylesheet" href="{{path_assets}}/smartmenus-1.1.0/addons/bootstrap/jquery.smartmenus.bootstrap.css"/>
    <link rel="stylesheet" href="{{path_assets}}/prismjs/prism.css"/>
        
    <script type="text/javascript" src="{{path_assets}}/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="{{path_assets}}/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="{{path_assets}}/jquery-ticker/jquery.easy-ticker.min.js"></script>
    <script type="text/javascript" src="{{path_assets}}/smartmenus-1.1.0/jquery.smartmenus.min.js"></script>
    <script type="text/javascript" src="{{path_assets}}/smartmenus-1.1.0/addons/bootstrap/jquery.smartmenus.bootstrap.min.js"></script>
    <script type="text/javascript" src="{{path_assets}}/prismjs/prism.js"></script>
    <script type="text/javascript" src="{{path_assets}}/highlight/js/jQuery.highlight.js"></script>
    <script type="text/javascript" src="{{config.api.google.calendar.src}}"></script>
    
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    
    <script>
    $(function(){
        $('.myWrapper').easyTicker({
            direction: 'down',
            visible: 5,
            interval: 4000
        });
        $('#slide-home-page .carousel-indicators li:first').addClass('active');
        $('#slide-home-page .carousel-inner .item:first').addClass('active');
        $('#slide-all-page .carousel-indicators li:first').addClass('active');
        $('#slide-all-page .carousel-inner .item:first').addClass('active');  
        if(getCookie('mdl_advs') == ''){
            setCookie('mdl_advs',1);
            $('#mdl-advs').modal('show');
        }
    });
    
    function setCookie(cname, cvalue) {
        var d = new Date();
        d.setTime(d.getTime() + (5 * 60 * 1000));
        var expires = "expires="+d.toUTCString();
        document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
    }
    
    function getCookie(cname) {
        var name = cname + "=";
        var ca = document.cookie.split(';');
        for(var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') {
                c = c.substring(1);
            }
            if (c.indexOf(name) == 0) {
                return c.substring(name.length, c.length);
            }
        }
        return "";
    }
    
    function checkCookie() {
        var user = getCookie("username");
        if (user != "") {
            alert("Welcome again " + user);
        } else {
            user = prompt("Please enter your name:", "");
            if (user != "" && user != null) {
                setCookie("username", user, 365);
            }
        }
    }
    </script>
  </head>
  <body>
  
  
  <div class="container" style="margin-top: 10px;">
    <!-- Navbar -->
    <div class="navbar navbar-default" role="navigation">
      <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
          <span class="sr-only">Toggle navigation</span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="/">{{config.apps.blogname}}</a>
      </div>
      <div class="navbar-collapse collapse">
    
        <!-- Left nav -->
        <?php $this->partial("layouts/list_top_menu",['list_menu'=>$list_top_menu]);?>
    
      </div><!--/.nav-collapse -->
    </div>
  </div>
  <div class="container">
    <div class="row">
        <div class="col-md-3">
            <?php $this->partial("layouts/list_category",['list_category'=>$list_category]);?>
            <?php $this->partial("layouts/list_tags",['list_tags'=>$list_tags]);?>
            <?php $this->partial("layouts/slide_advertising",['advertising_all_page'=>$advertising_all_page]);?>
            <?php $this->partial("layouts/top_list_post",['top_list_content'=>$top_list_content]);?>
        </div>
        
        <div class="col-md-9">
            <div class="panel panel-default">
              <div class="panel-heading" style="padding-bottom: 0;">
                <div class="row">
                    <div class="col-md-12">
                        <form action="/index/search" method="GET">
                          <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                <label class="sr-only" for="exampleInputPassword3">Password</label>
                                    <div class="input-group">
                                  <input type="text" name="keyword" class="form-control" value="{{keyword_search}}" placeholder="Masukan kata pencarian...">
                                  <span class="input-group-btn">
                                    <button class="btn btn-info" type="submit"><i class="fa fa-search"></i></button>
                                  </span>
                                </div>
                              </div>
                            </div>
                          </div>
                        </form>
                    </div>
                </div>
              </div>
            </div>
            <hr />
            {% block content %}{% endblock %}
        </div>
    </div>
  </div>
  <br />
  <footer class="footer navbar-inverse no-radius">
      <div class="container footer-container">
        <p class="text-muted">Place sticky footer content here.</p>
      </div>
    </footer>
  </body>
</html>