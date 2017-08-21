var Cart = React.createClass({
  getInitialState: function(){
     return {
       initialCP: this.props.carted_products,
       initialPT: this.props.products_total,
       initialCS: this.props.carted_subscriptions,
       initialCT: this.props.cart_total
     }
  },
  componentWillMount: function(){
    this.setState({
      carted_products: this.state.initialCP,
      products_total: this.state.initialPT,
      carted_subscriptions: this.state.initialCS,
      cart_total: this.state.initialCT
    })
  },
  handleProductsEmpty: function() {
    this.setState({carted_products: []});
  },
  handleSubscriptionsEmpty: function() {
    this.setState({carted_subscriptions: []});
  },
  _renderCartedProducts: function(){
    if(this.state.carted_products.length !== 0) {
      return (
        <div>
          <h5 className="center">One Time Purchases</h5>
          <CartedProducts handleEmpty={this.handleProductsEmpty} cartedProducts={this.state.carted_products} productsTotal={this.state.products_total} />
        </div>
      )
    }
  },
  _renderCartedSubscriptions: function(){
    console.log("This is the subscriptions", this.state.carted_subscriptions);
    if(this.state.carted_subscriptions.length !== 0) {
      return (
        <div>
          <h5 className="center">Subscriptions</h5>
          <CartedSubscriptions handleEmpty={this.handleSubscriptionsEmpty} cartedSubscriptions={this.state.carted_subscriptions} subscriptionsTotal={this.state.subscriptions_total}/>
        </div>
      )
    }
  },
  _renderCartTotal: function() {
    if(this.state.carted_subscriptions.length !== 0 && this.state.carted_products.length !== 0) {
      return (
        <div>{this.state.cart_total}</div>
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
