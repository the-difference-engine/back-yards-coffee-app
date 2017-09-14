var CartedSubscriptions = React.createClass({
  getInitialState: function(){
     return {
       initialItems: this.props.cartedSubscriptions,
       carted_subscriptions: [],
       initialSubscriptionsTotal: this.props.subscriptionsTotal,
       isEmpty: false
     }
  },
  componentWillMount: function(){
    this.setState({carted_subscriptions: this.state.initialItems, subscriptions_total: this.state.initialSubscriptionsTotal, isEmpty: this.state.isEmpty})
  },
  calcTotal: function() {
    console.log("calculating total" + this.state.subscriptions_total);
    var total = 0;
    this.state.carted_subscriptions.forEach(function(carted_subscription) {
      console.log(carted_subscription);
      total += (carted_subscription.amount * carted_subscription.quantity);
    });
    console.log("FINISHED CALCULATING.." + total);
    this.setState({subscriptions_total: total});
    this.props.handleUpdate(total);
  },
  updateQuantity: function(val, id) {
    console.log(val, "from parent && id: ", id);
    var that = this;
    $.ajax({
      type: "PATCH",
      url: "/api/carted_subscriptions/" + id + "/" + val,
      contentType: "application/json; charset=utf-8",
      dataType: "json",
      success: function(result){
        if (result.error) {
          alert(result.error);
        } else {
          that.state.carted_subscriptions.map((el) =>
            (el.id == id) ? (
              el.quantity = parseInt(val)
            ) : (
              el
            )
          );
          console.log("update success");
          that.calcTotal();
          that.setState({carted_subscriptions: that.state.carted_subscriptions});
        }
      }
    });
  },
  deleteItem: function(id){
    this.state.carted_subscriptions = this.state.carted_subscriptions.filter((carted_subscription) =>
      carted_subscription.id !== id
    );
    var that = this;
    $.ajax({
      type: "DELETE",
      url: "/api/carted_subscriptions/" + id,
      contentType: "application/json; charset=utf-8",
      dataType: "json",
      success: function(result){
        console.log(result);
        that.isCartEmpty();
      }
    });
    this.setState({carted_subscriptions: this.state.carted_subscriptions});
  },
  isCartEmpty: function() {
    if (!(this.state.carted_subscriptions.length)) {
      this.setState({isEmpty: true});
      this.props.handleEmpty();
    }
  },
  render() {

    return (
      <div>
        <table className="table">
          <thead>
            <tr>
              <td> <b>ID</b> </td>
              <td> <b>PLAN ID</b> </td>
              <td> <b>UNIT PRICE</b> </td>
              <td> <b>QUANTITY</b> </td>
              <td> <b>TYPE</b> </td>
              <td> <b>TOTAL PRICE</b> </td>
            </tr>
          </thead>
          <tbody>
            {this.state.carted_subscriptions.map((carted_subscription, index) =>
              <tr key={carted_subscription.id}>
                <td>{ carted_subscription.id }</td>
                <td>{ carted_subscription.plan_id }</td>
                <td>{ (carted_subscription.amount * 0.01).toLocaleString("en-US", {style: "currency", currency: "USD", minimumFractionDigits: 2}) }</td>
                <QntyBtn handler={this.updateQuantity} key={index} item={carted_subscription} />
                <td>{ carted_subscription.grind }</td>
                <td>{ ((carted_subscription.amount * carted_subscription.quantity) * 0.01).toLocaleString("en-US", {style: "currency", currency: "USD", minimumFractionDigits: 2}) }</td>
                <DltBtn handler={this.deleteItem} key={carted_subscription.id} item={carted_subscription} />
              </tr>
            )}
          </tbody>
        </table>
        <hr/>
        <div id="cart-total">
          {this.state.isEmpty ? (
            <p className="center">Your subscriptions cart is empty. Shop for more coffee <a href="/products">here</a>!</p>
          ) : (
            <p className="right-align"><b>Total: </b>{(this.state.subscriptions_total * 0.01).toLocaleString("en-US", {style: "currency", currency: "USD", minimumFractionDigits: 2})}</p>
          )}
        </div>
      </div>
    )}
})
