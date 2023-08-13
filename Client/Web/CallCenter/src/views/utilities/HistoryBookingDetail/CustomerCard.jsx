import React from "react";

// MUI
import { Box, Typography, Avatar } from "@mui/material";

// component import
import MainCard from "ui-component/cards/MainCard";

const CustomerCard = () => {
  return (
    <MainCard>
      <Typography align="left" gutterBottom variant="h2">
        Customer
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
        Fullname: Nguyen Vo Minh Tri
      </Typography>
      <Typography align="center" variant="h5">
        Gender: Male
      </Typography>
      <Typography align="center" variant="h5">
        Phone Number: 0111111111
      </Typography>
      <Typography align="center" variant="h5">
        Age: 22
      </Typography>
    </MainCard>
  );
};

export default CustomerCard;
