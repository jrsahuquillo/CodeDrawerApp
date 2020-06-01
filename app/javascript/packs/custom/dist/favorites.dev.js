"use strict";

$(document).on('turbolinks:load', function () {
  $('.create-favorite').click(function () {
    count = $(this).children().find('.total-favorites').text();
    count = parseInt(count) + 1;
    $(this).addClass('d-none');
    $(this).siblings().removeClass('d-none');
    $(this).siblings().find('.total-favorites').text(count.toString());
  });
  $('.destroy-favorite').click(function () {
    count = $(this).children().find('.total-favorites').text();
    count = parseInt(count) - 1;
    $(this).addClass('d-none');
    $(this).siblings().removeClass('d-none');
    $(this).siblings().find('.total-favorites').text(count.toString());
  });
});