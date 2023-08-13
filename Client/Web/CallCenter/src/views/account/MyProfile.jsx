import React from "react";

import {
  Box,
  Container,
  Stack,
  Typography,
  Unstable_Grid2 as Grid,
} from "@mui/material";

import MainCard from "ui-component/cards/MainCard";
import { AccountProfile } from "ui-component/account/account-profile";
import { AccountProfileDetails } from "ui-component/account/account-profile-details";

const MyProfile = () => {
  return (
    <MainCard title="My Profile">
      <Container maxWidth="lg">
        <Stack spacing={3}>
          <div>
            <Grid container spacing={3}>
              <Grid xs={12} md={6} lg={4}>
                <AccountProfile />
              </Grid>
              <Grid xs={12} md={6} lg={8}>
                <AccountProfileDetails />
              </Grid>
            </Grid>
          </div>
        </Stack>
      </Container>
    </MainCard>
  );
};

export default MyProfile;
