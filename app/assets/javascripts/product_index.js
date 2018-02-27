$(document).ready(function () {
  $('select').material_select();
  $('.tooltipped').tooltip({ delay: 5 });
  const addToCart = document.querySelectorAll('.add');

  function buyForm() {
    const thisProdId = this.id.slice(2);
    $.ajax({
      type: 'GET',
      url: `/products/${thisProdId}`,
      success: (data) => {
        this.closest('.innercard').innerHTML = data;
      },

      error: function () {},
    }).then(function () {
      $('select').material_select();
      addUI();
    });
  }

  function addUI() {
    var $select = $('.plan_select').find('select');
    const $formAction = $('form');
    $select.change(function () {
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
  }

  for (var i = 0; i < addToCart.length; i++) {
    addToCart[i].addEventListener('click', buyForm);
  }
});
