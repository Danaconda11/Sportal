import React from 'react'
import { teams } from '../_data'
import TeamCard from './TeamCard'
import {
  Grid
} from '@material-ui/core'

export default class Teams extends React.Component {
  render() {
    return (
      <div style={{ padding: 20 }}>
        <Grid container spacing={24}>
          {
            teams.list.map((item, key) =>
              (<Grid key={key} item xs>
                <TeamCard teamName={item.name} teamId={item.id} key={key} />
              </Grid>)
            )
          }
        </Grid>
      </div>
    )
  }
} 