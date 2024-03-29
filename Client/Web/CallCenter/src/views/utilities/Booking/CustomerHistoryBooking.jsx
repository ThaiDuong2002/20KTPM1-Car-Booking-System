import React from "react";
import { useTheme } from "@mui/material/styles";
import CheckIcon from "@mui/icons-material/Check";

import { mockDataHistoryBooking } from "data/mockData";
import {
  Avatar,
  Box,
  Card,
  Stack,
  Table,
  TableBody,
  TableCell,
  TableHead,
  TablePagination,
  TableRow,
  Typography,
  Button,
  IconButton,
  Link,
  Grid,
  CardContent,
} from "@mui/material";
import ScrollBar from "react-perfect-scrollbar";
import { PlaceOutlined, TourOutlined } from "@mui/icons-material";

const CustomerHistoryBooking = (props) => {
  const theme = useTheme();
  // const { items = [] } = props;
  // const items = mockDataHistoryBooking;
  const items = props.historyList;

  const handlePickUpBtnClick = () => {};
  const handleDestinationalBtnClick = () => {};
  const handleChooseLocationBtnClick = () => {};

  return (
    <Card>
      <Typography
        variant="h3"
        ml="5"
        mt="5"
        mb="1"
        color={theme.palette.secondary.main}
        sx={{
          fontWeight: "bold",
        }}
      >
        History Booking
      </Typography>
      <ScrollBar>
        <Box sx={{ minWidth: 600 }}>
          <Table>
            <TableHead
              sx={{
                backgroundColor: theme.palette.primary.light,
              }}
            >
              <TableRow>
                <TableCell
                  sx={{
                    fontWeight: "bold",
                  }}
                >
                  ID
                </TableCell>
                <TableCell
                  sx={{
                    fontWeight: "bold",
                  }}
                >
                  Booking Date
                </TableCell>
                <TableCell
                  sx={{
                    fontWeight: "bold",
                  }}
                >
                  Pick Up Location
                </TableCell>
                <TableCell
                  sx={{
                    fontWeight: "bold",
                  }}
                >
                  Destination Location
                </TableCell>
                <TableCell
                  sx={{
                    fontWeight: "bold",
                  }}
                >
                  Vehicle Type
                </TableCell>
                <TableCell
                  sx={{
                    fontWeight: "bold",
                  }}
                >
                  Action
                </TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {items.map((booking, index) => {
                return (
                  <TableRow
                    hover
                    key={booking._id}
                    // onClick={() => handleTableRowClick(booking._id)}
                  >
                    <TableCell>{index + 1}</TableCell>
                    <TableCell>{booking?.createdAt}</TableCell>
                    <TableCell>
                      <Typography>{booking.pickupLocation?.address}</Typography>
                      <IconButton
                        onClick={() => handlePickUpBtnClick()}
                        target="_blank"
                        disableRipple
                        color="primary"
                        title="Select Pick Up Location"
                        sx={{
                          color: "text.primary",
                          bgcolor: "grey.100",
                        }}
                      >
                        <TourOutlined />
                      </IconButton>
                      <IconButton
                        onClick={() => handleDestinationalBtnClick()}
                        target="_blank"
                        disableRipple
                        color="primary"
                        title="Select Destinational Location"
                        sx={{
                          marginLeft: "5px",
                          color: "text.primary",
                          bgcolor: "grey.100",
                        }}
                      >
                        <PlaceOutlined />
                      </IconButton>
                    </TableCell>
                    <TableCell>
                      <Typography>
                        {booking.destinationLocation?.address}
                      </Typography>
                      <IconButton
                        hover
                        onClick={() => handlePickUpBtnClick()}
                        target="_blank"
                        disableRipple
                        color="primary"
                        title="Select Pick Up Location"
                        sx={{
                          color: "text.primary",
                          bgcolor: "grey.100",
                        }}
                      >
                        <TourOutlined />
                      </IconButton>
                      <IconButton
                        hover
                        onClick={() => handleDestinationalBtnClick()}
                        target="_blank"
                        disableRipple
                        color="primary"
                        title="Select Destinational Location"
                        sx={{
                          marginLeft: "5px",
                          color: "text.primary",
                          bgcolor: "grey.100",
                        }}
                      >
                        <PlaceOutlined />
                      </IconButton>
                    </TableCell>
                    <TableCell>{booking.type}</TableCell>
                    <TableCell>
                      <Button
                        onClick={() => handleChooseLocationBtnClick()}
                        variant="contained"
                        startIcon={<CheckIcon />}
                        size="small"
                      >
                        Choose Location
                      </Button>
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

export default CustomerHistoryBooking;
