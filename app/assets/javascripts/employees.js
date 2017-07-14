document.addEventListener("DOMContentLoaded", function(event) { 
  var app = new Vue({
    el: '#customer_search',
    data: {
      customers: [],
      errors: [],
      columns: ['id', 'email'],
      filterCustomerEmail: "",
    },
    computed: {
      filteredNames: function() {
        var lowerNameFilter = this.filterCustomerEmail.toLowerCase();
        var filtered = this.customers.filter(function(customer) {
          var lowerEmployee = customer.email;
          return (lowerEmployee.indexOf(lowerNameFilter) !== -1);
        });
        var sorted = filtered.sort(function(customer1, customer2) {
          return customer1.email.localeCompare(customer2.email);
        });
        return sorted;
      }
    },
    mounted: function() {
      $.get("/api/customers", function(customers) {
        this.customers = customers;
      }.bind(this));
    },
    methods: {
    }
  });
});
