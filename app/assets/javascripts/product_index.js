$(document).ready(function() {
  $('select').material_select();
  $('.tooltipped').tooltip({ delay: 5 });
  const addToCart = document.querySelectorAll('.add');

  function buyForm(event) {
    event.preventDefault();
    const thisProdId = this.id.slice(2);
    $.ajax({
      type: 'GET',
      url: `/products/${thisProdId}`,
      success: data => {
        $(this)
          .closest('.innercard')
          .html(data);
      },
      error: function() {}
    }).then(function() {
      $('select').material_select(); // Make sure materialize properly displays dropdowns
    });
  }

  $('.add').on('click', buyForm);
});
