import React from "react";

import { format } from "date-fns";
import { useNavigate } from "react-router";
import {
  Avatar,
  Box,
  Card,
  Checkbox,
  Stack,
  Table,
  TableBody,
  TableCell,
  TableHead,
  TablePagination,
  TableRow,
  Typography,
} from "@mui/material";

import ScrollBar from "react-perfect-scrollbar";

const HistoryBookingTable = (props) => {
  const navigate = useNavigate();
  const { items = [] } = props;

  const handleTableRowClick = (bookingId) => {
    navigate(`/booking/${bookingId}`);
  };

  return (
    <Card>
      <ScrollBar>
        <Box sx={{ minWidth: 800 }}>
          <Table>
            <TableHead>
              <TableRow>
                <TableCell>ID</TableCell>
                <TableCell>Customer</TableCell>
                <TableCell>Date</TableCell>
                <TableCell>Vehicle Type</TableCell>
                <TableCell>Pick Up Location</TableCell>
                <TableCell>Destination Location</TableCell>
                <TableCell>Status</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {items.map((booking) => {
                return (
                  <TableRow
                    hover
                    key={booking._id}
                    onClick={() => handleTableRowClick(booking._id)}
                  >
                    <TableCell>{booking._id}</TableCell>
                    <TableCell>{booking?.bookingDate}</TableCell>
                    <TableCell>{booking.bookingUser?.fullName}</TableCell>

                    <TableCell>{booking.tripType}</TableCell>
                    <TableCell>{booking.pickUpLocation?.location}</TableCell>
                    <TableCell>
                      {booking.destinationLocation?.location}
                    </TableCell>
                    <TableCell>{booking.status}</TableCell>
                  </TableRow>
                );
              })}
            </TableBody>
          </Table>
        </Box>
      </ScrollBar>
    </Card>
  );
};

export default HistoryBookingTable;
