import React from 'react'
import MUIDataTable from 'mui-datatables'
import { teams } from '../_data'
import { NavLink } from 'react-router-dom'

export default class Teams extends React.Component {
  render() {
    const columns = [
      {
        name: "Name",
        options: {
          filter: false
        }
      }, 
      "Games", "Win", "Loss"]

    const data = teams.list.map((team, key) => (
      [<NavLink to={`team/${team.id}`}>{team.name}</NavLink>, 
      team.games, team.wins, team.losses])
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