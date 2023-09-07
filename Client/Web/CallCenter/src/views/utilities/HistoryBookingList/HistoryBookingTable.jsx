import React, { useEffect, useState } from "react";

import axiosClient from "axiosConfig/axiosClient";
import { format } from "date-fns";
import { useNavigate } from "react-router";
import { useTheme } from "@mui/material/styles";
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
  const theme = useTheme();
  const navigate = useNavigate();
  const { items = [] } = props;

  const [data, setData] = useState([]);

  useEffect(() => {
    async function fetchData() {
      try {
        const response = await axiosClient.get("booking/history/0795907075");
        setData(response.data.data);
        console.log("Repponse: ", response.data.data);
      } catch (error) {
        console.log(error);
      }
    }
    fetchData();
  }, []);

  const handleTableRowClick = (bookingId) => {
    navigate(`/utils/history-booking/${bookingId}`, { state: bookingId });
  };

  return (
    <Card>
      <ScrollBar>
        <Box sx={{ minWidth: 800 }}>
          <Table>
            <TableHead
              sx={{
                backgroundColor: theme.palette.primary.light,
              }}
            >
              <TableRow>
                <TableCell
                  sx={{
                    fontWeight: "bold", // You can adjust the font weight as needed
                  }}
                >
                  ID
                </TableCell>
                <TableCell
                  sx={{
                    fontWeight: "bold", // You can adjust the font weight as needed
                  }}
                >
                  Booking Date
                </TableCell>
                <TableCell
                  sx={{
                    fontWeight: "bold", // You can adjust the font weight as needed
                  }}
                >
                  Customer
                </TableCell>
                <TableCell
                  sx={{
                    fontWeight: "bold", // You can adjust the font weight as needed
                  }}
                >
                  Vehicle Type
                </TableCell>
                <TableCell
                  sx={{
                    fontWeight: "bold", // You can adjust the font weight as needed
                  }}
                >
                  Pick Up Location
                </TableCell>
                <TableCell
                  sx={{
                    fontWeight: "bold", // You can adjust the font weight as needed
                  }}
                >
                  Destination Location
                </TableCell>
                <TableCell
                  sx={{
                    fontWeight: "bold", // You can adjust the font weight as needed
                  }}
                >
                  Status
                </TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {data.map((booking, index) => {
                return (
                  <TableRow
                    hover
                    key={booking._id}
                    onClick={() => handleTableRowClick(booking._id)}
                  >
                    <TableCell>{index + 1}</TableCell>
                    <TableCell>{booking?.createdAt}</TableCell>
                    <TableCell>{booking?.customerName}</TableCell>

                    <TableCell>{booking.type}</TableCell>
                    <TableCell>{booking.pickupLocation?.address}</TableCell>
                    <TableCell>
                      {booking.destinationLocation?.address}
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
