import React from 'react'
import ReactDOM from 'react-dom'
import AppRouter from './routers/AppRouter'
import 'normalize.css/normalize.css'
import './styles/styles.scss'
import { MuiThemeProvider } from '@material-ui/core/styles';
import MaterialTheme from './styles/MaterialTheme'

const App = () => (
  <MuiThemeProvider theme={MaterialTheme}>
    <AppRouter />
  </MuiThemeProvider>
)

ReactDOM.render(<App/>, document.getElementById('app'))
