$(document).on('turbolinks:load', function() {
  $('#next').on('click', function() {
    if(!$('.active').is(':last-child')) {
      var learnt_words = $('#learnt_words').html();
      var words_size = $('#words_size').html();

      learnt_words++;
      $('#learnt_words').html(learnt_words);
      $('#progress_bar').css('width', learnt_words / words_size * 100 + '%');
      if(learnt_words == words_size) {
        $('#finish_msg').show();
      }

      $('.active').removeClass('active').addClass('inactive');
      $('.inactive').next().addClass('active');
      $('.words').hide();
      $('.active').fadeIn();
      $('.inactive').removeClass('inactive');
    }
  });

  $('#prev').on('click', function() {
    if(!$('.active').is(':first-child')) {
      $('#finish_msg').hide();
      var learnt_words = $('#learnt_words').html();
      var words_size = $('#words_size').html();

      learnt_words--;
      $('#learnt_words').html(learnt_words);
      $('#progress_bar').css('width', learnt_words / words_size * 100 + '%');

      $('.active').removeClass('active').addClass('inactive');
      $('.inactive').prev().addClass('active');
      $('.inactive').removeClass('inactive');
      $('.words').hide();
      $('.active').fadeIn();
    }
  });

  $('#show').on('click', function() {
    if ($('.active > .text').is(':visible')) {
      $('.active > .text').hide();
      $('.active > .def').fadeIn();
    } else {
      $('.active > .text').fadeIn();
      $('.active > .def').hide();
    }
  });
});
