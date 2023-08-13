import React from "react";

// mui
import { Grid, Typography, Box } from "@mui/material";
import { useTheme } from "@mui/material/styles";

// component import
import MainCard from "ui-component/cards/MainCard";
import FormBooking from "./FormBooking";
import { gridSpacing } from "store/constant";

const Booking = () => {
  const theme = useTheme();
  return (
    <MainCard title="Booking">
      <Box>
        <Typography
          variant="h3"
          ml="3"
          mt="3"
          color={theme.palette.secondary.main}
          sx={{
            fontWeight: "bold",
          }}
        >
          Create Booking
        </Typography>
      </Box>
      <Grid container spacing={gridSpacing} lg={12} mt={0.5}>
        <Grid item lg={7}>
          <Box>
            <FormBooking />
          </Box>
        </Grid>
        <Grid item lg={5}>
          <Typography>Image</Typography>
        </Grid>
      </Grid>
    </MainCard>
  );
};

export default Booking;
