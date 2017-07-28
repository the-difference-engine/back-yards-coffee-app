var CartedProducts = React.createClass({
  updateProducts: function(event){
    var updatedList = this.state.initialItems;
    updatedList = updatedList.filter(function(item){
      return item.email.toLowerCase().search(
        event.target.value.toLowerCase()) !== -1;
    });
    this.setState({carted_products: updatedList});
  },
  getInitialState: function(){
     return {
       initialItems: this.props.carted_products,
       carted_products: [],
       editing: false
     }
  },
  componentWillMount: function(){
    this.setState({carted_products: this.state.initialItems})
  },
  _edit: function(e){
    this.setState({editing: true});
    console.log("editing!!!");
  },
  _save: function(e){
    this.setState({editing: false});
    console.log("save!!");
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
            {this.state.carted_products.map((carted_product) =>
              <tr key={carted_product.id}>
                <td>{ carted_product.id }</td>
                <td>{ carted_product.product_id }</td>
                <td>{ carted_product.name }</td>
                <td>{ (carted_product.price * 0.01).toLocaleString("en-US", {style: "currency", currency: "USD", minimumFractionDigits: 2}) }</td>
                { this.state.editing ? (
                  <td><div> {carted_product.quantity } </div><button onClick={this._save}>save</button></td>
                ) : (
                  <td><div> {carted_product.quantity } </div><button onClick={this._edit}>edit</button></td>
                )}
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
})
