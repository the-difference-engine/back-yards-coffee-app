class Address extends React.Component {
  render() {
    return (
      <div>
        {this.props.shipping ? ( 
          <form>
            <h4>Shipping Information</h4>
            <p>Shipping must be in the US</p>
            First Name:
            <input type="text" className={this.props.validate} defaultValue={this.props.address.first_name} onChange={this.props.handleChange} name="first_name" placeholder="First Name" /><br />
            Last Name:<br />
            <input type="text" className={this.props.validate} defaultValue={this.props.address.last_name} onChange={this.props.handleChange} name="last_name" placeholder="Last Name" /><br />
            Address:<br />
            <input type="text" className={this.props.validate} defaultValue={this.props.address.address} onChange={this.props.handleChange} name="address" placeholder="Address 1"/><br />
            <input type="text" className={this.props.validate} defaultValue={this.props.address.Address2} onChange={this.props.handleChange}name="Address2" placeholder="Address 2"/><br />
            City:<br />
            <input type="text" className={this.props.validate} defaultValue={this.props.address.city} onChange={this.props.handleChange} name="city" placeholder="City"/><br />
            State:<br />
            <input type="text" className={this.props.validate} defaultValue={this.props.address.state} onChange={this.props.handleChange} name="state" placeholder="State"/><br />
            Zip/Postal Code:<br />
            <input type="text" className={this.props.validate} defaultValue={this.props.address.zip} onChange={this.props.handleChange} name="zip_code" placeholder="Zip/Postal code"/><br />
            <input type="button" className={this.props.validate} defaultValue="Save Address" onClick={this.props.update} className="waves-effect btn" /><br />
          </form>
          ) : ( 
            <div> state.first_name, this.state.last_name, this.state.address, this.state.address2, this.state.city, this.state.state, this.state.zip}
              <h5> Pick up your freshly roasted coffee at Back of the Yards Coffee Co. located at <br /> 2059 W. 47th St, Chicago, IL. <br /> </h5> 
              <p>Please contact us at 312-487-2233 with any questions. </p>
            </div>
          )}
      </div>
    )
  }
}

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
        zip: this.props.customer.zip_code || '',
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
    obj['address'] = this.state.address;
    obj['order_id'] = this.state.order.id;
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