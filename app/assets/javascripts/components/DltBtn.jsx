var DltBtn = React.createClass({

  render: function(){
    return (
      <td>
        <button onClick={() => this.props.handler(this.props.item.id)} className="btn-floating"><i className="material-icons">delete</i></button>
      </td>);
  }
});