var CSTableBody = React.createClass({
  render() {
    const{data} = this.props;
    const row = data.map((data) =>
      <tr key={data.id} className="row">
        <td className="col s6 center">{data.id}</td>
        <td className="col s6 center">{data.email}</td>
      </tr>
    );
    return (
      <tbody>{row}</tbody>
    );
  }
})
