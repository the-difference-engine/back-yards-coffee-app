var CartedProducts = React.createClass({
  getInitialState: function(){
     return {
       initialItems: this.props.carted_products,
       carted_products: [],
       initialCartTotal: this.props.cart_total
     }
  },
  componentWillMount: function(){
    this.setState({carted_products: this.state.initialItems, cart_total: this.state.initialCartTotal})
  },
  calcTotal: function() {
    console.log("calculating total" + this.state.cart_total);
    var total = 0;
    this.state.carted_products.forEach(function(carted_product) {
      console.log(carted_product);
      total += (carted_product.price * carted_product.quantity);
    });
    console.log("FINISHED CALCULATING.." + total);
    this.setState({cart_total: total});
  },
  updateQuantity: function(val, id) {
    console.log(val, "from parent && id: ", id);
    var that = this;
    $.ajax({
      type: "PATCH",
      url: "/api/carted_products/" + id + "/" + val,
      contentType: "application/json; charset=utf-8",
      dataType: "json",
      success: function(result, status){
        if (result.message) {
          console.log("update unsuccessful");
        } else {
          that.state.carted_products.map((el) =>
            (el.id == id) ? (
              el.quantity = parseInt(val)
            ) : (
              el
            )
          );
          console.log("update success");
          that.calcTotal();
          that.setState({carted_products: that.state.carted_products});
        }
      }
    });
  },
  deleteItem: function(id){
    this.state.carted_products = this.state.carted_products.filter((carted_product) =>
      carted_product.id !== id
    );
    $.ajax({
      type: "DELETE",
      url: "/api/carted_products/" + id,
      contentType: "application/json; charset=utf-8",
      dataType: "json",
      success: function(result){
        console.log(result);
      }
    });
    this.setState({carted_products: this.state.carted_products});
  },
  render() {

    return (
      <div>
        <table className="table">
          <thead>
            <tr>
              <td> <b>ID</b> </td>
              <td> <b>PRODUCT ID</b> </td>
              <td> <b>PRODUCT NAME</b> </td>
              <td> <b>UNIT PRICE</b> </td>
              <td> <b>QUANTITY</b> </td>
              <td> <b>SKU</b> </td>
              <td> <b>TOTAL PRICE</b> </td>
            </tr>
          </thead>
          <tbody>
            {this.state.carted_products.map((carted_product, index) =>
              <tr key={carted_product.id}>
                <td>{ carted_product.id }</td>
                <td>{ carted_product.product_id }</td>
                <td>{ carted_product.name }</td>
                <td>{ (carted_product.price * 0.01).toLocaleString("en-US", {style: "currency", currency: "USD", minimumFractionDigits: 2}) }</td>
                <QntyBtn handler={this.updateQuantity} key={index} item={carted_product} />
                <td>{ carted_product.sku }</td>
                <td>{ ((carted_product.price * carted_product.quantity) * 0.01).toLocaleString("en-US", {style: "currency", currency: "USD", minimumFractionDigits: 2}) }</td>
                <DltBtn handler={this.deleteItem} key={carted_product.id} item={carted_product} />
              </tr>
            )}
          </tbody>
        </table>
        <hr/>
        <div>
          <p><b>Total: </b>{(this.state.cart_total * 0.01).toLocaleString("en-US", {style: "currency", currency: "USD", minimumFractionDigits: 2})}</p>
        </div>
      </div>
    )}
})
