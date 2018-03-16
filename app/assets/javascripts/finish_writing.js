//= require cable
//= require_self
//= require_tree .

$(document).on('turbolinks:load', function () {
  App.finish_writing = App.cable.subscriptions.create('FinishWritingChannel', {
    connected: function () { },
    received: function (data) {
      return renderNoti(this.finishWritingNoti(data));
    },
    finishWritingNoti: function (data) {
      var finishWritingNoti =
        '<div>' +
          '<li class= "well-sm no-margin hover-bottom unread-noti">' +
            data.event + ' <b>' +
            data.third_person + '</b> ' +
            data.lesson + ' at <i>' +
            data.created_at + '</i>' +
            '<a class="read-marker normal-link" href = "#" > mark as read</a>' +
          '</li>' +
        '</div>' +
        '<hr class="no-margin"/>';
      return finishWritingNoti;
    }
  });
});
