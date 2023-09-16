import React from "react";

import { useState, useRef } from "react";
import { useSelector } from "react-redux";
import axios from "axios";
import axiosClient from "axiosConfig/axiosClient";
import CustomerHistoryBooking from "./CustomerHistoryBooking";
import MostlyVistedLocation from "./MostlyVistedLocation";
import { gridSpacing } from "store/constant";
import { useNavigate } from "react-router";

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
  Modal,
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

const vehicleType = [{ label: "Motor" }, { label: "Car" }];

const initialValues = {
  customerName: "",
  phoneNumber: "",
  pickUpLocation: "",
  dropOffLocation: "",
  vehicleType: "",
};

const submit = {
  customerName: "",
  customerPhone: "",
  pickupLocation: {
    coordinate: null,
    address: "",
  },
  dropOffLocation: {
    coordinate: null,
    address: "",
  },
  type: "",
};

const initialCoordinateValue = {
  lat: null,
  log: null,
};

const bookingSchema = yup.object().shape({
  phoneNumber: yup.string().max(20).required("Phone Number is required"),
});

const style = {
  position: "absolute",
  top: "50%",
  left: "50%",
  transform: "translate(-50%, -50%)",
  width: 400,
  bgcolor: "background.paper",
  border: "2px solid #000",
  boxShadow: 24,
  p: 4,
};

const FormBooking = () => {
  //Modal
  const [open, setOpen] = React.useState(false);
  const handleOpen = () => setOpen(true);
  const handleClose = () => {
    setOpen(false);
    navigate("/utils/booking");
  };
  const navigate = useNavigate();

  const theme = useTheme();
  const [historyList, setHistoryList] = useState([]);
  const [mostlyLocationList, setMostlyLocationList] = useState([]);
  const [formValue, setFormValue] = useState(initialValues);
  const [pickUpLocationCoordinate, setPickUpLocationCoordinate] =
    useState(null);
  const [dropOffLocationCoordinate, setDropOffLocationCoordinate] =
    useState(null);

  const formikRef = useRef();
  const handlePickUpBtnClick = (object) => {
    console.log("Object: ", object);
    console.log("Object Coor: ", object.coordinate);
    formikRef.current.setFieldValue("pickUpLocation", object.address);
    setPickUpLocationCoordinate({
      lat: object.coordinate.lat,
      lng: object.coordinate.lng,
    });
  };
  const handleDestinationBtnClick = (object) => {
    formikRef.current.setFieldValue("dropOffLocation", object.address);
    setDropOffLocationCoordinate({
      lat: object.coordinate.lat,
      lng: object.coordinate.lng,
    });
  };
  const handleChooseLocationBtnClick = (object) => {
    formikRef.current.setFieldValue(
      "pickUpLocation",
      object.pickupLocation.address
    );
    formikRef.current.setFieldValue(
      "dropOffLocation",
      object.destinationLocation.address
    );
    setPickUpLocationCoordinate({
      lat: object.pickupLocation.coordinate.lat,
      lng: object.pickupLocation.coordinate.lng,
    });
    setDropOffLocationCoordinate({
      lat: object.destinationLocation.coordinate.lat,
      lng: object.destinationLocation.coordinate.lng,
    });
  };

  const handleFormSubmit = async (values) => {
    const postBody = {
      customerName: values.customerName,
      customerPhone: values.phoneNumber,
      pickupLocation: {
        coordinate: pickUpLocationCoordinate,
        address: values.pickUpLocation,
      },
      destinationLocation: {
        coordinate: dropOffLocationCoordinate,
        address: values.dropOffLocation,
      },
      type: values.vehicleType.label,
    };
    console.log("Pick Up Coordinate: ", { pickUpLocationCoordinate });
    console.log("Form values: ", postBody);
    try {
      const response = await axiosClient.post(
        "bookings/booking/consultant/",
        JSON.stringify(postBody)
      );
      setOpen(true);
      console.log("Booking successful:", response.data);
    } catch (error) {
      // Xử lý lỗi nếu gửi yêu cầu không thành công
      console.error("Error creating booking:", error);
    }
  };

  const handlePhoneNumberChange = async (event) => {
    try {
      const phoneNumber = event.target.value;
      const historyListResponse = await axiosClient.get(
        `bookings/booking/history/${phoneNumber}`
      );
      const mostlyLocationlistResponse = await axiosClient.get(
        `bookings/booking/most_location/${phoneNumber}`
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
                    value={values.dropOffLocation}
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
        {/* History Booking List */}
        <Grid item lg={7}>
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
                              onClick={() =>
                                handleDestinationBtnClick(
                                  booking.destinationLocation
                                )
                              }
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
                              hover
                              onClick={() =>
                                handleDestinationBtnClick(
                                  booking.destinationLocation
                                )
                              }
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
                              onClick={() =>
                                handleChooseLocationBtnClick(booking)
                              }
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
          {/* <MostlyVistedLocation mostlyLocationList={mostlyLocationList} /> */}
          <Card>
            <Typography
              variant="h3"
              ml="5"
              mt="5"
              mb="5"
              color={theme.palette.secondary.main}
              sx={{
                fontWeight: "bold",
              }}
            >
              Mostly Visted Location
            </Typography>
            <ScrollBar>
              <Box sx={{ minWidth: 400 }}>
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
                        Mostly Vesited Location
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
                    {mostlyLocationList.map((location, index) => {
                      return (
                        <TableRow hover key={index}>
                          <TableCell>{index + 1}</TableCell>
                          <TableCell>{location.address}</TableCell>
                          <TableCell>
                            <Button
                              onClick={() => handlePickUpBtnClick(location)}
                              variant="contained"
                              startIcon={<CheckIcon />}
                              size="small"
                            >
                              Pick Up
                            </Button>
                            <Button
                              onClick={() =>
                                handleDestinationBtnClick(location)
                              }
                              variant="contained"
                              startIcon={<CheckIcon />}
                              size="small"
                            >
                              Drop Off
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
      </Grid>
      <Modal
        open={open}
        onClose={handleClose}
        aria-labelledby="modal-modal-title"
        aria-describedby="modal-modal-description"
      >
        <Box sx={style} borderRadius={5}>
          <Typography
            id="modal-modal-title"
            variant="h3"
            component="h2"
            fontWeight={2}
          >
            Successful Reception
          </Typography>
          <Typography id="modal-modal-description" sx={{ mt: 2 }}>
            The vehicle booking request is currently being processed by the
            system.
          </Typography>
        </Box>
      </Modal>
    </>
  );
};

export default FormBooking;
