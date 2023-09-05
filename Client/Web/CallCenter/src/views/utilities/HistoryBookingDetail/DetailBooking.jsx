import React, { useEffect, useState } from "react";
import { faker } from "@faker-js/faker";
import axiosClient from "axiosConfig/axiosClient";

// material ui import
import { Grid } from "@mui/material";

// component import
import SubCard from "ui-component/cards/SubCard";
import { gridSpacing } from "store/constant";
import TripCard from "./TripCard";
import PaymentCard from "./PaymentCard";
import DriverCard from "./DriverCard";
import CustomerCard from "./CustomerCard";
import TimelineCard from "./TimelineCard";
const DetailBooking = () => {
  const [data, setData] = useState();

  useEffect(() => {
    async function fetchData() {
      try {
        const response = await axiosClient.post("book/history/detail", {
          params: {
            bookingId: 12345,
          },
        });
        setData(response.data.data);
        console.log("Repponse: ", response.data.data);
      } catch (error) {
        console.log(error);
      }
    }
  });
  return (
    <Grid container spacing={gridSpacing}>
      {/* Cột thứ nhất */}
      <Grid item lg={8}>
        {/* Dòng thứ nhất */}

        <Grid container spacing={gridSpacing}>
          <Grid item lg={12}>
            <TripCard bookingInfo={data} />
          </Grid>

          {/* Dòng thứ hai */}
          <Grid item lg={12}>
            <Grid container spacing={gridSpacing}>
              <Grid item lg={6}>
                <DriverCard bookingInfo={data} />
              </Grid>
              <Grid item lg={6}>
                <CustomerCard bookingInfo={data} />
              </Grid>
            </Grid>
          </Grid>
        </Grid>
      </Grid>

      {/* Cột thứ hai */}
      <Grid item lg={4}>
        <Grid container spacing={gridSpacing}>
          <Grid item lg={12}>
            <PaymentCard bookingInfo={data} />
          </Grid>
          <Grid item lg={12}>
            <TimelineCard
              title="Timeline"
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
      </Grid>
    </Grid>
  );
};

export default DetailBooking;
