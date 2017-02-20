var Content = React.createClass({
  getInitialState() {
    return { solutions: [] }
  },
  
  componentDidMount() {
    $.getJSON('/api/v1/users/2/solutions', (response) => { this.setState({ solutions: response }) })
  },
  
  handleDelete() {
    console.log('in delete');
  },
  
  render(){
    debugger
    var feedbacks = this.state.solutions.map((solution) => {
      return (
        <div key={solution.id}>
          <li>
            <p>Comment on your solution for:</p>
            <p>{solution.exercise.name}</p>
            <button onClick={this.handleDelete}>X</button>
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