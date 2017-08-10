var Order = React.createClass({
  getInitialState: function(){
    console.log(this.props.order)
    return {
       order: this.props.order
     }
  },
  componentWillMount: function(){
    this.setState({order: this.state.order})
  },
  render: function() {
      return (
        <div>
          <h3>Order Overview</h3>
          {this.state.order.items.map(item =>
                <div>
                  <p>{item.type}: {item.description}</p>
                  <p>Amount: {item.amount*0.01}</p>
                </div>
            )}

        <h3> Shipping </h3>
        {this.state.order.shipping_methods.map(shipping_method =>
          <div>
            <p>{shipping_method.description}</p>
            <p>{shipping_method.amount*0.01}</p>
            <p>{shipping_method.delivery_estimate.date}</p>
          </div>
        )}

      </div>
    )}
})
