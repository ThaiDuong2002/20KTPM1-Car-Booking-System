import React from "react";

// mui
import { Grid, Typography, Box } from "@mui/material";
import { useTheme } from "@mui/material/styles";

// component import
import MainCard from "ui-component/cards/MainCard";
import FormBooking from "./FormBooking";
import { gridSpacing } from "store/constant";
import CustomerHistoryBooking from "./CustomerHistoryBooking";

//mock data
import { mockDataHistoryBooking } from "data/mockData";

const BookingModel = () => {
  const theme = useTheme();
  return (
    <MainCard title="BookingModel">
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
          Create BookingModel
        </Typography>
      </Box>
      <Grid container spacing={gridSpacing} mt={0.5}>
        <Grid item lg={8}>
          <Box>
            <FormBooking />
          </Box>
        </Grid>
      </Grid>
    </MainCard>
  );
};

export default BookingModel;
