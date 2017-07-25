var Table = React.createClass({
  render: function(){
    console.log("logging this..", this.props)
    return (
      <table>
        <thead>
          <tr className="row">
            <td key="id" className="col s6 center">ID</td>
            <td key="email" className="col s6 center">Email</td>
          </tr>
        </thead>
        <CSTableBody data={this.props.items} />
      </table>
    );
  }
});
