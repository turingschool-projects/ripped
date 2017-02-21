var Notifications = React.createClass({
  render() {
    return (
      <div id="dropdown1" className="dropdown-content dropdown-custom" >
        <Content currentUser = {this.props.current_user.id} />
      </div>
    )
  }
});