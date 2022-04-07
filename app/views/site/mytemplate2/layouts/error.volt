<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>{{title}}</title>
    <link rel="stylesheet" href="/site/{{var_template}}/style.css"/>
    <link rel="stylesheet" href="/site/{{var_template}}/smartmenus-1.1.0/addons/bootstrap/jquery.smartmenus.bootstrap.css"/>
    
    <script type="text/javascript" src="/site/{{var_template}}/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="/site/{{var_template}}/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/site/{{var_template}}/jquery-ticker/jquery.easy-ticker.min.js"></script>
    <script type="text/javascript" src="/site/{{var_template}}/smartmenus-1.1.0/jquery.smartmenus.min.js"></script>
    <script type="text/javascript" src="/site/{{var_template}}/smartmenus-1.1.0/addons/bootstrap/jquery.smartmenus.bootstrap.min.js"></script>
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
            visible: 3,
            interval: 4000
        });
    });
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
        <a class="navbar-brand" href="/">My Template</a>
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
            <h3 style="margin-top: 0;border-bottom: 4px double #ddd;padding-bottom: 5px;color: whitesmoke;font-weight: bold; text-shadow: 1px 1px 5px black;font-family: tes-font;">Kategori</h3>
            <?php $this->partial("layouts/list_category",['list_category'=>$list_category]);?>
            <h3 style="margin-top: 20px;border-bottom: 4px double #ddd;padding-bottom: 5px;color: whitesmoke;font-weight: bold; text-shadow: 1px 1px 5px black;font-family: tes-font;">Informasi</h3>
            <p><i>
            Diskon besar-besaran spesial ramadhan,
            diskon berlaku sampai tanggal 1 januari 2010
            </i></p>
            <h3 style="margin-top: 20px;border-bottom: 4px double #ddd;padding-bottom: 5px;color: whitesmoke;font-weight: bold; text-shadow: 1px 1px 5px black;font-family: tes-font;">Top Produk</h3>
            <div class="myWrapper">
            <ul class="list-unstyled">
                <li style="border-bottom: 1px solid #ddd;padding: 10px 0 10px 0;">
                    <div class="media">
                      <div class="media-left">
                        <a href="#">
                          <img class="media-object img-thumbnail no-radius" alt="64x64" style="width: 64px; height: 64px;" src="/site/mytemplate/k1.jpg" data-holder-rendered="true">
                        </a>
                      </div>
                      <div class="media-body">
                        <h4 class="media-heading">Kaos uu</h4>
                        <p><small>tes tes tess</small></p>
                      </div>
                    </div>
                </li>
            </ul>
        </div>
        </div>
        
        <div class="col-md-9">
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