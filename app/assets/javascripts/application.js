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
//= require_tree .
//= require ckeditor/init

var ready;
ready = function() {
  $('img.small-home-image').mouseover(function() {
    $(this).animate({opacity: .25}, 500);
  });
  $('img.small-home-image').mouseout(function() {
    $(this).animate({opacity: 1}, 500);
  });

  $('div.small-home-image').mouseover(function() {
    $(this).animate({opacity: .5}, 500);
  });
  $('div.small-home-image').mouseout(function() {
    $(this).animate({opacity: 0}, 500);
  });

  $('.blog-holder').click(function() {
    if ($(this).data('id')) {
      window.location = "/blog_entries/"+$(this).data('id');
    }
  });

  $('.love-link').click(function() {
    if ($(this).data('link')) {
      window.open($(this).data('link'));
    }
  });

  $('#delete_blog_entry').click(function() {
    if (confirm('Are you SURE you want to delete this blog?')) {
      $.ajax({
        url: "/blog_entries/"+$(this).data('blogentryid'),
        method: "DELETE"
      }).done(function() {
        window.location = '/';
      });
    }
  });
  $('#edit_blog_entry').click(function() {
    window.location = '/blog_entries/'+$(this).data('blogentryid')+'/edit'
  });
}

$(document).ready(ready);
$(document).on('page:load', ready);