var Content = React.createClass({
  getInitialState() {
    return { solutions: [] }
  },
  
  componentDidMount() {
    $.getJSON('/api/v1/users/1/solutions/1/feedbacks.json', (response) => { this.setState({ skills: response }) });
  },
  
  handleDelete(){
    console.log('in delete');
  },
  
  render(){
    var feedbacks = this.state.solutions.map((solution) => {
      return (
        <div key={solution.id}>
          <h3>{solution}</h3>
          <button onClick={this.handleDelete}>X</button>
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