var QntyBtn = React.createClass({
    getInitialState: function() {
        return { editing: false };
    },
    handleEditing: function(){
        this.setState({editing: !this.state.editing});
    },
    handleClick: function(qnty, id, event) {
        this.props.handler(qnty, id);
        this.setState({editing: !this.state.editing});
    },
    render: function() {
        return (
                this.state.editing ? (
                    <td>
                        <input id={this.props.item.id} type="text" name={this.props.item.id} defaultValue={this.props.item.quantity} />
                        <button type="button" className="btn botyred" onClick={() => this.handleClick(document.getElementById(this.props.item.id).value, this.props.item.id)}>Save</button>
                    </td>
                ) : (
                    <td>{this.props.item.quantity}<button type="button" class="botyred" className="btn-floating" onClick={this.handleEditing}><i className="material-icons">edit</i></button></td>
                )
        );
    }
});
