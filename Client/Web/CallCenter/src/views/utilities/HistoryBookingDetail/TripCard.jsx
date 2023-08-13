import React from "react";

// material-ui
import { styled, useTheme } from "@mui/material/styles";
import {
  Avatar,
  Box,
  Grid,
  Menu,
  MenuItem,
  Typography,
  Chip,
  Label,
  Card,
  SvgIcon,
} from "@mui/material";

import PlaceIcon from "@mui/icons-material/Place";
import CalendarMonthIcon from "@mui/icons-material/CalendarMonth";

// compononet import
import { gridSpacing } from "store/constant";
import MainCard from "ui-component/cards/MainCard";
import Status from "./Status";

const StyledProductImg = styled("img")({
  top: 0,
  width: "100%",
  height: "100%",
  objectFit: "cover",
  position: "absolute",
});

const statusMap = {
  pending: "warning",
  success: "success",
  refunded: "error",
};

const CardWrapper = styled(MainCard)(({ theme }) => ({
  backgroundColor: theme.palette.primary.dark,
  color: theme.palette.primary.light,
  overflow: "hidden",
  position: "relative",
  height: "50px",
  display: "flex",
  justifyContent: "center",
  "&:after": {
    content: '""',
    position: "absolute",
    width: 210,
    height: 210,
    background: `linear-gradient(210.04deg, ${theme.palette.primary[200]} -50.94%, rgba(144, 202, 249, 0) 83.49%)`,
    borderRadius: "50%",
    top: -30,
    right: -180,
  },
  "&:before": {
    content: '""',
    position: "absolute",
    width: 210,
    height: 210,
    background: `linear-gradient(140.9deg, ${theme.palette.primary[200]} -14.02%, rgba(144, 202, 249, 0) 77.58%)`,
    borderRadius: "50%",
    top: -160,
    right: -130,
  },
}));

const TripCard = () => {
  const theme = useTheme();
  const color = theme.palette.secondary.light;
  const gridSpacing = 2;
  return (
    <MainCard>
      <Grid
        container
        spacing={gridSpacing}
        sx={{
          display: "flex",
          alignItems: "center",
        }}
      >
        <Grid item lg={6}>
          <Typography align="left" variant="h4">
            About
          </Typography>
          <Typography align="left" variant="h1" sx={{ fontWeight: "bold" }}>
            Trip: ABC123
          </Typography>
          <Box sx={{ pt: "100%", position: "relative" }}>
            <StyledProductImg src="" />
          </Box>
        </Grid>
        <Grid item lg={6}>
          <Grid item lg={12}>
            <Typography align="left" variant="h5" sx={{ fontWeight: "bold" }}>
              From
            </Typography>
            <Card
              variant="outlined"
              sx={{
                width: "100%",
                height: "40px",
                alignItems: "center",
                justifyContent: "left",
                display: "flex",
              }}
            >
              <SvgIcon color="primary" fontSize="small">
                <PlaceIcon />
              </SvgIcon>
              24 Vu Ngoc Phan Street, Binh Thanh District, Ho Chi Minh City
            </Card>
          </Grid>

          <Grid item lg={12}>
            <Typography
              align="left"
              variant="h5"
              mt={2}
              sx={{ fontWeight: "bold" }}
            >
              To
            </Typography>
            <Card
              variant="outlined"
              sx={{
                width: "100%",
                height: "40px",
                alignItems: "center",
                justifyContent: "left",
                display: "flex",
              }}
            >
              <SvgIcon color="primary" fontSize="small">
                <PlaceIcon />
              </SvgIcon>
              227 Nguyen Van Cu Street, District 5, Ho Chi Minh City
            </Card>
          </Grid>

          <Grid container lg={12} mt={2} spacing={gridSpacing}>
            <Grid item lg={6}>
              <Typography align="left" variant="h5" sx={{ fontWeight: "bold" }}>
                Date
              </Typography>
              <Card
                variant="outlined"
                sx={{
                  width: "100%",
                  height: "40px",
                  alignItems: "center",
                  justifyContent: "center",
                  display: "flex",
                }}
              >
                <SvgIcon color="primary" fontSize="small">
                  <CalendarMonthIcon />
                </SvgIcon>
                09/09/2023
              </Card>
            </Grid>
            <Grid item lg={6}>
              <Typography align="left" variant="h5" sx={{ fontWeight: "bold" }}>
                Type
              </Typography>
              <Card
                variant="outlined"
                sx={{
                  width: "100%",
                  height: "40px",
                  alignItems: "center",
                  justifyContent: "center",
                  display: "flex",
                }}
              >
                Bike
              </Card>
            </Grid>
          </Grid>

          <Grid item lg={12} mt={2}>
            <Typography align="left" variant="h5" sx={{ fontWeight: "bold" }}>
              Trip Status
            </Typography>
            <CardWrapper border={false} content={false}>
              <Typography
                variant="h3"
                sx={{
                  color: "#fff",
                  justifyContent: "center",
                  alignItems: "center",
                  display: "flex",
                }}
              >
                Pending
              </Typography>
            </CardWrapper>
          </Grid>
        </Grid>
      </Grid>
    </MainCard>
  );
};

export default TripCard;
