// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function () {
  $('form').on('click', '.remove_record', function (event) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('#edit-word').hide();
    return event.preventDefault();
  });

  $('form').on('click', '.add_fields', function (event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $('.fields').append($(this).data('fields').replace(regexp, time));
    return event.preventDefault();
  });

  // mark read a noti when click on "mark as read" link
  $('#noti_list').on('click', '.read-marker', function (event) {
    $(this).closest('li').removeClass('unread-noti');
    $('#noti_dropdown').toggleClass('inactive-bell').toggleClass('active-bell');
    recountNoti();
    return event.preventDefault();
  });

  // mark read all noti when click on "mark as read all" link
  $('#read_marker_all').on('click', function (event) {
    $('.unread-noti').removeClass('unread-noti');
    $('#noti_dropdown').toggleClass('inactive-bell').toggleClass('active-bell');
    recountNoti();
    return event.preventDefault();
  });

  // toggle when click on notification bell
  $('#noti_dropdown').on('click', function () {
    $(this).toggleClass('inactive-bell').toggleClass('active-bell');
  });
});

// global functions

// recount notification
function recountNoti() {
  var unread_noti = $('.unread-noti').length;
  unread_noti = (unread_noti == 0) ? '' : unread_noti;
  $('#noti_counter').html('<span class="badge bgc-red">' +
    unread_noti + '</span>');
}

// render new notification
function renderNoti (newNoti) {
  // prepend new noti to top of the notifications list
  $('#noti_list').prepend(newNoti);

  // remove last notification and recount noti
  $('#noti_list > div:last').remove();
  $('#noti_list > hr:last').remove();
  recountNoti();
}
