class Address extends React.Component {
  render() {
    return (
      <div>
        {this.props.shipping ? ( 
          <form>
            <h4>Shipping Information</h4>
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
            <input type="text" className={this.props.validate} defaultValue={this.props.address.zip_code} onChange={this.props.handleChange} name="zip_code" placeholder="Zip/Postal code"/><br />
            <input type="button" className={this.props.validate} defaultValue="Save Address" onClick={this.props.update} className="waves-effect btn" /><br />
          </form>
          ) : ( 
            <div> 
              <h5> Pick up your freshly roasted coffee at Back of the Yards Coffee Co. located at <br /> 2059 W. 47th St, Chicago, IL. <br /> </h5> 
              <p>Please contact us at 312-487-2233 with any questions. </p>
            </div>
          )}
      </div>
    )
  }
}