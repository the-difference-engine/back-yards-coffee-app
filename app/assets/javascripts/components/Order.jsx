var Order = React.createClass({
  getInitialState: function(){
    return {
      order: this.props.order,
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
        listItems.push(<li key={index + '-description'}>{item.description}</li>);
        listItems.push(<li key={index + '-quantity'}>{item.quantity}</li>);
        listItems.push(<li key={index + '-amount'}>{ (item.amount * 0.01).toLocaleString("en-US", {style: "currency", currency: "USD", minimumFractionDigits: 2})}</li>);
      } else if (item.type === "tax") {
        listItems.push(<li key={index + "-tax"}>Tax: { item.amount} </li>);
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
      url: "/api/customers/" + this.state.customer.id, 
      contentType: "application/json",
      dataType: "json", 
      data: JSON.stringify(obj),
      error: function(error){
        console.log(error);
        Materialize.toast('Shipping Information is Incomplete', 4000);
        that.setState({shippingError: 'inputError'});
      },
      success: function(order){
        console.log(order);
        Materialize.toast('Shipping Information Saved', 4000);
        that.setState({order: order,
                        shippingError: ''});
      }
    })
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
          <Address shipping={this.state.shipping} address={this.state.address} validate={this.state.shippingError} handleChange={this.handleChange} update={this.updateAddress} />
        </div>
        <div className="col s2">
        </div> 
        <div className="col s5 test">
          <h4>Review your Order</h4>
          <ol>{this.formatItem()}</ol>
          <ShippingToggle shipping={this.state.shipping} handleChange={this.handleShippingChange} />
          <h5>
            Total: { this.state.shipping ? 
              (this.state.order.amount * 0.01).toLocaleString("en-US", {style: "currency", currency: "USD", minimumFractionDigits:2}) : 
              ((this.state.order.amount - this.state.order.items[this.state.order.items.length - 1].amount) * 0.01).toLocaleString("en-US", {style: "currency", currency: "USD", minimumFractionDigits:2})
            }
          </h5>
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
          <label for="shipping">Shipping</label>
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