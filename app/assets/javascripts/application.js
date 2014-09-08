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

  $('.featured_image').unbind('click');
  $('.featured_image').click(function() {
    window.location = '/blog_entries/'+$(this).data('id')
  })

  $('.show_comments').unbind('click');
  $('.show_comments').click(function() {
    var blog_id = $(this).data('blogid');
    $.ajax({
      url: "/comments/"+blog_id,
      method: 'GET'
    }).done(function(res) {
      console.log(blog_id);
      $('.comments[data-blogid='+blog_id+']').html(res);
    });
  });

  init_comment_delete();
  init_comment_form();
  indent_comments();
  init_comment_reply();
  init_comment_cancel();
}

function init_comment_cancel() {
  $('.comments .cancel').unbind('click');
  $('.comments .cancel').click(function() {
    var form = $('form.new_comment');
    form.appendTo($('div.comments'));
    $('.comments .cancel').addClass('hidden');
    $('#comment_parent').val(0);
  });
}

function init_comment_reply() {
  $('.comments .reply').unbind('click');
  $('.comments .reply').click(function() {
    var form = $('form.new_comment');
    form.appendTo($(this).closest('li'));
    $(this).siblings('.cancel').removeClass('hidden');
    $('#comment_parent').val($(this).data('commentid'));
  });
}

function init_comment_delete() {
  $('.comments .delete').unbind('click');
  $('.comments .delete').click(function() {
    comment_id = $(this).data('commentid');
    $.ajax({
      url: "/comments/"+comment_id,
      method: "DELETE"
    }).done(function(res) {
      $('div.comments').replaceWith(res);
      indent_comments();
      init_comment_form();
      init_comment_delete();
      init_comment_reply();
      init_comment_cancel();
    });
  });
}

function init_comment_form() {
  $('form.new_comment .ajax_submit').unbind('click');
  $('form.new_comment .ajax_submit').click(function() {
    var urlstring = $('form.new_comment').serialize();
    $.ajax({
      url: "/comments/",
      method: 'POST',
      data: urlstring
    }).done(function(res) {
      $('div.comments').replaceWith(res);
      indent_comments();
      init_comment_form();
      init_comment_delete();
      init_comment_reply();
      init_comment_cancel();
    });
  });
}

function indent_comments()
{
  $('.comment_holder').each(function() {
    $(this).css('margin-left', $(this).data('depth') * 50);
  })
}

$(document).ready(ready);
$(document).on('page:load', ready);
