import React from "react";

// MUI
import { Box, Typography, Avatar } from "@mui/material";

// component import
import MainCard from "ui-component/cards/MainCard";

const DriverCard = (props) => {
  const bookingInfo = props.bookingInfo;
  return (
    <MainCard>
      <Typography align="left" gutterBottom variant="h2">
        Driver
      </Typography>

      <Box
        sx={{
          display: "flex",
          justifyContent: "center",
          pb: 3,
        }}
      >
        <Avatar
          src={bookingInfo.driverId.avatar}
          sx={{
            height: 80,
            mb: 2,
            width: 80,
          }}
        />
      </Box>

      <Typography align="center" variant="h5">
        Fullname: {bookingInfo.driverId.lastname}{" "}
        {bookingInfo.driverId.firstname}
      </Typography>
      <Typography align="center" variant="h5">
        Vehicle ID:
      </Typography>
      <Typography align="center" variant="h5">
        Phone Number: {bookingInfo.driverId.phone}
      </Typography>
    </MainCard>
  );
};

export default DriverCard;
