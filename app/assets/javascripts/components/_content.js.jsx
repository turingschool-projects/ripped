var Content = React.createClass({
  getInitialState() {
    return { solutions: [] }
  },
  
  componentDidMount() {
    const userId = this.props.currentUser
    $.getJSON(`/api/v1/users/${userId}/solutions`, (response) => { this.setState({ solutions: response }) })
  },
  
  handleDelete(solution_id, id) {
    $.ajax({
      url: `/api/v1/solutions/${solution_id}/feedbacks/${id}`,
      type: 'PATCH',
      data: {feedback: {status: "read"} },
      success: () => {
        console.log("It worked!")
      }
    })
  },
  
  render(){
    var returnSolutions = this.state.solutions.map((solution) => {
      return(
      solution.feedbacks.map((feedback) => {
        return (
        <div key={feedback.id}>
          <li className="student-dropdown-item" >
            <a href={'/exercises/' + solution.exercise_id + '/solutions/' + feedback.solution_id } onClick={() => this.handleDelete(feedback.solution_id, feedback.id)}>Unread feedback: {feedback.comment}</a>
          </li>
        </div>
        )
      })
    )
    })

    return(
      <div>
        { returnSolutions }
      </div>
    )
  }
});