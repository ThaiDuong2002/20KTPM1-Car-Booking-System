import React from "react";

import axiosClient from "axiosConfig/axiosClient";
import { useTheme } from "@mui/material/styles";

import ScrollBar from "react-perfect-scrollbar";
import { useNavigate } from "react-router";
import { useEffect, useState } from "react";
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

const LocatingList = () => {
  const theme = useTheme();
  const navigate = useNavigate();
  const [data, setData] = useState([]);

  useEffect(() => {
    async function fetchData() {
      try {
        const response = await axiosClient.get("");
        setData(response.data.data);
      } catch (error) {
        console.log(error);
      }
    }
    fetchData();
  }, []);

  const handleTableRowClicked = (object) => {
    navigate("/utils/locating-process/abc", { state: object });
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
                    onClick={() => handleTableRowClicked(booking)}
                  >
                    <TableCell>{index + 1}</TableCell>
                    <TableCell>{booking?.createdAt}</TableCell>
                    <TableCell>{booking?.customerName}</TableCell>

                    <TableCell>{booking.type}</TableCell>
                    <TableCell>{booking.pickupLocation?.address}</TableCell>
                    <TableCell>
                      {booking.destinationLocation?.address}
                    </TableCell>
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

export default LocatingList;
