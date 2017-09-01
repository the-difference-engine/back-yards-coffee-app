class Address extends React.Component {
  render() {
    return (
      <div>
        {this.props.shipping ? ( 
          <form>
            <h4>Shipping Information</h4>
            First Name:
            <input type="text" name="name" placeholder="First Name" /><br />
            Last Name:<br />
            <input type="text" name="name" placeholder="Last Name" /><br />
            Address:<br />
            <input type="text" name="address1" placeholder="Address 1"/><br />
            <input type="text" name="address2" placeholder="(Address 2)"/><br />
            City:<br />
            <input type="text" name="city" placeholder="City"/><br />
            Zip/Postal Code:<br />
            <input type="text" name="zip" placeholder="Zip/Postal code"/><br />
            <input type="button" value="Save Address" className="waves-effect btn" /><br />
          </form>
          ) : ( 
            <div> Go to store </div>
          )}
      </div>
    )
  }
}

var Order = React.createClass({
  getInitialState: function(){
    console.log(this.props.order)
    return {
       order: this.props.order,
       initialShipping: true
     }
  },
  componentWillMount: function() {
    this.setState({
      shipping: this.state.initialShipping
    })
  },
  formatItem: function(){
    const test = [];

    this.state.order.items.map((item) => {
      if (item.type === "sku") {
        test.push(<ul>{item.description}</ul>);
        test.push(<ul>{ (item.amount * 0.01).toLocaleString("en-US", {style: "currency", currency: "USD", minimumFractionDigits: 2})}</ul>);
      } else if (item.type === "tax") {
        test.push(<ul>Tax: { item.amount} </ul>);
      } // else {
      //   test.push(<ul>is a ship</ul>);
      // }
    });
    return test;
  },
  handleShippingChange: function(){
    this.setState({shipping: !this.state.shipping });
    console.log(this.state.shipping);
  },

 render: function() {  
   return (
      <div className="row">
        <div className="col s5">
          <Address shipping={this.state.shipping} />
        </div>
        <div className="col s2">
        </div> 
        <div className="col s5 test">
          <h4>Review your Order</h4>
          <ol>{this.formatItem()}</ol>
          <ShippingToggle shipping={this.state.shipping} handleChange={this.handleShippingChange} />
          <h5>
            Total: {
              this.state.order.items.reduce(
                function(start, item) {
                  return start + (item.amount * 0.01);
                }, 0).toLocaleString("en-US", {style: "currency", currency: "USD", minimumFractionDigits:2})
            }
          </h5>
        </div>
      </div>
    )
  }
})

class ShippingToggle extends React.Component {
  render() {
    return (
      <div>
        <div onClick={this.props.handleChange}>
          {this.props.shipping ? 
            (<input id="shipping" type="radio" checked={true} />) : 
            (<input id="shipping" type="radio" checked={false} />)
          }
          <label for="shipping">Shipping</label>
        </div>
        <div onClick={this.props.handleChange}>
          { this.props.shipping ? 
            (<input id="pickup" type="radio" checked={false} />) :
            (<input id="pickup" type="radio" checked={true} />)
          }
          <label for="pickup">Pick Up</label>
        </div>
      </div>
    )
  }
}