var Order = React.createClass({
  getInitialState: function(){
    return {
      order: this.props.order.order,
      validShippingAddress: this.props.order.valid_shipping_address,
      customer: this.props.customer,
      initialShipping: true,
      shippingError: '',
      address: {
        first_name: this.props.customer.first_name || '',
        last_name: this.props.customer.last_name || '',
        address: this.props.customer.address || '',
        Address2: this.props.customer.Address2 || '',
        city: this.props.customer.city || '',
        state: this.props.customer.state || '',
        zip_code: this.props.customer.zip_code || '',
      }
    }
  },
  componentWillMount: function() {
    this.setState({
      shipping: this.state.initialShipping,
      address: this.state.address,
      shippingError: this.state.shippingError
    })
  },
  formatItem: function(){
    var listItems = [];
    this.state.order.items.map((item, index) => {
      if (item.type === "sku") {
        listItems.push(<li key={index + '-description'}><div className="OrderDetails">Product: {item.description}</div> </li>);
        listItems.push(<li key={index + '-quantity'}>Quantity: {item.quantity}</li>);
        listItems.push(<li key={index + '-amount'}>Amount: { (item.amount * 0.01).toLocaleString("en-US", {style: "currency", currency: "USD", minimumFractionDigits: 2})}</li>);
      } else if (item.type === "tax") {
        listItems.push(<li key={index + "-tax"}><div className="OrderDetails"> Tax: { (item.amount * 0.01).toLocaleString("en-US", {style: "currency", currency: "USD", minimumFractionDigits: 2})}</div> </li>);
      }
    });
    return listItems;
  },
  handleShippingChange: function(){
    this.setState({shipping: !this.state.shipping });
    console.log(this.state.shipping);
  },
  updateAddress: function() {
    var obj = {};
    obj = this.state.address;
    var that = this;
    $.ajax({
      type: "PATCH",
      url: "/api/customers/" + this.state.customer.id + '?page=order', 
      contentType: "application/json",
      dataType: "json", 
      data: JSON.stringify(obj),
      error: function(error){
        console.log(error);
        Materialize.toast('Shipping Information is Incomplete', 4000);
        that.setState({shippingError: 'inputError'});
      },
      success: function(response){
        console.log(response);
        that.setState({
          order: response.order,
          validShippingAddress: response.valid_shipping_address,
          shippingError: response.valid_shipping_address ? '' : 'inputError'
        });
        if (response.valid_shipping_address) {
          Materialize.toast('Shipping Information Saved and Validated', 4000);
        } else {
          Materialize.toast('Shipping Information Saved but NOT Validated', 4000);
        }
      }
    })
  },
  shippingCost: function(){
    let shippingCost = (_.last(this.state.order.items).amount * 0.01)
          .toLocaleString("en-US", {style: "currency", currency: "USD", minimumFractionDigits:2});
    return this.state.validShippingAddress ? shippingCost : shippingCost + ' (Estimated)'
  },
  handleChange: function(event) {
    var input = event.target.name,
        value = event.target.value,
        that = this;

    var updatedAddress = this.state.address;
        updatedAddress[input] = value;

    this.setState({address : updatedAddress});
  },
  render: function() {  
    return (
      <div className="row">
        <div className="col s5">
          <Address shipping={this.state.shipping}
                   address={this.state.address}
                   validate={this.state.shippingError}
                   handleChange={this.handleChange}
                   update={this.updateAddress} />
        </div>
        <div className="col s2">
        </div> 
        <div className="col s5 test">
          <div className="Checkout">
            <div className="OrderSummary">
              <div className="Title">Order Summary</div>
                <table>
                  <tr>
                    {this.formatItem()}
                  </tr>
                </table>
              </div>
            <div className="Toggle">
              <ShippingToggle shipping={this.state.shipping}
                              handleChange={this.handleShippingChange}
                              shippingAmount={this.shippingCost()} />
            </div>
          </div>
          <h5 className="left roboto-font gray">Total: </h5><div className="Total">
              { this.state.shipping ? 
              (this.state.order.amount * 0.01).toLocaleString("en-US", {style: "currency", currency: "USD", minimumFractionDigits:2}) : 
              ((this.state.order.amount - this.state.order.items[this.state.order.items.length - 1].amount) * 0.01).toLocaleString("en-US", {style: "currency", currency: "USD", minimumFractionDigits:2})
              }
          </div>
        </div>
      </div>
    )
  },
})

class ShippingToggle extends React.Component {
  render() {
    return (
      <div>
        <div onClick={this.props.handleChange}>
          {this.props.shipping ? 
            (<input id="shipping" type="radio" checked={true} readOnly={true} />) : 
            (<input id="shipping" type="radio" checked={false} readOnly={true} />)
          }
          <label for="shipping">Shipping: {this.props.shippingAmount} </label>
        </div>
        <div onClick={this.props.handleChange}>
          { this.props.shipping ? 
            (<input id="pickup" type="radio" checked={false} readOnly={true} />) :
            (<input id="pickup" type="radio" checked={true} readOnly={true} />)
          }
          <label for="pickup">Pick Up</label>
        </div>
      </div>
    )
  }
}