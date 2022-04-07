jQuery backDetect
---

Determining when a user clicks their browser's back button has never been easier with this jQuery plugin.  With a quick easy install and minimal set up work you'll be firing callback functions on back button declarations in no time.  

View a demo of it <a href="http://ianrogren.github.io/jquery-backDetect/">here</a>.

**Disclaimer:** This plugin was originally developed for an edge case where I did not have access to the all of the history state functions and I needed a way to set localStorage variable when the back button was clicked.  This plugin works great for very simple back detection, but if you need to do anything more advanced that involves history state functions, this might not be the plugin for you.

### Installation
---
- Download the latest release from here (or `npm install jquery-backdetect` or `bower install jquery-backdetect`)
- Copy either `jquery.backDetect.js` or `jquery.backDetect.min.js` to your scripts folder
- Include the script after you call on `jQuery`

### Browser Support

| Chrome | Firefox | Internet Explorer | Safari |
| --- | --- | --- | --- |
| All ✔ | All ✔ | All ✔ | All ✔ |

### Basic Usage

Can append to any element or class:

``` javascript

  $(window).load(function(){
    $('body').backDetect(function(){
	  // Callback function
      alert("Look forward to the future, not the past!");
    });
  });</script>
```

### Custom Options

You can set a delay intiate the back detect.  Very similar to setting the time in setTimeout:

``` javascript

  $(window).load(function(){
    $('body').backDetect(function(){
      // Callback function
      alert("Look forward to the future, not the past!");
    });
  }, 1000); // <- 1 second delay

````

| Settings | Default Value | Description
| --- | --- | --- |
| delay | <pre>delay: 0</pre> |  The length of time it takes for the backDetect plugin to fire and monitor when a user hits the back button. 

### Change Log

1.0.3 Cleaned up javascript and updated README.md

1.0.2 Added backDetect to `npm` and `bower` repos.

1.0.1 Removed the need for the 1x1.png image for IE.


### Licence 
```

                        __
                _,..,_ (, )
             .,'      `,./
           .' :`.----.': `,
          :   : ^    ^ :   ;
         :   :  6    6  :   ;
         :   :          :   ;
         :   :    __    :   ;
< MIT >   :   `:'.--.`:'   ;
           `.  : o  o :  .'
            :   `----'   :  
            : .  :'`:  . :
            `.:.'    `.:.' 
```


