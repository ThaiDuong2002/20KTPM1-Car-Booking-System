import React from "react";

// material UI
import { styled, useTheme } from "@mui/material/styles";
import { Grid, Typography, Box, Divider, Card } from "@mui/material";

//component import
import MainCard from "ui-component/cards/MainCard";

const CardWrapper = styled(MainCard)(({ theme }) => ({
  backgroundColor: theme.palette.primary.light,
  color: theme.palette.primary.light,
  overflow: "hidden",
  position: "relative",
  height: "50px",
  display: "flex",
  justifyContent: "center",
}));

const PaymentCard = (props) => {
  const theme = useTheme();
  const bookingInfo = props.bookingInfo;
  return (
    <MainCard>
      <Typography
        align="center"
        variant="h3"
        sx={{
          fontWeight: "bold",
        }}
      >
        Payment Details
      </Typography>

      <Box mt={2} mb={3}>
        <Typography
          align="left"
          variant="h5"
          mt={2}
          sx={{
            fontWeight: "bold",
          }}
        >
          Pick Up Time
        </Typography>
        <CardWrapper></CardWrapper>
        <Typography
          align="left"
          variant="h5"
          mt={2}
          sx={{
            fontWeight: "bold",
          }}
        >
          Pick Up Time
        </Typography>
        <CardWrapper></CardWrapper>
      </Box>
      <Divider sx={{ flexGrow: 1 }} orientation="horizontal" />
      <Box mt={3}>
        <Card sx={{ bgcolor: "secondary.light" }}>
          <Grid container sx={{ p: 2, pb: 2, color: "#fff" }}>
            <Grid item xs={12}>
              <Grid
                container
                alignItems="center"
                justifyContent="space-between"
              >
                <Grid item>
                  <Typography
                    variant="subtitle1"
                    sx={{
                      color: theme.palette.secondary.dark,
                      fontWeight: "bold",
                    }}
                  >
                    Charge
                  </Typography>
                </Grid>
                <Grid item>
                  <Typography
                    variant="h4"
                    sx={{ color: theme.palette.grey[800] }}
                  >
                    $1839.00
                  </Typography>
                </Grid>
              </Grid>
            </Grid>
            <Grid item xs={12}>
              <Grid
                container
                alignItems="center"
                justifyContent="space-between"
              >
                <Grid item>
                  <Typography
                    variant="subtitle1"
                    sx={{
                      color: theme.palette.secondary.dark,
                      fontWeight: "bold",
                    }}
                  >
                    Promotion
                  </Typography>
                </Grid>
                <Grid item>
                  <Typography
                    variant="h4"
                    sx={{ color: theme.palette.grey[800] }}
                  >
                    -$9.00
                  </Typography>
                </Grid>
              </Grid>
            </Grid>
            <Grid item xs={12}>
              <Grid
                container
                alignItems="center"
                justifyContent="space-between"
              >
                <Grid item>
                  <Typography
                    variant="subtitle1"
                    sx={{
                      color: theme.palette.secondary.dark,
                      fontWeight: "bold",
                    }}
                  >
                    Total Price
                  </Typography>
                </Grid>
                <Grid item>
                  <Typography
                    variant="h4"
                    sx={{ color: theme.palette.grey[800] }}
                  >
                    $1830.00
                  </Typography>
                </Grid>
              </Grid>
            </Grid>
            <Grid item xs="12">
              <Grid
                container
                alignItems="center"
                justifyContent="space-between"
              >
                <Grid item>
                  <Typography
                    variant="subtitle1"
                    sx={{
                      color: theme.palette.secondary.dark,
                      fontWeight: "bold",
                    }}
                  >
                    Payment Method
                  </Typography>
                </Grid>
                <Grid item>
                  <Typography
                    variant="h4"
                    sx={{ color: theme.palette.grey[800] }}
                  >
                    Momo
                  </Typography>
                </Grid>
              </Grid>
            </Grid>
          </Grid>
        </Card>
      </Box>
    </MainCard>
  );
};

export default PaymentCard;
