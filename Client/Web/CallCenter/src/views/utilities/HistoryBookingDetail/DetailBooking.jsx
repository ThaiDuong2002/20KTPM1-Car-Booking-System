import React from "react";
import { faker } from "@faker-js/faker";

// material ui import
import { Grid } from "@mui/material";

// component import
import SubCard from "ui-component/cards/SubCard";
import { gridSpacing } from "store/constant";
import TripCard from "./TripCard";
import PaymentCard from "./PaymentCard";
import DriverCard from "./DriverCard";
import CustomerCard from "./CustomerCard";
import Timeline from "./TimelineCard";
const DetailBooking = () => {
  return (
    <Grid container spacing={gridSpacing}>
      {/* Cột thứ nhất */}
      <Grid item lg={8}>
        {/* Dòng thứ nhất */}

        <Grid container spacing={gridSpacing}>
          <Grid item lg={12}>
            <TripCard />
          </Grid>

          {/* Dòng thứ hai */}
          <Grid item lg={12}>
            <Grid container spacing={gridSpacing}>
              <Grid item lg={6}>
                <DriverCard />
              </Grid>
              <Grid item lg={6}>
                <CustomerCard />
              </Grid>
            </Grid>
          </Grid>
        </Grid>
      </Grid>

      {/* Cột thứ hai */}
      <Grid item lg={4}>
        <PaymentCard />
      </Grid>
      <Grid item lg={4}>
        <Timeline
          title="Order Timeline"
          list={[...Array(5)].map((_, index) => ({
            id: 1,
            title: [
              "1983, orders, $4220",
              "12 Invoices have been paid",
              "Order #37745 from September",
              "New order placed #XF-2356",
              "New order placed #XF-2346",
            ][index],
            type: `order${index + 1}`,
            time: faker.date.past(),
          }))}
        />
      </Grid>
    </Grid>
  );
};

export default DetailBooking;
