import React from 'react'
import { Link } from 'react-router-dom';

export default class NotFound extends React.Component {
  render() {
    return (
      <div>
        <div>404 - Page not found</div>
        <Link to="/">Home</Link>
      </div>
    )
  }
} 