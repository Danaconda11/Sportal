import React from 'react'
import MUIDataTable from 'mui-datatables'
import { teams } from '../_data'
import { NavLink } from 'react-router-dom'
import Timeline from '@material-ui/icons/Timeline'

const IconLink = props => (
  <NavLink to={`team/${props.team.id}`}>
    <Timeline></Timeline>
  </NavLink>
)

export default class Teams extends React.Component {
  render() {
    const columns = [
      {
        name: "Stats",
        options: {
          filter: false
        }
      },
      "Name", "Games", "Win", "Loss"]

    const data = teams.list.map((team, key) => (
      [<IconLink key={key} team={team} />, team.name, team.games, team.wins, team.losses])
    )

    const tableConfig = {
      rowsPerPageOptions: [10, 25, 50],
      filterType: 'dropdown',
      selectableRows: false,
      print: false,
      download: false
    }

    return (
      <MUIDataTable
        title={`Teams`}
        data={data}
        columns={columns}
        options={tableConfig}
      />
    )
  }
} 