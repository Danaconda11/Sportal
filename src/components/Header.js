import React from 'react'
import { NavLink } from 'react-router-dom';

export default class Header extends React.Component {
  render() {
    return (
      <div>
        <h1>Old Krocs</h1>
        <NavLink exact={true} to="/" activeClassName="is-active">Home</NavLink>
        <NavLink exact={true} to="/teams" activeClassName="is-active">Teams</NavLink>
        <NavLink exact={true} to="/players" activeClassName="is-active">Players</NavLink>
      </div>
    )
  }
}

