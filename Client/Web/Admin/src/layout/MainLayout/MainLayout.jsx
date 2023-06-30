import React from "react";

// material-ui
import { styled, useTheme } from "@mui/material/styles";

// component imports
import { drawerWidth } from "../../store/constant";
import {
  AppBar,
  Box,
  CssBaseline,
  Toolbar,
  useMediaQuery,
} from "@mui/material";

import Header from "./Header/Header";

// styles

const MainLayout = () => {
  const theme = useTheme();
  return (
    <Box sx={{ display: "flex" }}>
      <CssBaseline />
      {/* header */}
      <AppBar
        enableColorOnDark
        position="fixed"
        color="inherit"
        elevation={0}
        sx={{
          bgcolor: theme.palette.background.default,
          transition: theme.transitions.create("width"),
        }}
      >
        <Toolbar>
          <Header />
        </Toolbar>
      </AppBar>
    </Box>
  );
};

export default MainLayout;
