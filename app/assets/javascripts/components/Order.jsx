class Address extends React.Component {
  render() {
    return (
      <form>
        <h3>Shipping Information</h3>
        Name:<br />
        <input type="text" name="name" /><br />
        Address 1:<br />
        <input type="text" name="address1" /><br />
        Address 2:<br />
        <input type="text" name="address2" /><br />
        City:<br />
        <input type="text" name="city" /><br />
        Zip / Postal Code:<br />
        <input type="text" name="zip" /><br />
        <input type="submit" value="Submit" className="waves-effect btn" /><br />
      </form>
    )
  }
}

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

 render: function() {  
   return (
      <div>
        <h3>Review your Order</h3>
        <ol>{this.formatItem()}</ol>
        <h5>
          Total: {
            this.state.order.items.reduce(
              function(start, item) {
                return start + (item.amount * 0.01);
              }, 0).toLocaleString("en-US", {style: "currency", currency: "USD", minimumFractionDigits:2})
          }
        </h5>
        <Address /> 
      </div>
    )
  }
})