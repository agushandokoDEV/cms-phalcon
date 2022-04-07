/*!
 * reCaptcha1 add-on
 * This add-ons shows and validates a Google reCAPTCHA v1
 *
 * @link        http://formvalidation.io/addons/reCaptcha1/
 * @license     http://formvalidation.io/license/
 * @author      https://twitter.com/formvalidation
 * @copyright   (c) 2013 - 2015 Nguyen Huu Phuoc
 * @version     v0.3.1, built on 2015-08-10 4:19:48 PM
 */
!function(a){FormValidation.AddOn.reCaptcha1={html5Attributes:{element:"element",message:"message",sitekey:"siteKey",theme:"theme",url:"url"},CAPTCHA_FIELD:"recaptcha_response_field",init:function(b,c){function d(){a("#recaptcha_reload").on("click",function(){b.addField(e.CAPTCHA_FIELD)});var d=b.getNamespace();b.getForm().on(f.events.fieldAdded,function(a,b){if(b.field===e.CAPTCHA_FIELD){var f=b.element.data(d+".icon");f.insertAfter("#"+c.element)}}).formValidation("addField",e.CAPTCHA_FIELD,{validators:{callback:{message:c.message,callback:function(a){return""!==a},onError:function(){Recaptcha.reload()}}}}).on(f.events.validatorSuccess,function(a,b){b.field===e.CAPTCHA_FIELD&&b.element.data(d+".icon").hide()}).on("submit",function(){var d=Recaptcha.get_response(),f=Recaptcha.get_challenge();if(""===d)return!1;var g=!0,h=null;return a.ajax({async:!1,type:"POST",url:c.url,data:{recaptcha_challenge_field:f,recaptcha_response_field:d},dataType:"json",success:function(a){g=a.valid===!0||"true"===a.valid,h=a.message}}),g?!0:(b.updateStatus(e.CAPTCHA_FIELD,b.STATUS_INVALID,"callback"),h&&b.updateMessage(e.CAPTCHA_FIELD,"callback",h),!1)})}var e=this,f=b.getOptions();if("undefined"==typeof Recaptcha)throw new Error("reCaptcha add-on requires Google Recaptcha. Ensure that you include recaptcha_ajax.js to page");Recaptcha.create(c.siteKey,c.element,{theme:c.theme||"red",callback:d})}}}(jQuery);