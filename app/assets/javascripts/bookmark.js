//= require cable
//= require_self
//= require_tree .

$(document).on('turbolinks:load', function () {
  App.bookmark = App.cable.subscriptions.create('BookmarkChannel', {
    connected: function () { },
    received: function (data) {
      return renderNoti(this.bookmarkNoti(data));
    },
    bookmarkNoti: function (data) {
      var bookmarkNoti =
        '<div>' +
          '<li class= "well-sm no-margin hover-bottom unread-noti">' +
            '<b>' + data.broadcaster +
            '</b> has ' + data.event +
            ' your ' + data.lesson +
            ' at <i>' + data.created_at + '</i>' +
            '<a class="read-marker normal-link" href = "#" > mark as read</a>' +
          '</li>' +
        '</div>' +
        '<hr class="no-margin"/>';
      return bookmarkNoti;
    }
  });
});
