$(document).ready(function() {
  $('select').material_select();
  const thingToWatch = $('div#plan_id').find('select')
  const formAction = $('form')

  thingToWatch.change(function() {
    if ($(this).val() === "One Time Buy") {
      formAction.attr('action', '/cart');
      $('#sku_form').show();
      $('#subscription_form').hide();
    } else {
      formAction.attr('action', '/carted_subscription');
      $('#sku_form').hide();
      $('#subscription_form').show();
    }
  })
})
