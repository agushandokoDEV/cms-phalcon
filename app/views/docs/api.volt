<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <title>API - {{config.apps.title}}</title>
        <link rel="icon" type="image/png" href="/swagger/images/favicon-32x32.png" sizes="32x32" />
        <link rel="icon" type="image/png" href="/swagger/images/favicon-16x16.png" sizes="16x16" />
        <link href='/swagger/css/typography.css' media='screen' rel='stylesheet' type='text/css'/>
      <link href='/swagger/css/reset.css' media='screen' rel='stylesheet' type='text/css'/>
      <link href='/swagger/css/screen.css' media='screen' rel='stylesheet' type='text/css'/>
      <link href='/swagger/css/reset.css' media='print' rel='stylesheet' type='text/css'/>
      <link href='/swagger/css/print.css' media='print' rel='stylesheet' type='text/css'/>
      <script src='/swagger/lib/jquery-1.8.0.min.js' type='text/javascript'></script>
      <script src='/swagger/lib/jquery.slideto.min.js' type='text/javascript'></script>
      <script src='/swagger/lib/jquery.wiggle.min.js' type='text/javascript'></script>
      <script src='/swagger/lib/jquery.ba-bbq.min.js' type='text/javascript'></script>
      <script src='/swagger/lib/handlebars-2.0.0.js' type='text/javascript'></script>
      <script src='/swagger/lib/underscore-min.js' type='text/javascript'></script>
      <script src='/swagger/lib/backbone-min.js' type='text/javascript'></script>
      <script src='/swagger/swagger-ui.min.js' type='text/javascript'></script>
      <script src='/swagger/lib/highlight.7.3.pack.js' type='text/javascript'></script>
      <script src='/swagger/lib/marked.js' type='text/javascript'></script>
      <script src='/swagger/lib/swagger-oauth.js' type='text/javascript'></script>

        <script type="text/javascript">
        $(function () {
          var url = window.location.search.match(/url=([^&]+)/);
          if (url && url.length > 1) {
            url = decodeURIComponent(url[1]);
          } else {
            url = "/docs/rest";//http://petstore.swagger.io/v2/swagger.json
          }
    
          // Pre load translate...
          if(window.SwaggerTranslator) {
            window.SwaggerTranslator.translate();
          }
          window.swaggerUi = new SwaggerUi({
            url: url,
            dom_id: "swagger-ui-container",
            validatorUrl: null,
            supportedSubmitMethods: ['get', 'post', 'put', 'delete', 'patch'],
            onComplete: function(swaggerApi, swaggerUi){
              if(typeof initOAuth == "function") {
                initOAuth({
                  clientId: "your-client-id",
                  clientSecret: "your-client-secret",
                  realm: "your-realms",
                  appName: "your-app-name",
                  scopeSeparator: ","
                });
              }
    
              if(window.SwaggerTranslator) {
                window.SwaggerTranslator.translate();
              }
    
              $('pre code').each(function(i, e) {
                hljs.highlightBlock(e)
              });
    
              addApiKeyAuthorization();
            },
            onFailure: function(data) {
              log("Unable to Load SwaggerUI");
            },
            docExpansion: "none",
            apisSorter: "alpha",
            showRequestHeaders: true
          });
    
    
          function addApiKeyAuthorization(){
            var key = encodeURIComponent($('#input_apiKey')[0].value);
            if(key && key.trim() != "") {
                var apiKeyAuth = new SwaggerClient.ApiKeyAuthorization("token", key, "header");
                window.swaggerUi.api.clientAuthorizations.add("token", apiKeyAuth);
                log("added key " + key);
            }
          }
    
          $('#input_apiKey').change(addApiKeyAuthorization);
          // if you have an apiKey you would like to pre-populate on the page for demonstration purposes...
          /*
            var apiKey = "myApiKeyXXXX123456789";
            $('#input_apiKey').val(apiKey);
          */
    
          window.swaggerUi.load();
    
          function log() {
            if ('console' in window) {
              console.log.apply(console, arguments);
            }
          }
      });
      </script>
    </head>
    <body class="swagger-section">
    <div id='header'>
      <div class="swagger-ui-wrap" style="max-width: none;">
        <a id="logo" href="#">API.MyCMS</a>
        <form id='api_selector'>
          <div class='input'><input placeholder="#" id="input_baseUrl" name="baseUrl" type="text" disabled=""/></div>
          <div class='input'><input placeholder="token" id="input_apiKey" name="apiKey" type="hidden"/></div>
          <div class='input'><a id="explore" href="#" data-sw-translate>Explore</a></div>
        </form>
      </div>
    </div>
    
    <div id="message-bar" class="swagger-ui-wrap" data-sw-translate>&nbsp;</div>
    <div id="swagger-ui-container" class="swagger-ui-wrap"></div>
    </body>
</html>