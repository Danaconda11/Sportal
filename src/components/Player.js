import React from 'react'

export default class Player extends React.Component {
  render() {
    return (
      <div>
        <div>Player {this.props.match.params.id} stats</div>
      </div>
    )
  }
} 