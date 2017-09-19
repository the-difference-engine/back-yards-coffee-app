var Cart = React.createClass({
  getInitialState: function(){
     return {
       initialCP: this.props.carted_products,
       initialPT: this.props.products_total,
       initialCS: this.props.carted_subscriptions,
       initialST: this.props.subscriptions_total,
       initialCT: this.props.cart_total
     }
  },
  componentWillMount: function(){
    this.setState({
      carted_products: this.state.initialCP,
      products_total: this.state.initialPT,
      carted_subscriptions: this.state.initialCS,
      subscriptions_total: this.state.initialST,
      cart_total: this.state.initialCT
    })
  },
  handleProductsEmpty: function() {
    this.setState({carted_products: []});
  },
  handleSubscriptionsEmpty: function() {
    this.setState({carted_subscriptions: []});
  },
  handleProductsUpdate: function(productsTotal) {
    this.setState({products_total: productsTotal});
    this.updateTotal();
  },
  handleSubscriptionsUpdate: function(subscriptionsTotal) {
    this.setState({subscriptions_total: subscriptionsTotal});
    this.updateTotal();
  },
  updateTotal: function(){
    total = (this.state.subscriptions_total + this.state.products_total);
    this.setState({cart_total: total});
  },
  _renderCartedProducts: function(){
    if(this.state.carted_products.length) {
      return (
        <div>
          <h5 className="center lobster-font gray">One Time Purchases</h5>
          <CartedProducts handleUpdate={this.handleProductsUpdate} handleEmpty={this.handleProductsEmpty} cartedProducts={this.state.carted_products} productsTotal={this.state.products_total} />
        </div>
      )
    }
  },
  _renderCartedSubscriptions: function(){
    console.log("This is the subscriptions", this.state.carted_subscriptions);
    if(this.state.carted_subscriptions.length) {
      return (
        <div>
          <h5 className="center">Subscriptions</h5>
          <CartedSubscriptions handleUpdate={this.handleSubscriptionsUpdate} handleEmpty={this.handleSubscriptionsEmpty} cartedSubscriptions={this.state.carted_subscriptions} subscriptionsTotal={this.state.subscriptions_total}/>
        </div>
      )
    }
  },
  _renderCartTotal: function() {
    if((this.state.carted_subscriptions.length) && (this.state.carted_products.length)) {
      return (
        <div><h5><b>OVERALL TOTAL:</b> {(this.state.cart_total * 0.01).toLocaleString("en-US", {style: "currency", currency: "USD", minimumFractionDigits: 2})}</h5></div>
      )
    }
  },
  render: function(){
    return (
      <div>
        {this._renderCartedProducts()}
        {this._renderCartedSubscriptions()}
        {this._renderCartTotal()}
      </div>
    );
  }
});
