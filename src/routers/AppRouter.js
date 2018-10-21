import React from 'react';
import { BrowserRouter, Route, Switch} from 'react-router-dom';
import Home from '../components/Home.js'
import NotFound from '../components/NotFound.js'
import Header from '../components/Header'
import Teams from '../components/Teams'
import Players from '../components/Players'

const AppRouter = () => (
  <BrowserRouter>
    <div>
      <Header />
      <Switch>
        <Route exact={true} path="/" component={Home} />
        <Route exact={true} path="/teams" component={Teams} />
        <Route exact={true} path="/players" component={Players}/>
        <Route component={NotFound} />
      </Switch>
    </div>
  </BrowserRouter>
)

export default AppRouter