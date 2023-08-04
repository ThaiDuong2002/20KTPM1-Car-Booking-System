import React from "react";
import MainCard from "ui-component/cards/MainCard";
import CustomerSearch from "./CustomerSearch";
import HistoryBookingTable from "./HistoryBookingTable";
import { mockDataHistoryBooking } from "data/mockData";

const HistoryBooking = () => {
  return (
    <>
      <MainCard title="History Booking">
        <CustomerSearch />
        <HistoryBookingTable items={mockDataHistoryBooking} />
      </MainCard>
    </>
  );
};

export default HistoryBooking;
