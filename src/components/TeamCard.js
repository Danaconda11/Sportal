import React from 'react';
import Card from '@material-ui/core/Card';
import CardActionArea from '@material-ui/core/CardActionArea';
import CardActions from '@material-ui/core/CardActions';
import CardContent from '@material-ui/core/CardContent';
import CardMedia from '@material-ui/core/CardMedia';
import Button from '@material-ui/core/Button';
import Typography from '@material-ui/core/Typography';
import {NavLink} from 'react-router-dom'

export default class TeamCard extends React.Component {
  render() {
    return (
      <Card>
        <CardActionArea>
          {/* <CardMedia
            component="img"
            alt="Contemplative Reptile"
            className={classes.media}
            height="140"
            image="/static/images/cards/contemplative-reptile.jpg"
            title="Contemplative Reptile"
          /> */}
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
    )
  }
} 