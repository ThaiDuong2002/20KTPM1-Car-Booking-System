import React from "react";

import { useState } from "react";
import { useSelector } from "react-redux";
import axios from "axios";

//MUI
import { useTheme } from "@mui/material/styles";
import {
  Box,
  Button,
  FormControl,
  FormHelperText,
  InputLabel,
  OutlinedInput,
  TextField,
  Autocomplete,
} from "@mui/material";

// third party
import * as yup from "yup";
import { Formik } from "formik";

// project imports
// import useScriptRef from "hooks/useScriptRef";
import AnimateButton from "ui-component/extended/AnimateButton";

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

  const handleFormSubmit = (values) => {
    console.log("Form values: ", values);
  };

  return (
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
          <Box
            display="grid"
            gap="30px"
            gridTemplateColumns="repeat(4, minmax(0, 1fr))"
            sx={{
              "& > div": { gridColumn: "span 4" },
            }}
          >
            <TextField
              label="Customer Name"
              onBlur={handleBlur}
              onChange={handleChange}
              values={values.customerName}
              name="customerName"
              error={
                Boolean(touched.customerName) && Boolean(errors.customerName)
              }
              helperText={touched.customerName && errors.customerName}
              sx={{ gridColumn: "span 6" }}
            />
            <TextField
              label="Phone Number"
              onBlur={handleBlur}
              onChange={handleChange}
              values={values.phoneNumber}
              name="phoneNumber"
              error={
                Boolean(touched.phoneNumber) && Boolean(errors.phoneNumber)
              }
              helperText={touched.phoneNumber && errors.phoneNumber}
              sx={{ gridColumn: "span 6" }}
            />
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
              sx={{ gridColumn: "span 6" }}
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
              helperText={touched.dropOffLocation && errors.dropOffLocation}
              sx={{ gridColumn: "span 6" }}
            />
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
          </Box>

          {/* <FormControl
            fullWidth
            error={Boolean(touched.phoneNumber && errors.phoneNumber)}
            sx={{ ...theme.typography.customInput }}
          >
            <InputLabel htmlFor="outlined-adornment-phone_number-booking">
              Phone Number
            </InputLabel>
            <OutlinedInput
              id="outlined-adornment-phone_number-booking"
              type="text"
              value={values.phoneNumber}
              name="phoneNumber"
              onBlur={handleBlur}
              onChange={handleChange}
              label="Phone Number"
            />
            {touched.phoneNumber && errors.phoneNumber && (
              <FormHelperText
                error
                id="standard-weight-helper-text-phone-number-booking"
              >
                {errors.phoneNumber}
              </FormHelperText>
            )}
          </FormControl>

          <FormControl
            fullWidth
            error={Boolean(touched.pickUpLocation && errors.pickUpLocation)}
            sx={{ ...theme.typography.customInput }}
          >
            <InputLabel htmlFor="outlined-adornment-pickup-location-booking">
              Fick Up Location
            </InputLabel>
            <OutlinedInput
              id="outlined-adornment-pickup-location-booking"
              type="text"
              value={values.pickUpLocation}
              name="pickUpLocation"
              onBlur={handleBlur}
              onChange={handleChange}
              label="Pick Up Location "
            />
            {touched.pickUpLocation && errors.pickUpLocation && (
              <FormHelperText
                error
                id="standard-weight-helper-text-pickup-location-booking"
              >
                {errors.pickUpLocation}
              </FormHelperText>
            )}
          </FormControl>

          <FormControl
            fullWidth
            error={Boolean(touched.dropOffLocation && errors.dropOffLocation)}
            sx={{ ...theme.typography.customInput }}
          >
            <InputLabel htmlFor="outlined-adornment-dropoff-location-booking">
              Drop Off Location
            </InputLabel>
            <OutlinedInput
              id="outlined-adornment-dropoff-location-booking"
              type="text"
              value={values.dropoffLocation}
              name="dropoffLocation"
              onBlur={handleBlur}
              onChange={handleChange}
              label="Drop Off Location "
            />
            {touched.dropoffLocation && errors.dropoffLocation && (
              <FormHelperText
                error
                id="standard-weight-helper-text-dropoff-location-booking"
              >
                {errors.dropoffLocation}
              </FormHelperText>
            )}
          </FormControl>

          {errors.submit && (
            <Box sx={{ mt: 3 }}>
              <FormHelperText error>{errors.submit}</FormHelperText>
            </Box>
          )} */}

          <Box sx={{ mt: 2 }}>
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
        </form>
      )}
    </Formik>
  );
};

export default FormBooking;
