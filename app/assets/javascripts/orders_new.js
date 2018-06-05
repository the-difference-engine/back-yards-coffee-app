$('.orders.new').ready(function() {
  radioButtons = document.querySelectorAll('.radio_buttons');

  function showLoadingDiv() {
    $('.loading').show();
    $('.orderSummaryTable').hide();
  }

  function showOrderSummary() {
    $('.loading').hide();
    $('.orderSummaryTable').show();
    $('.orderCheckout').show();
  }

  function ajaxShippingMethod() {
    showLoadingDiv();
    const urlString = window.location.href;
    const url = new URL(urlString);
    const orderId = url.searchParams.get('order_id');
    const shippingHtml = document.querySelector('.shipping');
    $.ajax({
      type: 'PATCH',
      url: `/orders/${orderId}/${this.id}`,
      success: data => {
        showOrderSummary();
        $('#steps-3-4').html(data);
      },
      error: data => {
        console.log(orderId);
        console.log(data);
      }
    });
  }

  $(radioButtons).click(ajaxShippingMethod);
});
