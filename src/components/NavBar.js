import React from 'react'
import { NavLink } from 'react-router-dom'
import {
  AppBar,
  Toolbar,
  Button,
  Grid
} from '@material-ui/core'
import {menu} from '../_data'

const NavBar = () => {
  return (
    <div>
      <Grid container direction="row" justify="center" alignItems="center">
        <h1>Sports League</h1>
      </Grid>
      <AppBar position="static">
        <Toolbar>
          <Grid container direction="row" justify="center" alignItems="center">
            {
              menu.list.map( (item, key) => 
                (<Button key={key} component={NavLink} to={item.path} color="inherit">{item.name}</Button>) 
              )
            }
          </Grid>
        </Toolbar>
      </AppBar>
    </div >
  )
}

export default NavBar
