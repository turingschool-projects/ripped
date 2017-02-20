var Content = React.createClass({
  getInitialState() {
    return { solutions: [] }
  },
  
  componentDidMount() {
    $.getJSON('/api/v1/users/2/solutions', (response) => { this.setState({ solutions: response }) })
  },
  
  handleDelete(id) {
    // $.ajax({
    //   url: `/api/v1/solutions/${id}/feedbacks/`
    // })
  },
  
  render(){
    console.table(this.state.solutions[0])
    var feedbacks = this.state.solutions.map((solution) => {
      return (
        <div key={solution.id}>
          <li>
            <p>New comment on your solution for:</p>
            <p>{solution.exercise.name}</p>
            <button onClick={this.handleDelete.bind(this, solution.id)}>X</button>
          </li>
        </div>
      )
    });
    
    return(
      <div>
        { feedbacks }
      </div>
    )
  }
});