var Content = React.createClass({
  getInitialState() {
    return { solutions: [] }
  },
  
  componentDidMount() {
    $.getJSON('/api/v1/users/2/solutions', (response) => { this.setState({ solutions: response }) })
  },
  
  handleDelete(solution_id, id) {
    $.ajax({
      url: `/api/v1/solutions/${solution_id}/feedbacks/${id}`,
      type: 'PATCH',
      data: {feedback: {status: 'read'} },
      success: () => {
        this.removeNotificationFromDOM(id);
      }
    })
  },
  
  removeNotificationFromDOM(id) {
    var newNotifications = this.state.solutions.filter((solution) => {
      return solution.id != id;
    });
    
    this.setState({ solutions: newNotifications });
  },
  
  render(){
    var feedbacks = this.state.solutions.map((solution) => {
      var returnFeedbacks = 
      solution.feedbacks.map((feedback) => {
        return (
        <div key={feedback.id}>
          <li className="dropdown-item">
            <p>Unread feedback:</p>
            <a href={'/exercises/' + solution.exercise_id + '/solutions/' + feedback.solution_id } onClick={this.handleDelete.bind(this, feedback.solution_id, feedback.id)}>{feedback.comment}</a>
          </li>
        </div>
        )
      });
      return returnFeedbacks
    });
    
    return(
      <div>
        { feedbacks }
      </div>
    )
  }
});