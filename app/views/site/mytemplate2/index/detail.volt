{% extends "layouts/base.volt" %}
{% block content %}
<div class="media">
    <div class="media-body"> 
        <h2 class="media-heading">{{content.data.post_title}}</h2>
        <span class="label label-default">{{content.data.publish_on}}</span>
        <span class="label label-default">views : {{content.post_views}}</span>
        <br /><br />
        {{content.data.post_content}}
        
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
{% for category in content.post_related %}
<a style="text-decoration: none;" href="/index/tags/{{category.tags_slug}}"><span class="label label-success">{{category.tags_title}}</span></a>
{% endfor %}
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
      'summary': '{{content.data.post_title}}',
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
        "title": '{{content.data.post_title}}'
      }
    };
    
    var request = gapi.client.calendar.events.insert({
      'calendarId': 'primary',
      'resource': event
    });
    
    request.execute(function(event) {
      alert('Event created: ' + event.htmlLink);
      console.log(event.htmlLink);
    });
}
</script>
{% endif %}
{% endblock %}