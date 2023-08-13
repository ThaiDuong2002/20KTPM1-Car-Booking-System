import React from "react";

import { useState } from "react";
import { useSelector } from "react-redux";

//MUI
import { useTheme } from "@mui/material/styles";
import {
  Box,
  Button,
  Checkbox,
  Divider,
  FormControl,
  FormControlLabel,
  FormHelperText,
  Grid,
  IconButton,
  InputAdornment,
  InputLabel,
  OutlinedInput,
  Stack,
  Typography,
  Radio,
  RadioGroup,
} from "@mui/material";

// third party
import * as Yup from "yup";
import { Formik } from "formik";

// project imports
import useScriptRef from "hooks/useScriptRef";
import AnimateButton from "ui-component/extended/AnimateButton";

const FormBooking = ({ ...others }) => {
  const theme = useTheme();
  const scriptedRef = useScriptRef();
  return (
    <>
      <Formik
        initialValues={{
          customerName: "",
          phoneNumber: "",
          pickUpLocation: "",
          dropoffLocation: "",
          submit: null,
        }}
        validationSchema={Yup.object().shape({
          phone: Yup.string().max(20).required("Phone Number is required"),
        })}
        onSubmit={async (values, { setErrors, setStatus, setSubmitting }) => {
          try {
            if (scriptedRef.current) {
              setStatus({ success: true });
              setSubmitting(false);
            }
          } catch (err) {
            console.error(err);
            if (scriptedRef.current) {
              setStatus({ success: false });
              setErrors({ submit: err.message });
              setSubmitting(false);
            }
          }
        }}
      >
        {({
          errors,
          handleBlur,
          handleChange,
          handleSubmit,
          isSubmitting,
          touched,
          values,
        }) => (
          <form noValidate onSubmit={handleSubmit} {...others}>
            <FormControl
              fullWidth
              error={Boolean(touched.customerName && errors.customerName)}
              sx={{ ...theme.typography.customInput }}
            >
              <InputLabel htmlFor="outlined-adornment-customer-name-booking">
                Customer Name
              </InputLabel>
              <OutlinedInput
                id="outlined-adornment-customer-name-booking"
                type="text"
                value={values.customerName}
                name="customerName"
                onBlur={handleBlur}
                onChange={handleChange}
                label="Customer Name"
                inputProps={{}}
              />
              {touched.customerName && errors.customerName && (
                <FormHelperText
                  error
                  id="standard-weight-helper-text-customer-name-booking"
                >
                  {errors.customerName}
                </FormHelperText>
              )}
            </FormControl>

            <FormControl
              fullWidth
              error={Boolean(touched.password && errors.password)}
              sx={{ ...theme.typography.customInput }}
            >
              <InputLabel htmlFor="outlined-adornment-pickup-location-booking">
                Phone Number
              </InputLabel>
              <OutlinedInput
                id="outlined-adornment-pickup-location-booking"
                type="text"
                value={values.phoneNumber}
                name="phoneNumber"
                onBlur={handleBlur}
                onChange={handleChange}
                label="Phone Number"
                inputProps={{}}
              />
              {touched.phoneNumber && errors.phoneNumber && (
                <FormHelperText
                  error
                  id="standard-weight-helper-text-pickup-location-booking"
                >
                  {errors.phoneNumber}
                </FormHelperText>
              )}
            </FormControl>

            <FormControl
              fullWidth
              error={Boolean(touched.password && errors.password)}
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
                inputProps={{}}
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
              error={Boolean(touched.password && errors.password)}
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
                inputProps={{}}
              />
              {touched.dropoffLocation && errors.dropoffLocation && (
                <FormHelperText
                  error
                  id="standard-weight-helper-text-dropoff-location-booking"
                >
                  {errors.dropoffLocation}
                </FormHelperText>
              )}

              <RadioGroup
                aria-labelledby="demo-radio-buttons-group-label"
                defaultValue="female"
                name="radio-buttons-group"
              >
                <FormControlLabel
                  value="female"
                  control={<Radio />}
                  label="Female"
                />
                <FormControlLabel
                  value="male"
                  control={<Radio />}
                  label="Male"
                />
              </RadioGroup>
            </FormControl>

            {errors.submit && (
              <Box sx={{ mt: 3 }}>
                <FormHelperText error>{errors.submit}</FormHelperText>
              </Box>
            )}

            <Box sx={{ mt: 2 }}>
              <AnimateButton>
                <Button
                  disableElevation
                  disabled={isSubmitting}
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
    </>
  );
};

export default FormBooking;
