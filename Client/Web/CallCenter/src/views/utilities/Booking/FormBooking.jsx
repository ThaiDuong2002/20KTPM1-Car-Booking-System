import React from "react";

import { useState, useRef } from "react";
import { useSelector } from "react-redux";
import axios from "axios";
import axiosClient from "axiosConfig/axiosClient";
import CustomerHistoryBooking from "./CustomerHistoryBooking";
import MostlyVistedLocation from "./MostlyVistedLocation";
import { gridSpacing } from "store/constant";

//MUI
import { useTheme } from "@mui/material/styles";
import {
  Box,
  Button,
  TextField,
  Autocomplete,
  Grid,
  Divider,
  Card,
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableRow,
  IconButton,
  Typography,
} from "@mui/material";
import ScrollBar from "react-perfect-scrollbar";
import CheckIcon from "@mui/icons-material/Check";
import { PlaceOutlined, TourOutlined } from "@mui/icons-material";

// third party
import * as yup from "yup";
import { Formik } from "formik";

// project imports
// import useScriptRef from "hooks/useScriptRef";
import AnimateButton from "ui-component/extended/AnimateButton";
import { margin } from "@mui/system";
import { values } from "lodash";

const vehicleType = [
  { label: "Motor" },
  { label: "Car - 5 Capacity" },
  { label: "Car - 7 Capacity" },
  { label: "Car - 9 Capacity" },
];

const initialValues = {
  customerName: "Nguyen Van A",
  phoneNumber: "079590707",
  pickUpLocation: "",
  dropOffLocation: "",
  vehicleType: "",
};

const pickUpLocationCoordinate = {
  lat: null,
  log: null,
};

const dropOffLocationCoordinate = {
  lat: null,
  log: null,
};

const bookingSchema = yup.object().shape({
  phoneNumber: yup.string().max(20).required("Phone Number is required"),
});

const FormBooking = () => {
  const theme = useTheme();
  const [historyList, setHistoryList] = useState([]);
  const [mostlyLocationList, setMostlyLocationList] = useState([]);
  const [formValue, setFormValue] = useState(initialValues);

  const formikRef = useRef();
  const handlePickUpBtnClick = (object) => {
    console.log("Object: ", object);
    formikRef.current.setFieldValue("pickUpLocation", object.address);
  };
  const handleDestinationalBtnClick = () => {};
  const handleChooseLocationBtnClick = () => {};

  const handleFormSubmit = async (values) => {
    const postBody = {
      customerName: values.customerName,
      phoneNumber: values.phoneNumber,
      pickupLocation: {
        coordinate: {},
        address: values.pickUpLocation,
      },
      dropOffLocation: {
        coordinate: {},
        address: values.dropOffLocation,
      },
      vehicleType: values.vehicleType,
    };

    console.log("Form values: ", postBody);
    // try {
    //   const response = await axiosClient.post(
    //     "/bookings",
    //     JSON.stringify(values)
    //   );
    //   // Xử lý phản hồi từ API nếu cần
    //   console.log("Booking successful:", response.data);
    // } catch (error) {
    //   // Xử lý lỗi nếu gửi yêu cầu không thành công
    //   console.error("Error creating booking:", error);
    // }
  };

  const handlePhoneNumberChange = async (event) => {
    try {
      const phoneNumber = event.target.value;
      const historyListResponse = await axiosClient.get(
        `booking/history/${phoneNumber}`
      );
      const mostlyLocationlistResponse = await axiosClient.get(
        `booking/most_location/${phoneNumber}`
      );
      setHistoryList(historyListResponse.data.data);
      setMostlyLocationList(mostlyLocationlistResponse.data.data);
      console.log("History List: ", historyList);
      console.log("Mosyly List: " + mostlyLocationList);
    } catch (error) {
      console.log(error);
    }
    const newPhoneNumber = event.target.value;
    console.log("New Phone Number:", newPhoneNumber);
  };

  return (
    <>
      <Box>
        <Formik
          innerRef={formikRef}
          onSubmit={handleFormSubmit}
          initialValues={formValue}
          validationSchema={bookingSchema}
        >
          {({
            touched,
            values,
            errors,
            handleBlur,
            handleChange,
            handleSubmit,
            isSubmitting,
          }) => (
            <form onSubmit={handleSubmit}>
              {/* <Box
                display="grid"
                gap="30px"
                gridTemplateColumns="repeat(4, minmax(0, 1fr))"
                sx={{
                  "& > div": { gridColumn: "span 7" },
                }}
              > */}
              <Grid container spacing={gridSpacing}>
                <Grid item lg={4}>
                  <TextField
                    label="Customer Name"
                    onBlur={handleBlur}
                    onChange={handleChange}
                    value={values.customerName}
                    name="customerName"
                    error={
                      Boolean(touched.customerName) &&
                      Boolean(errors.customerName)
                    }
                    helperText={touched.customerName && errors.customerName}
                    fullWidth
                    sx={{
                      mb: "20px",
                    }}
                  />
                  <TextField
                    label="Phone Number"
                    onBlur={handleBlur}
                    // onChange={handleChange}
                    onChange={(event) => {
                      handleChange(event);
                      handlePhoneNumberChange(event); // Gọi hàm handlePhoneNumberChange
                    }}
                    value={values.phoneNumber}
                    name="phoneNumber"
                    error={
                      Boolean(touched.phoneNumber) &&
                      Boolean(errors.phoneNumber)
                    }
                    helperText={touched.phoneNumber && errors.phoneNumber}
                    fullWidth
                    sx={{
                      mb: "5px",
                    }}
                  />
                </Grid>
                <Grid item lg={4}>
                  <TextField
                    label="Pick Up Location"
                    onBlur={handleBlur}
                    onChange={handleChange}
                    value={values.pickUpLocation}
                    name="pickUpLocation"
                    error={
                      Boolean(touched.pickUpLocation) &&
                      Boolean(errors.pickUpLocation)
                    }
                    helperText={touched.pickUpLocation && errors.pickUpLocation}
                    fullWidth
                    sx={{
                      mb: "20px",
                    }}
                  />
                  <TextField
                    label="Drop Off Location"
                    onBlur={handleBlur}
                    onChange={handleChange}
                    value={values.dropOffLocation.address}
                    name="dropOffLocation"
                    error={
                      Boolean(touched.dropOffLocation) &&
                      Boolean(errors.dropOffLocation)
                    }
                    helperText={
                      touched.dropOffLocation && errors.dropOffLocation
                    }
                    fullWidth
                    sx={{
                      mb: "5px",
                    }}
                  />
                </Grid>
                <Grid item lg={4}>
                  <Autocomplete
                    disablePortal
                    id="combo-box-demo"
                    options={vehicleType}
                    value={values.vehicleType}
                    onChange={(event, newValue) => {
                      handleChange(event);
                      values.vehicleType = newValue; // Update Formik value for vehicleType
                    }}
                    // getOptionLabel={(option) => option.label}
                    sx={{ gridColumn: "span 4" }}
                    renderInput={(params) => (
                      <TextField {...params} label="Vehicle Type" />
                    )}
                  />
                </Grid>
                {/* </Box> */}
              </Grid>

              <Box sx={{ mt: 2, display: "flex", justifyContent: "center" }}>
                <AnimateButton>
                  <Button
                    disableElevation
                    fullWidth
                    size="large"
                    type="submit"
                    variant="contained"
                    color="secondary"
                  >
                    Submit Booking
                  </Button>
                </AnimateButton>
              </Box>
              <Grid item xs={12} sx={{ margin: 2 }}>
                <Divider />
              </Grid>
            </form>
          )}
        </Formik>
      </Box>
      <Grid container spacing={gridSpacing}>
        <Grid item lg={7}>
          {/* <CustomerHistoryBooking historyList={historyList} /> */}
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
                    {historyList.map((booking, index) => {
                      return (
                        <TableRow
                          hover
                          key={booking._id}
                          // onClick={() => handleTableRowClick(booking._id)}
                        >
                          <TableCell>{index + 1}</TableCell>
                          <TableCell>{booking?.createdAt}</TableCell>
                          <TableCell>
                            <Typography>
                              {booking.pickupLocation?.address}
                            </Typography>
                            <IconButton
                              onClick={() =>
                                handlePickUpBtnClick(booking.pickupLocation)
                              }
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
                              onClick={() =>
                                handlePickUpBtnClick(
                                  booking.destinationLocation
                                )
                              }
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
        </Grid>
        <Grid item lg={5}>
          <MostlyVistedLocation mostlyLocationList={mostlyLocationList} />
        </Grid>
      </Grid>
    </>
  );
};

export default FormBooking;
