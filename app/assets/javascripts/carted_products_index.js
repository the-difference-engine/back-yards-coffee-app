$('.carted_products.index').ready(function(){

  var inputBoxesProducts = document.querySelectorAll('.productEdit');
  var inputBoxesSubscriptions = document.querySelectorAll('.subscriptionEdit');
  var deleteProductBoxes = document.querySelectorAll('.deleteProducts');
  var deleteSubscriptionBoxes = document.querySelectorAll('.deleteSubscriptions');
  var button = document.querySelector('.addsAjax');
  var subTotal = document.querySelector('.totalFoSho');
  var productView = document.querySelectorAll('.productView');
  var subscriptionView = document.querySelectorAll('.subscriptionView');
  const cartedProducts = gon.cartedProducts
  const cartedSubscriptions = gon.cartedSubscriptions

  jQuery('<div class="quantity-nav"><div class="quantity-button quantity-up">+</div><div class="quantity-button quantity-down">-</div></div>').insertAfter('.quantity input');
  jQuery('.quantity').each(function() {
    var spinner = jQuery(this),
      input = spinner.find('input[type="number"]'),
      btnUp = spinner.find('.quantity-up'),
      btnDown = spinner.find('.quantity-down'),
      min = input.attr('min'),
      max = input.attr('max');

    btnUp.click(function() {
      var oldValue = parseFloat(input.val());
      if (oldValue >= max) {
        var newVal = oldValue;
      } else {
        var newVal = oldValue + 1;
      }
      spinner.find("input").val(newVal);
      spinner.find("input").trigger("change");
    });

    btnDown.click(function() {
      var oldValue = parseFloat(input.val());
      if (oldValue <= min) {
        var newVal = oldValue;
      } else {
        var newVal = oldValue - 1;
      }
      spinner.find("input").val(newVal);
      spinner.find("input").trigger("change");
    });
  });


  function grabProductAmount() {
    for (var i = 0; i < inputBoxesProducts.length; i++) {
      if (cartedProducts[i].id === parseInt(inputBoxesProducts[i].id.slice(2))) {
        cartedProducts[i].amount = inputBoxesProducts[i].value
        $.ajax({
          type: "PATCH",
          url: "/api/carted_products/" + cartedProducts[i].id + "/" + cartedProducts[i].amount,
          contentType: "application/json; charset=utf-8",
          dataType: "json",
          success: function(result) {
            if (result.error) {
              alert(result.error)
            }
          }
        })
      }
    }
  }

  function grabSubscriptionAmount() {
    for (var i = 0; i < inputBoxesSubscriptions.length; i++) {

      if (cartedSubscriptions[i].id === parseInt(inputBoxesSubscriptions[i].id.slice(2))) {
        cartedSubscriptions[i].amount = inputBoxesSubscriptions[i].value

        $.ajax({
          type: "PATCH",
          url: "/api/carted_subscriptions/" + cartedSubscriptions[i].id + "/" + cartedSubscriptions[i].amount,
          contentType: "application/json; charset=utf-8",
          dataType: "json",
          success: function(result) {
            if (result.error) {
              alert(result.error)
            }
          }
        })
      }
    }
  }

  function deleteProduct(){
    const id = this.id.slice(2);
    for(var i = 0; i<deleteProductBoxes.length;i++){
      if(parseInt(cartedProducts[i].id) === parseInt(id)){
        cartedProducts[i].quantity = 0;
        productView[i].style.display = 'none';
        subTotalView();
      }
    }
    $.ajax({
      type: "DELETE",
      url: "/api/carted_products/" + id,
      contentType: "application/json; charset=utf-8",
      dataType: "json"
    });
    }

    function deleteSubscription(){
      const id = this.id.slice(2);
      for(var i = 0; i<deleteSubscriptionBoxes.length;i++){
        if(parseInt(cartedSubscriptions[i].id) === parseInt(id)){
          cartedSubscriptions[i].quantity = 0;
          subscriptionView[i].style.display = 'none';
          subTotalView();
        }
      }
      $.ajax({
        type: "DELETE",
        url: "/api/carted_subscriptions/" + id,
        contentType: "application/json; charset=utf-8",
        dataType: "json"
      });
    }

    function subTotalView() {
      var itemsTotal = 0;
      for (var i = 0; i < cartedProducts.length; i++){
        itemsTotal = parseInt(cartedProducts[i].price * cartedProducts[i].quantity) + itemsTotal;
      }
      for (var i = 0; i < cartedSubscriptions.length; i++){
        itemsTotal = parseInt(cartedSubscriptions[i].amount * cartedSubscriptions[i].quantity) + itemsTotal;
      }
      subTotal.innerText= "Subtotal: $" + itemsTotal * 0.01;
      return "Subtotal: $" + itemsTotal * 0.01;
    }

    const quantityButtons = document.querySelectorAll('.quantity-nav');

    function updateQuantity(){
      var newQuantity = this.parentNode.firstChild.nextSibling.value
      for(var i = 0;i < cartedSubscriptions.length;i++){
        if(parseInt(this.parentNode.firstChild.nextSibling.id.slice(2)) === cartedSubscriptions[i].id){
          cartedSubscriptions[i].quantity = newQuantity;
        }
      }
      for(var i = 0;i < cartedProducts.length;i++){
        if(parseInt(this.parentNode.firstChild.nextSibling.id.slice(2)) === cartedProducts[i].id){
          cartedProducts[i].quantity = newQuantity;
        }
      }
      subTotalView();
    }

  for (var i = 0; i < deleteProductBoxes.length; i++){
    deleteProductBoxes[i].addEventListener('click', deleteProduct);
    inputBoxesProducts[i].addEventListener('blur',updateQuantity);
  }

  for (var i = 0; i < deleteSubscriptionBoxes.length; i++){
    deleteSubscriptionBoxes[i].addEventListener('click', deleteSubscription)
    inputBoxesSubscriptions[i].addEventListener('blur',updateQuantity);
  }

  for (var i = 0; i< quantityButtons.length; i++){
    quantityButtons[i].addEventListener('click',updateQuantity);
  }


  button.addEventListener('click', grabProductAmount);
  button.addEventListener('click', grabSubscriptionAmount);
  subTotal.innerText = subTotalView();


  })
