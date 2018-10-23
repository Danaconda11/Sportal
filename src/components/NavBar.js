import React from 'react'
import { NavLink } from 'react-router-dom'
import AppBar from '@material-ui/core/AppBar'
import Toolbar from '@material-ui/core/Toolbar'
import Button from '@material-ui/core/Button'

const NavBar = () => {
  return (
    <div>
      <h1>Old Krocs</h1>
      <AppBar position="static">
        <Toolbar>
          <Button component={NavLink} to="/" color="secondary" >
            Home
              </Button>
          <Button component={NavLink} to="/teams" color="secondary" >
            Teams
              </Button>
          <Button component={NavLink} to="/players" color="secondary" >
            Players
              </Button>
          <Button component={NavLink} to="/games" color="secondary" >
            Games
              </Button>
        </Toolbar>
      </AppBar>
    </div>
  )
}

export default NavBar
