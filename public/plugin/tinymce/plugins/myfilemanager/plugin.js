/**
 *
 *
 * @author Josh Lobe
 * http://ultimatetinymcepro.com
 */
 
jQuery(document).ready(function($) {


	tinymce.PluginManager.add('myfilemanager', function(editor, url) {
		
		
		editor.addButton('myfilemanager', {
			
			image: url + '/img/if_32_171485.png',
			tooltip: 'File Manager',
			onclick: open_myfilemanager
		});
		
		function open_myfilemanager() {
			
			
		}
		
	});
});