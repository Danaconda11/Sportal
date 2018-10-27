import React from 'react'
import { BrowserRouter, Route, Switch } from 'react-router-dom';
import Home from '../components/Home'
import NotFound from '../components/NotFound'
import NavBar from '../components/NavBar'
import Teams from '../components/Teams'
import Team from '../components/Team'
import Players from '../components/Players'
import Player from '../components/Player'
import Games from '../components/Games'
import Contact from '../components/Contact'

const AppRouter = () => {
  return (
    <BrowserRouter>
      <div>
        <NavBar />
        <Switch>
          <Route exact={true} path="/" component={Home} />
          <Route exact={true} path="/teams" component={Teams} />
          <Route path="/team/:id" component={Team} />
          <Route exact={true} path="/players" component={Players} />
          <Route path="/player/:id" component={Player} />
          <Route exact={true} path="/games" component={Games} />
          <Route exact={true} path="/contact" component={Contact} />
          <Route component={NotFound} />
        </Switch>
      </div>
    </BrowserRouter>
  )
}

export default AppRouter