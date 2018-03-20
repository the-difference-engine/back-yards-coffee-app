$(document).ready(function () {
  const amountAndPercent = document.querySelector('#amount_and_percent_form');
  var $select = $('.duration_select').find('select');

  $select.change(function () {
    if ($select.val() === 'repeating') {
      $('#duration_in_months').show();
    } else {
      $('#duration_in_months').hide();
      $("input[name='duration_in_months']").val('');
    }
  });
});
