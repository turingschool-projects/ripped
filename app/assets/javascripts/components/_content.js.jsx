var Content = React.createClass({
  getInitialState() {
    return { solutions: [] }
  },
  
  componentDidMount() {
    $.getJSON('/api/v1/users/2/solutions', (response) => { this.setState({ solutions: response }) })
  },
  
  handleDelete(id) {
    $.ajax({
      url: `/api/v1/solutions/${id}/feedbacks/`
    })
  },
  
  render(){
    var feedbacks = this.state.solutions.map((solution) => {
      var returnFeedbacks = 
      solution.feedbacks.map((feedback) => {
        return (
        <div key={feedback.id}>
          <li>
            <p>Unread feedback:</p>
            <p>{feedback.comment}</p>
            <button onClick={this.handleDelete.bind(this, feedback.id)}>X</button>
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