// Document Ready
$(document).ready(() => {
  $('.products.index').ready(productsReady);
  $('.products.show').ready(productsReady);
});

const productsReady = () => {
  $('select').material_select(); // for show page
  $(document).on('click', '.add', clickAdd);
  $(document).on('change', 'form', changeProductForm);
};

// Handlers
const clickAdd = event => {
  event.preventDefault();
  const link = $(event.target).parent();
  link.tooltip('hide');
  const prodID = link.attr('id').slice(2);
  $('.product_form').slideUp('fast');
  $('.description').slideDown('fast');
  getForm(prodID, event).then(() => $('select').material_select());
};

const changeProductForm = event => {
  if (event.target.id === 'plan') {
    const form = $(event.target).closest('form');
    if (event.target.value === '') {
      form.attr('action', '/carted_products');
    } else {
      form.attr('action', '/carted_subscriptions');
    }
  }
};

// ajax
const getForm = (prodID, event) => {
  return $.ajax({
    type: 'GET',
    url: `/products/${prodID}`,
    success: data => {
      $(event.target)
        .parent()
        .closest('.card-reveal')
        .find('.product_form')
        .html(data)
        .slideToggle('fast');
      $(event.target)
        .parent()
        .closest('.description')
        .slideToggle('fast');
    }
  });
};
