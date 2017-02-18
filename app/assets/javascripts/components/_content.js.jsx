var Content = React.createClass({
  componentDidMount() {
    $.getJSON('/api/v1/users/1/solutions/1/feedbacks.json', (response) => {console.table(response)});
  },
  
  render(){
    return (
      <div>
        <h1>Bing</h1>
      </div>
    )
  }
})