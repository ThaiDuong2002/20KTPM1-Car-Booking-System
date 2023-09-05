import React from "react";

import { useState } from "react";
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
} from "@mui/material";

// third party
import * as yup from "yup";
import { Formik } from "formik";

// project imports
// import useScriptRef from "hooks/useScriptRef";
import AnimateButton from "ui-component/extended/AnimateButton";
import { margin } from "@mui/system";

const vehicleType = [
  { label: "Motor" },
  { label: "Car - 5 Capacity" },
  { label: "Car - 7 Capacity" },
  { label: "Car - 9 Capacity" },
];

const initialValues = {
  customerName: "",
  phoneNumber: "",
  pickUpLocation: "",
  dropOffLocation: "",
  vehicleType: "",
};

const bookingSchema = yup.object().shape({
  phoneNumber: yup.string().max(20).required("Phone Number is required"),
});

const FormBooking = () => {
  const theme = useTheme();
  // const scriptedRef = useScriptRef();
  const [historyList, setHistoryList] = useState([]);
  const [mostlyLocationList, setMostlyLocationList] = useState([]);

  const handleFormSubmit = async (values) => {
    console.log("Form values: ", values);
    try {
      const response = await axiosClient.post(
        "/bookings",
        JSON.stringify(values)
      );
      // Xử lý phản hồi từ API nếu cần
      console.log("Booking successful:", response.data);
    } catch (error) {
      // Xử lý lỗi nếu gửi yêu cầu không thành công
      console.error("Error creating booking:", error);
    }
  };

  const handlePhoneNumberChange = async (event) => {
    // try {
    //   const historyListResponse = await axiosClient.get(
    //     "book/history/0795907075"
    //   );
    //   const mostlyLocationlistResponse = await axiosClient.get(
    //     "book/mostly-location/0795907075"
    //   );
    //   setHistoryList(historyListResponse.data.data);
    //   setMostlyLocationList(mostlyLocationlistResponse.data.data);
    // } catch (error) {
    //   console.log(error);
    // }
    const newPhoneNumber = event.target.value;
    console.log("New Phone Number:", newPhoneNumber);
  };

  return (
    <>
      <Box>
        <Formik
          onSubmit={handleFormSubmit}
          initialValues={initialValues}
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
                    values={values.customerName}
                    name="customerName"
                    error={
                      Boolean(touched.customerName) &&
                      Boolean(errors.customerName)
                    }
                    helperText={touched.customerName && errors.customerName}
                    fullWidth
                    sx={{
                      mb: "5px",
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
                    values={values.phoneNumber}
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
                    values={values.pickUpLocation}
                    name="pickUpLocation"
                    error={
                      Boolean(touched.pickUpLocation) &&
                      Boolean(errors.pickUpLocation)
                    }
                    helperText={touched.pickUpLocation && errors.pickUpLocation}
                    fullWidth
                    sx={{
                      mb: "5px",
                    }}
                  />
                  <TextField
                    label="Drop Off Location"
                    onBlur={handleBlur}
                    onChange={handleChange}
                    values={values.dropOffLocation}
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
          <CustomerHistoryBooking />
        </Grid>
        <Grid item lg={5}>
          <MostlyVistedLocation />
        </Grid>
      </Grid>
    </>
  );
};

export default FormBooking;
