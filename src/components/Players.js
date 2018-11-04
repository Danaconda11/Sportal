import { Person } from '@material-ui/icons/'
import React from 'react'
import MUIDataTable from "mui-datatables"
import { players } from '../_data'
import { NavLink } from 'react-router-dom'
import { Utility } from '../components/Utils'

const IconLink = props => (
  <NavLink to={`player/${props.player.id}`}>
    <Person></Person>
  </NavLink>
)

export default class Players extends React.Component {
  render() {
    const columns = [
      {
        name: "Stats",
      }
      , "Name", "Goals", "Assists", "Points", "Penalty Mins"
    ]

    const data = players.list.map((player, key) => (
      [<IconLink key={key} player={player} />,
      player.name,
      player.goals,
      player.assists,
      player.points,
        "none"])
    )

    const tableConfig = {
      rowsPerPageOptions: [10, 25, 50],
      filterType: 'dropdown',
      selectableRows: false,
      print: false,
      download: false,
      customSort: Utility.switchSort
    }

    return (
      <MUIDataTable
        title={`Players - ${new Date().getFullYear()}`}
        data={data}
        columns={columns}
        options={tableConfig}
      />
    )
  }
} 