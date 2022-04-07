/**
 *
 *
 * @author Josh Lobe
 * http://ultimatetinymcepro.com
 */
 
jQuery(document).ready(function($) {


	tinymce.PluginManager.add('myyouTube', function(editor, url) {
		
		
		editor.addButton('myyouTube', {
			
			image: url + '/img/if_youtube_317714.png',
			tooltip: 'Youtube',
			onclick: open_youTube
		});
		
		function open_youTube() {
			open_media_youTube();
		}
		
	});
});