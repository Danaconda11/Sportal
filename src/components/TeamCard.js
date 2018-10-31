import React from 'react';
import Card from '@material-ui/core/Card';
import CardActionArea from '@material-ui/core/CardActionArea';
import CardActions from '@material-ui/core/CardActions';
import CardContent from '@material-ui/core/CardContent';
import Button from '@material-ui/core/Button';
import Typography from '@material-ui/core/Typography';
import { NavLink } from 'react-router-dom'
import Grow from '@material-ui/core/Grow'

export default class TeamCard extends React.Component {
  render() {
    return (
      <Grow in={true} timeout={{enter: this.props.delay}}>
        <Card>
          <CardActionArea>
            <CardContent>
              <Typography gutterBottom variant="h5" component="h2">
                {this.props.teamName}
              </Typography>
            </CardContent>
          </CardActionArea>
          <CardActions>
            <Button component={NavLink} to={`team/${this.props.teamId}`} size="large" color="primary">
              See Stats
            </Button>
          </CardActions>
        </Card>
      </Grow>
    )
  }
} 