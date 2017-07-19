var ListSearch = React.createClass({
  filterList: function(event){
    var updatedList = this.state.initialItems;
    updatedList = updatedList.filter(function(item){
      return item.email.toLowerCase().search(
        event.target.value.toLowerCase()) !== -1;
    });
    this.setState({items: updatedList});
  },
  getInitialState: function(){
     return {
       initialItems: this.props.customers,
       items: []
     }
  },
  componentWillMount: function(){
    this.setState({items: this.state.initialItems})
  },
  render: function(){
    return (
      <div className="filter-list">
        <input type="text" placeholder="Search" onChange={this.filterList}/>
      <Table items={this.state.items}/>
      </div>
    );
  }
});

var TableRow = React.createClass({
  render: function(){
    const{data} = this.props;
    const row = data.map((data) =>
      <tr className="row">
        <td className="col s3 center" key={data.id}>{data.id}</td>
        <td className="col s3 center" key={data.email}>{data.email}</td>
      </tr>
    );
    return (
      <span>{row}</span>
    );
  }
})

var Table = React.createClass({
  render: function(){
    console.log("logging this..", this.props)
    return (
      <table class="row s6">
        <thead>
          <tr className="row">
            <td isKey={true} dataField="id" className="col s3 center">ID</td>
            <td isKey={true} dataField="email" className="col s3 center">Email</td>
          </tr>
        </thead>
        <tbody>
          <TableRow data={this.props.items} />
        </tbody>
      </table>
    );
  }
});

React.render(<ListSearch/>, document.getElementById('mount-point'));