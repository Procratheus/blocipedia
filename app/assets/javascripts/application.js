// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require semantic-ui
//= require_tree .

// Dismiss flash messages
$(document).ready(function(){
  $('.message .close').on('click', function() {
    $(this).closest('.message').fadeOut();
  });
});

// showdown
$(document).ready(function() {
  marked.setOptions({
    renderer: new marked.Renderer()
    // gfm: true,
    // tables: true,
    // pedantic: false,
    // breaks: true,
    // sanitize: true,
    // smartLists: true,
    // smartypants: true
  });

  var convert = function() {
    $('#preview').html(marked($('#wiki_body').val()));
    $('#preview pre code').each(function(i, block) {
      hljs.highlightBlock(block);
    });
  };

  $('#new_wiki').keyup(convert);
});


