//= require cable
//= require_self
//= require_tree .

$(document).on('turbolinks:load', function () {
  App.bookmark = App.cable.subscriptions.create('BookmarkChannel', {
    connected: function () { },
    received: function (data) {
      return this.renderNoti(data);
    },
    renderNoti: function (data) {
      // prepend new noti to top of the notifications list
      $('#noti_list').prepend(
        '<div>' +
          '<li class= "well-sm no-margin hover-bottom unread-noti">' +
            '<b>' + data.bookmarker +
            '</b> has ' + data.event +
            ' your ' + data.lesson +
            ' at <i>' + data.created_at + '</i>' +
            '<a class="read_marker" href = "#" > mark as read</a>' +
          '</li>' +
        '</div>' +
        '<hr class="no-margin"/>'
      );

      // remove last notification and recount noti
      $('#noti_list > div:last').remove();
      $('#noti_list > hr:last').remove();
      recountNoti();
    }
  });

  // mark read a noti when click on "mark as read" link
  $('#noti_list').on('click', '.read_marker', function (event) {
    $(this).closest('li').removeClass('unread-noti');
    recountNoti();
    return event.preventDefault();
  });

  // mark read all noti when click on "mark as read all" link
  $('#read_marker_all').on('click', function (event) {
    $('.unread-noti').removeClass('unread-noti');
    recountNoti();
    return event.preventDefault();
  });

  // recount notifications
  function recountNoti() {
    var unread_noti = $('.unread-noti').length;
    unread_noti = (unread_noti == 0) ? '' : '(' + unread_noti + ')';
    $('#noti_counter').html(unread_noti);
  }
});
