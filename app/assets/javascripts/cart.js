$('.carted_products.index').ready(function() {
  const cartedProducts = gon.cartedProducts;
  const cartedSubscriptions = gon.cartedSubscriptions;
  $('.deleteProduct').on('click', deleteProduct);
  $('.quantity-up').on('click', productUp);
  $('.quantity-down').on('click', productDown);
});

const deleteProduct = event => {
  const id = getEventId(event);
  ajaxDeleteProduct(id);
  hideItem(event);
};

const productUp = event => {
  const id = getEventId(event);
  const quantity = getSpinnerInput(event);
  ajaxUpdateProduct(id, quantity + 1);
  setSpinnerInput(event, quantity + 1);
  console.log('increase product');
};

const productDown = event => {
  const id = getEventId(event);
  const quantity = getSpinnerInput(event);
  ajaxUpdateProduct(id, quantity - 1);
  setSpinnerInput(event, quantity - 1);
  console.log('decrease product');
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
