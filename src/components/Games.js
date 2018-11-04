import React from 'react'
import Button from '@material-ui/core/Button'
import MyModal from './MyModal'

export default class Games extends React.Component {
  state = {
    open: false
  }
  handleOpen = () => {
    this.setState({ open: true })
  }
  handleClose = () => {
    this.setState({ open: false })
  }
  render() {
    return (
      <div>
        <MyModal
          handleClose={this.handleClose}
          open={this.state.open} />
        <div>Games list</div>
        <Button onClick={this.handleOpen} >
          Add game
        </Button>
      </div>
    )
  }
} 