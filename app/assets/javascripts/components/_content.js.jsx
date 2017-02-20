var Content = React.createClass({
  componentDidMount() {
    $.getJSON('/api/v1/users/2/solutions', (response) => { this.setState({ response }) })
    debugger
  },
  
  handleDelete() {
    console.log('in delete');
  },
  
  render(){
    // var feedbacks = this.state.solutions.map((solution) => {
    //   return (
    //     <div key={solution.id}>
    //       <li>
    //         <p>Comment on your solution for:</p>
    //         <p>{solution.exercise.name}</p>
    //         <button onClick={this.handleDelete}>X</button>
    //       </li>
    //     </div>
    //   )
    // });
    
    return(
      <div>
        Hey
      </div>
    )
  }
});