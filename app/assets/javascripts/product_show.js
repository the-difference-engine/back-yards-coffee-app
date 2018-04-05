$('.products.index').ready(function() {
  $('select').material_select();
  const planSelect = $('div#plan_id').find('select');
  const formAction = $('form');

  planSelect.change(function() {
    if ($(this).val() === 'One Time Buy') {
      formAction.attr('action', '/cart');
      $('#sku_form').show();
      $('#subscription_form').hide();
    } else {
      formAction.attr('action', '/carted_subscription');
      $('#sku_form').hide();
      $('#subscription_form').show();
    }
  });

  $('.products.index').on('submit', 'form', function(event) {
    const params = objectifyForm($(this).serializeArray());
    let ready = true;
    let errors = [];
    // Check for plan_id
    if (params['plan_id'] === '') {
      ready = false;
      errors.push('No plan selected');
    }
    // Check for quantity
    if (params['quantity'] === '') {
      ready = false;
      errors.push('No quantity selected');
    }
    // Check for sku or grind depending on plan_id
    if (params['sku'] === '') {
      ready = false;
      errors.push('No bean style selected');
    }
    console.log(params);
    if (!ready) {
      event.preventDefault();
      Materialize.toast(`${errors.join(', ')}`, 4000, 'pulse red');
    }
  });
});

function objectifyForm(formArray) {
  var returnArray = {};
  for (var i = 0; i < formArray.length; i++) {
    returnArray[formArray[i]['name']] = formArray[i]['value'];
  }
  return returnArray;
}
