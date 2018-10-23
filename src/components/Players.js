import React from 'react'
import {Link} from 'react-router-dom'

export default class Players extends React.Component {
  render() {
    return (
      <div>
        <div>Players List</div>
        <Link to="/players/1">Player 1</Link>
        <Link to="/players/2">Player 2</Link>
        <Link to="/players/3">Player 3</Link>
      </div>
    )
  }
} 