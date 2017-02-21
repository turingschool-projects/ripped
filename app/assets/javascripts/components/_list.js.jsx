var List = React.createClass({
  getInitialState() {
    return { uncommentedSolutions: [] }
  },
  
  componentDidMount() {
    $.getJSON('/api/v1/solutions', (response) => { this.setState({ uncommentedSolutions: response }) })
  },
  
  render() {
    var solutions = this.state.uncommentedSolutions.map((solution) => {
      return(
        <div key={solution.id}>
          <li className="dropdown-item">
            <p className="instructor-dropdown-item"><a href={'/exercises/' + solution.exercise_id + '/solutions/' + solution.id }>A solution to { solution.exercise.name } needs feedback.</a></p>
          </li>
        </div>
      )
    });
  
  return(
    <div>
      { solutions } 
    </div>
  )
}
});
