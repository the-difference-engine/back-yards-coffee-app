$('.orders.new').ready(function () {
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
      url: `/api/orders/${orderId}/${this.id}`,
      contentType: 'application/json; charset=utf-8',
      dataType: 'json',
      success: (data) => {
        showOrderSummary();

        var order = data.order.filter(item => item.id === this.id)[0];
        var orderView = order.amount * 0.01;
        var total = document.querySelector('.total');
        shippingHtml.innerHTML = `$${orderView.toFixed(2)}`;
        var totals = $('.price');
        var sum = 0;
        for (var i = 0; i < totals.length; i++) {
          //strip out dollar signs and commas
          var v = $(totals[i]).text().replace(/[^\d.]/g, '');

          //convert string to integer
          var ct = parseFloat(v);
          sum += ct;
        }

        total.innerHTML = `$${sum}`;
      },
    });
  }

  $(radioButtons).click(ajaxShippingMethod);
});
