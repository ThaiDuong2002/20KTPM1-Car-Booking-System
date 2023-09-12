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
        <Card
          variant="outlined"
          sx={{
            width: "100%",
            height: "40px",
            alignItems: "center",
            justifyContent: "left",
            display: "flex",
            pl: "10px",
          }}
        >
          {bookingInfo.pickupTime}
        </Card>
        <Typography
          align="left"
          variant="h5"
          mt={2}
          sx={{
            fontWeight: "bold",
          }}
        >
          Drop Off Time
        </Typography>
        <Card
          variant="outlined"
          sx={{
            width: "100%",
            height: "40px",
            alignItems: "center",
            justifyContent: "left",
            display: "flex",
            pl: "10px",
          }}
        >
          {bookingInfo.dropOffTime}
        </Card>
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
                    VND {bookingInfo.preTotal}
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
                    -VND 20000
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
                    VND {bookingInfo.total}
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
                    {bookingInfo.paymentMethodId?.name}
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
