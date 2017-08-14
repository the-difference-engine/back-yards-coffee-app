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
    var test = [];
    // return this.state.order.items.length;
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

   // for (i = 0, i < this.order.items.length, i = i + 1) {
    //   if (order.item.type === "sku") {
    //     object =  <h2>this is a sku</h2>;
    //   } else if {
    //     (order.item.type === "tax") {
    //       object =  <h2>this is tax</h2>;
    //     }
    //   }
    // }
  },

 render: function() {
      
   return (
      <div>
        <h3>Review your Order</h3>
        <ol>{this.formatItem()}</ol>
        
      </div>
    )
  }
})