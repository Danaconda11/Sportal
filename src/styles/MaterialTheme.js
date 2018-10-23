import { createMuiTheme } from '@material-ui/core/styles';

const theme = createMuiTheme({
  typography: {
    useNextVariants: true,
  },
  palette: {
    primary: {
      light: '#ffcd38',
      main: '#ffc107',
      dark: '#b28704',
      contrastText: '#fff',
    },
    secondary: {
      light: '#482880',
      main: '#673ab7',
      dark: '#8561c5',
      contrastText: '#000',
    },
  },
});

export default theme