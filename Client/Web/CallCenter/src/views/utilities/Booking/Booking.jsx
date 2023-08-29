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

const Booking = () => {
  const theme = useTheme();
  return (
    <MainCard title="Create Booking">
      {/* <Box>
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
      </Box> */}

      <Box mt={2}>
        <FormBooking />
      </Box>
    </MainCard>
  );
};

export default Booking;
