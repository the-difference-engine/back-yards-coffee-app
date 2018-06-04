$('.carted_products.index').ready(function() {
  $('.deleteProduct').on('click', deleteProduct);
  $('.productView .quantity-up').on('click', productUp);
  $('.productView .quantity-down').on('click', productDown);
  $('.productEdit').on('change', productChange);
  let cartedSubscriptions = gon.cartedSubscriptions;
  console.log(cartedSubscriptions);
  $('select').material_select();
  $('.subscriptionView .quantity-up').on('click', event => {
    cartedSubscriptions = subscriptionUp(cartedSubscriptions, event);
  });
  $('.subscriptionView .quantity-down').on('click', event => {
    cartedSubscriptions = subscriptionDown(cartedSubscriptions, event);
  });
  $('.deleteSubscription').on('click', event => {
    cartedSubscriptions = deleteSubscription(cartedSubscriptions, event);
  });
});

const productChange = event => {
  console.log('change product');
};

const deleteProduct = event => {
  const id = getEventId(event);
  ajaxDeleteProduct(id);
  hideItem(event);
};

const deleteSubscription = (cartedSubscriptions, event) => {
  const sku = getEventId(event);
  console.log(sku);
  console.log(cartedSubscriptions[0]['parent']);
  newSubscriptions = cartedSubscriptions.filter(subcription => {
    return subcription['parent'] !== sku;
  });
  ajaxUpdateSubscriptions(newSubscriptions);
  hideItem(event);
  return newSubscriptions;
};

const productUp = event => {
  const id = getEventId(event);
  const quantity = getSpinnerInput(event);
  ajaxUpdateProduct(id, quantity + 1);
  setSpinnerInput(event, quantity + 1);
  changeCartAmount(1);
  console.log('increase product');
};

const productDown = event => {
  const id = getEventId(event);
  const quantity = getSpinnerInput(event);
  if (quantity === 1) {
    deleteProduct(event);
  } else {
    ajaxUpdateProduct(id, quantity - 1);
    setSpinnerInput(event, quantity - 1);
    changeCartAmount(-1);
    console.log('decrease product');
  }
};

const subscriptionUp = (cartedSubscriptions, event) => {
  console.log(cartedSubscriptions);
  const sku = getEventId(event);
  const quantity = getSpinnerInput(event);
  cartedSubscriptions.forEach(item => {
    if (item['parent'] === sku) {
      item['quantity'] = quantity + 1;
    }
  });
  ajaxUpdateSubscriptions(cartedSubscriptions);
  setSpinnerInput(event, quantity + 1);
  changeCartAmount(1);
  return cartedSubscriptions;
};

const subscriptionDown = (cartedSubscriptions, event) => {
  console.log(cartedSubscriptions);
  const sku = getEventId(event);
  const quantity = getSpinnerInput(event);
  if (quantity !== 1) {
    cartedSubscriptions.forEach(item => {
      if (item['parent'] === sku) {
        item['quantity'] = quantity - 1;
      }
    });
    ajaxUpdateSubscriptions(cartedSubscriptions);
    setSpinnerInput(event, quantity - 1);
    changeCartAmount(-1);
    return cartedSubscriptions;
  } else {
    return deleteSubscription(cartedSubscriptions, event);
  }
};

const ajaxDeleteProduct = id => {
  $.ajax({
    type: 'DELETE',
    url: '/api/carted_products/' + id,
    contentType: 'application/json; charset=utf-8',
    dataType: 'json'
  });
};

const ajaxUpdateProduct = (id, quantity) => {
  $.ajax({
    type: 'PATCH',
    url: '/api/carted_products/' + id,
    contentType: 'application/json; charset=utf-8',
    dataType: 'json',
    data: JSON.stringify({
      quantity: quantity
    })
  });
};

const ajaxUpdateSubscriptions = items => {
  $.ajax({
    type: 'PATCH',
    url: '/api/carted_subscriptions',
    contentType: 'application/json; charset=utf-8',
    dataType: 'json',
    data: JSON.stringify({
      products: {
        items: items
      }
    })
  });
};

const hideItem = event => {
  $(event.target)
    .closest('li')
    .slideUp();
};

const getEventId = event =>
  $(event.target)
    .closest('li')
    .attr('id')
    .slice(2);

const getSpinnerInput = event => {
  const value = $(event.target)
    .parent()
    .siblings('input')
    .val();
  return parseInt(value);
};

const setSpinnerInput = (event, quantity) => {
  $(event.target)
    .parent()
    .siblings('input')
    .val(quantity);
};

const changeCartAmount = change => {
  $('#cart-amount').text(parseInt($('#cart-amount').text()) + change);
};
