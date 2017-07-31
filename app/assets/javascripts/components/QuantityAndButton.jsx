var QntyBtn = React.createClass({
    getInitialState: function() {
        return { editing: false };
    },
    handleClick: function(event) {
        this.setState({editing: !this.state.editing});
    },
    render: function() {
        return (
                this.state.editing ? (
                    <td> 
                        <input type="text" name={this.props.item.id} defaultValue={this.props.item.quantity} />
                        <button type="button" onClick={this.handleClick}>Save</button> 
                    </td>
                ) : (
                    <td>{this.props.item.quantity}<button type="button" onClick={this.handleClick}>Edit</button></td>
                )
        );
    }
});