class CartedProducts extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
       initialItems: this.props.carted_products,
       carted_products: []
     }
  }

  componentWillMount(){
    this.setState({carted_products: this.state.initialItems})
  }

  updateQuantity(val, id) {
    console.log(val, "from parent && id: ", id);
    // this.props.carted_products.map((carted_product) =>
    //   (carted_product.id == id) ? (
    //     carted_product.quantity = val
    //   ) : (
    //     carted_product
    //   )
    // );
    $.ajax({
      type: "PATCH",
      url: "/api/carted_products/" + id + "/" + val,
      contentType: "application/json; charset=utf-8",
      dataType: "json",
      success: function(result){
        console.log(result);
        this.setState({carted_products: this.state.carted_products});
      }.bind(this)
    });
  }

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
              </tr>
            )}
          </tbody>
        </table>
        <div>
        </div>
      </div>
    )}
}
