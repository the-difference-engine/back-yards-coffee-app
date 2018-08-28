$('.carted_subscriptions.edit').ready(function() {
  let cartedSubscriptions = gon.cartedSubscriptions;
  let deleteEvent = undefined;
  $('.subscriptionView .quantity-up').on('click', event => {
    cartedSubscriptions = subscriptionUp(cartedSubscriptions, event);
  });
  $('.subscriptionView .quantity-down').on('click', event => {
    deleteEvent = event;
    subscriptionEditDown(cartedSubscriptions, event);
  });
  $('.deleteSubscription').on('click', event => {
    deleteEvent = event;
    editDeleteSubscription();
  });
  $('#confirm-delete-subscription').on('click', event => {
    console.log('deleting');
    cartedSubscriptions = deleteSubscription(cartedSubscriptions, deleteEvent);
  });
  $('select').material_select();
});

const editDeleteSubscription = () => {
  $('#modal-alert').modal('open');
};

const subscriptionEditDown = (cartedSubscriptions, event) => {
  const id = getEventId(event);
  const quantity = getSpinnerInput(event);
  if (quantity === 1) {
    $('#modal-alert').modal('open');
  } else {
    subscriptionDown(cartedSubscriptions, event);
  }
};
