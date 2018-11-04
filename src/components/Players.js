import React from 'react'
import MUIDataTable from "mui-datatables"
import { players } from '../_data'
import { NavLink } from 'react-router-dom'
import { Utility } from '../components/Utils'

export default class Players extends React.Component {
  render() {
    const columns = [
      "Name", "Goals", "Assists", "Points", "Penalty Mins"
    ]

    const data = players.list.map((player, key) => (
      [
        <NavLink player={player} to={`/player/${player.id}`}>{player.name}</NavLink>,
        player.goals,
        player.assists,
        player.points,
        "none"
      ])
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
        title={`Players`}
        data={data}
        columns={columns}
        options={tableConfig}
      />
    )
  }
} 