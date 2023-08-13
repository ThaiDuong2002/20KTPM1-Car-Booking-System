import React from "react";

// MUI
import { Box, Typography, Avatar } from "@mui/material";

// component import
import MainCard from "ui-component/cards/MainCard";

const DriverCard = () => {
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
          src=""
          sx={{
            height: 80,
            mb: 2,
            width: 80,
          }}
        />
      </Box>

      <Typography align="center" variant="h5">
        Fullname: Nguyen Van A
      </Typography>
      <Typography align="center" variant="h5">
        Vehicle ID: 59A - 12345
      </Typography>
      <Typography align="center" variant="h5">
        Phone Number: 0123456789
      </Typography>
      <Typography align="center" variant="h5">
        Age: 40
      </Typography>
    </MainCard>
  );
};

export default DriverCard;
