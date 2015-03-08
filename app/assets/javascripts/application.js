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
//= require ckeditor/init
//= require_tree .

var ready;
var current_slide = 0;
var intervalID = 0;

ready = function() {
  $('.activate').unbind('click');
  $('.activate').click(function() {
    var button = this;
    var id = $(this).data('id');
    $.ajax({
      url: "/slides/"+id,
      data: 'active=1',
      method: "PATCH"
    }).done(function(res) {
      window.location.reload();
    });
  });

  $('.deactivate').unbind('click');
  $('.deactivate').click(function() {
    var button = this;
    var id = $(this).data('id');
    $.ajax({
      url: "/slides/"+id,
      data: 'active=0',
      method: "PATCH"
    }).done(function(res) {
      window.location.reload();
    });
  });
 
  $('.delete_slide').unbind('click');
  $('.delete_slide').click(function() {
    var id = $(this).data('id');
    $.ajax({
      url: "/slides/"+id,
      method: 'DELETE'
    }).done(function(res) {
      window.location.reload();
    });
  });

  $('#test_slides').unbind('click');
  $('#test_slides').click(function() {
    window.location.href = '/slides/test';
  });

  $('.goto_slide').unbind('click');
  $('.goto_slide').click(function() {
    var slide_num = $(this).data('slide');
    //$('.slide').addClass('hidden');
    //$('#slide_'+slide_num).toggleClass('hidden');
    $('.slide').fadeOut(500);
    $('#slide_'+slide_num).delay(600).fadeIn(1500);
    current_slide = slide_num;
    clearInterval(intervalID);
    intervalID = setInterval("next_slide()", 5000);
  });

  clearInterval(intervalID); 
  intervalID = setInterval("next_slide()", 5000);

  $('img.small-home-image-reverse').mouseover(function() {
    $(this).animate({opacity: 1}, 500);
  });
  $('img.small-home-image-reverse').mouseout(function() {
    $(this).animate({opacity: .15}, 500);
  });

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
    if ($(this).data('url')) {
      window.location = $(this).data('url');
    }
    else if ($(this).data('id')) {
      window.location = "/blog_entries/"+$(this).data('id');
    }
  });

  $('.love-link').click(function() {
    if ($(this).data('link')) {
      window.open($(this).data('link'));
    }
  });
  $('#delete_image_link').click(function() {
    if (confirm('Are you SURE you want to delete this link?')) {
      $.ajax({
        url: "/image_links/"+$(this).data('imagelinkid'),
        method: "DELETE"
      }).done(function() {
        window.location = '/';
      });
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
    if ($(this).data('url')) {
      window.location = $(this).data('url');
    }
    else if ($(this).data('id')) {
      window.location = "/blog_entries/"+$(this).data('id');
    }
  })

  $('.show_comments').unbind('click');
  $('.show_comments').click(function() {
    var blog_id = $(this).data('blogid');
    $.ajax({
      url: "/comments/"+blog_id,
      method: 'GET'
    }).done(function(res) {
      $('.comments[data-blogid='+blog_id+']').html(res);
    });
  });

  $('#create_slide').unbind('click');
  $('#create_slide').click(function() {
    $.ajax({
      url: "/slides/new",
      method: 'GET'
    }).done(function(res) {
      $('#grey').removeClass('hidden');
      $('#popup').html(res);
      $('#popup').removeClass('hidden');
      $('.cancel-popup').click(function() {
        $('#grey').addClass('hidden');
        $('#popup').addClass('hidden');
      });
    });
  });

  init_comment_delete();
  init_comment_form();
  indent_comments();
  init_comment_reply();
  init_comment_cancel();

  if (window.location.pathname == '/blog_entries') {
    my_hover_pins();
  }
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
    var button = $(this);
    button.prop('disabled',true);
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
      button.prop('disabled',false);
    });
  });
}

function indent_comments()
{
  $('.comment_holder').each(function() {
    $(this).css('margin-left', $(this).data('depth') * 50);
  })
}

function my_hover_pins() {
  $('img').each(function() {
    var image = $(this);
    if (!$(this).data('pin-no-hover')) {
      var url = encodeURIComponent(window.location.origin + image.closest('.single_blog_holder').find('a.blog_title').attr('href'));
      var img_src = encodeURIComponent(window.location.origin + image.attr('src'));
      var title = encodeURIComponent(image.closest('.single_blog_holder').find('a.blog_title').html());
      image.before('<div class="pin-holder hidden"><a href="//www.pinterest.com/pin/create/button/?url='+url+'&media='+img_src+'&description='+title+'" data-pin-do="buttonPin" data-pin-config="none"><img src="//assets.pinterest.com/images/pidgets/pinit_fg_en_rect_gray_20.png" /></a></div>');
    }
    image.mouseover(function() {
      $(this).prev().removeClass('hidden');
    });
    image.mouseleave(function() {
      if (!$(this).prev().is(":hover")) {
        $(this).prev().addClass('hidden');
      }
    });
  });
  $.getScript('//assets.pinterest.com/js/pinit.js');
}

function next_slide() {
  if (current_slide == ($('.slide').length - 1)) {
    current_slide = 0;
  } else {
    current_slide++;
  }
  $('.slide').fadeOut(500);
  $('#slide_'+current_slide).delay(600).fadeIn(1500);
}

$(document).ready(ready);
$(document).on('page:load', ready);
