export const Utility = {
  switchSort: (data, colIndex, order) => {
    return data.sort((a, b) => {
      let first = null
      let second = null
      let ord = 0

      if (typeof (a.data[colIndex].props) == 'undefined') {
        first = a.data[colIndex]
      } else {
        first = a.data[colIndex].props.player.name
      }

      if (typeof (b.data[colIndex].props) == 'undefined') {
        second = b.data[colIndex]
      } else {
        second = b.data[colIndex].props.player.name
      }

      ord = first.toString().localeCompare(second.toString())
      console.log(ord, 'order')
      return ord * (order === "desc" ? 1 : -1)
    })
  }
}