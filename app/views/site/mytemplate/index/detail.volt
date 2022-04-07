{% extends "layouts/base.volt" %}
{% block content %}
<div class="media">
    <div class="media-body"> 
        <h2 class="media-heading">{{content.data.post_title|stripslashes}}</h2>
        <span class="label label-default">{{content.data.publish_on}}</span>
        <span class="label label-info">views : {{content.post_views}}</span>
        <span class="label label-success">Category : {{content.data.category}}</span>
        <br /><br />
        {{content.data.post_content}}
        
        {% if content.list_media|length > 0 %}
        <div id="slide-content-page" class="carousel slide" data-ride="carousel">
            <ol class="carousel-indicators">
                {% for m_slide in content.list_media %}
                <li data-target="#slide-content-page" data-slide-to="{{m_slide['media_id']}}" class=""></li>
                {% endfor %}
            </ol>
            <div class="carousel-inner">
                {% for m_slide in content.list_media %}
                <div class="item">
                    <img style="width: 100%;" src="{{m_slide['media_uri']['lg']}}" alt="{{m_slide['media_caption']}}">
                    <div class="carousel-caption">
                      {{m_slide['media_caption']}}
                    </div>
                </div>
                {% endfor %}
            </div>
            <a class="left carousel-control" href="#slide-content-page" data-slide="prev">
              <span class="fa fa-angle-left"></span>
            </a>
            <a class="right carousel-control" href="#slide-content-page" data-slide="next">
              <span class="fa fa-angle-right"></span>
            </a>
        </div>
        {% endif %}
        
        {% if content.data.event_date_start != null %}
        <hr />
        <div class="panel panel-default">
          <div class="panel-heading">
            <h3 class="panel-title">Event Reminder</h3>
          </div>
          <div class="panel-body">
            <div class="row">
                <div class="col-md-6">
                    <h5>{{content.data.event_location_name}}</h5>
                    <hr style="margin: 0 0 5px 0;"/>
                    <button class="btn btn-default btn-sm" id="authorize-button" style="display: none;"><i class="fa fa-user"></i> Authorize </button>
                    <button class="btn btn-default btn-sm" onclick="reminder()" id="signout-button" style="display: none;"><i class="fa fa-calendar-check-o"></i> Reminder</button>
                </div>
                <div class="col-md-6">
                    <h5>{{content.data.event_location_name}}</h5>
                    <hr style="margin: 0;"/>
                    <p>{{content.data.event_location_addres}}</p>
                </div>
            </div>
          </div>
        </div>
        {% endif %}
        <br />
    </div> 
</div>

<!--
<div id="fb-root"></div>

<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = 'https://connect.facebook.net/id_ID/sdk.js#xfbml=1&version=v2.12&appId=114707905839550&autoLogAppEvents=1';
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>
<div class="fb-share-button" 
    data-href="http://panel.mycms.apps/index/detail/mengenal-apa-itu-framework-codeigniter" 
    data-layout="button_count" 
    data-size="small" 
    data-mobile-iframe="true">
    <a target="_blank" href="https://www.facebook.com/sharer/sharer.php?u=https%3A%2F%2Fdevelopers.facebook.com%2Fdocs%2Fplugins%2F&amp;src=sdkpreparse" class="fb-xfbml-parse-ignore">Bagikan</a>
</div>
-->

{% if content.post_related_tags|length > 0 %}

<div class="row">
<div class="col-md-1">
    <p>Tags:</p>
</div>
<div class="col-md-11">
{% for category in content.post_related_tags %}
<a style="text-decoration: none;" href="/index/tags/{{category.tags_slug}}"><span class="label label-success">{{category.tags_title}}</span></a>
{% endfor %}
</div>
</div>
{% endif %}

{% if content.post_related|length > 0 %}
<br />
<h2>Artikel terkait</h2>
<hr/>
<div class="row">
    {% for related in content.post_related %}
    <div class="col-md-4">
        <div class="thumbnail" style="height: 400px;">
            {% if related.post_cover == null %}
            <img src="/img/no-image.jpg" style="height: 200px;">
            {% else %}
            <img src="{{related.media_path}}" style="height: 200px;"/>
            {% endif %}
          <div class="caption">
            <h4><a href="/index/detail/{{related.post_slug}}"><?php $this->myhelp->char_limit(preg_replace("#<(.*)/(.*)>#iUs", "", stripslashes($related->post_title)),30) ?></a></h4>
            <p><?php $this->myhelp->char_limit(preg_replace("#<(.*)/(.*)>#iUs", "", $related->post_content),100) ?></p>
          </div>
        </div>
    </div>
    {% endfor %}
</div>
{% endif %}
{% if content.data.event_date_start != null %}
<script type="text/javascript">
      
  // Client ID and API key from the Developer Console
  var CLIENT_ID = '{{config.api.google.client_id}}';
  var API_KEY = '{{config.api.google.key}}';

  // Array of API discovery doc URLs for APIs used by the quickstart
  var DISCOVERY_DOCS = ["{{config.api.google.calendar.discovery_docs}}"];

  // Authorization scopes required by the API; multiple scopes can be
  // included, separated by spaces.
  var SCOPES = "{{config.api.google.calendar.scopes}}";

  var authorizeButton = document.getElementById('authorize-button');
  var signoutButton = document.getElementById('signout-button');
  var GoogleAuth;
  /**
   *  On load, called to load the auth2 library and API client library.
   */
  function handleClientLoad() {
    gapi.load('client:auth2', initClient);
  }
  handleClientLoad();

  /**
   *  Initializes the API client library and sets up sign-in state
   *  listeners.
   */
  function initClient() {
    gapi.client.init({
      apiKey: API_KEY,
      clientId: CLIENT_ID,
      discoveryDocs: DISCOVERY_DOCS,
      scope: SCOPES
    }).then(function () {
      // Listen for sign-in state changes.
      GoogleAuth = gapi.auth2.getAuthInstance();
      gapi.auth2.getAuthInstance().isSignedIn.listen(updateSigninStatus);
      // Handle the initial sign-in state.
      updateSigninStatus(gapi.auth2.getAuthInstance().isSignedIn.get());
      authorizeButton.onclick = handleAuthClick;
      //signoutButton.onclick = handleSignoutClick;
    });
    
  }

  /**
   *  Called when the signed in status changes, to update the UI
   *  appropriately. After a sign-in, the API is called.
   */
  function updateSigninStatus(isSignedIn) {
    if (isSignedIn) {
      authorizeButton.style.display = 'none';
      signoutButton.style.display = 'block';
      console.log(GoogleAuth.currentUser.get().w3.U3);
      //listUpcomingEvents();
    } else {
      authorizeButton.style.display = 'block';
      signoutButton.style.display = 'none';
    }
  }

  /**
   *  Sign in the user upon button click.
   */
  function handleAuthClick(event) {
    gapi.auth2.getAuthInstance().signIn();
  }

  /**
   *  Sign out the user upon button click.
   */
  function handleSignoutClick(event) {
    gapi.auth2.getAuthInstance().signOut();
  }
  
  
  // Refer to the JavaScript quickstart on how to setup the environment:
  // https://developers.google.com/google-apps/calendar/quickstart/js
  // Change the scope to 'https://www.googleapis.com/auth/calendar' and delete any
  // stored credentials.

function reminder(){
    
    var event = {
      'summary': '{{content.data.post_title|stripslashes}}',
      'location': '{{content.data.event_location_name}}',
      'description':'{{content.current_url}}',
      'start': {
        'dateTime': (new Date('{{content.data.event_date_start}}')).toISOString(),
        'timeZone': 'Asia/Jakarta'
      },
      'end': {
        'dateTime': (new Date('{{content.data.event_date_end}}')).toISOString(),
        'timeZone': 'Asia/Jakarta'
      },
      'reminders': {
        'useDefault': false,
        'overrides': [
          {'method': 'email', 'minutes': parseInt('{{config.api.google.calendar.reminder.email}}')},
          {'method': 'popup', 'minutes': parseInt('{{config.api.google.calendar.reminder.popup}}')}
        ]
      },
      "source": {
        "url": '{{content.current_url}}',
        "title": '{{content.data.post_title|stripslashes}}'
      }
    };
    
    var request = gapi.client.calendar.events.insert({
      'calendarId': 'primary',
      'resource': event
    });
    
    request.execute(function(event) {
        if(event.htmlLink == null){
            alert('Error create reminder')
        }
      //alert('Event created: ' + event.htmlLink);
      console.log(event.htmlLink);
    });
}
</script>
{% endif %}
{% endblock %}