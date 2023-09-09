import React from "react";

import axiosClient from "axiosConfig/axiosClient";
import { useTheme } from "@mui/material/styles";
import { useEffect, useState, useMemo, useRef } from "react";
import { useLocation } from "react-router-dom";

import MainCard from "ui-component/cards/MainCard";
import { Grid, Typography, SvgIcon, Card, Box, Button } from "@mui/material";
import { gridSpacing } from "store/constant";
import PlaceIcon from "@mui/icons-material/Place";
import NearMeIcon from "@mui/icons-material/NearMe";
import TimerIcon from "@mui/icons-material/Timer";
import AnimateButton from "ui-component/extended/AnimateButton";

import {
  GoogleMap,
  useLoadScript,
  Marker,
  DirectionsRenderer,
} from "@react-google-maps/api";

const LocatingProcess = () => {
  const location = useLocation();
  const { state: object } = location;
  const objectBooking = object;
  const center = useMemo(() => ({ lat: 44, lng: -80 }), []);

  const [map, setMap] = useState(/** @type google.maps.Map */ (null));
  /** @type React.MutableRefObject<HTMLInputElement> */
  const originRef = useRef();
  /** @type React.MutableRefObject<HTMLInputElement> */
  const destinationRef = useRef();
  const [directionsResponse, setDirectionsResponse] = useState(null);
  const [distance, setDistance] = useState("");
  const [duration, setDuration] = useState("");

  const { isLoaded } = useLoadScript({
    // googleMapsApiKey: "AIzaSyDFoSXIW5NU-Znq3muefbeV96tCzzm9YVI",
  });

  async function calculateRoute() {
    // if (originRef.current.value === "" || destinationRef.current.value === "") {
    //   return;
    // }
    try {
      // eslint-disable-next-line no-undef
      const directionsService = new google.maps.DirectionsService();
      const results = await directionsService.route({
        // origin: originRef.current.value,
        // destination: destinationRef.current.value,
        origin: "vincom Đồng Khởi",
        destination: "Landmark 81",
        // eslint-disable-next-line no-undef
        travelMode: google.maps.TravelMode.DRIVING,
      });

      setDirectionsResponse(results);
      setDistance(results.routes[0].legs[0].distance.text);
      setDuration(results.routes[0].legs[0].duration.text);
    } catch (error) {
      console.error("Error calculating route:", error);
    }
  }

  return (
    <MainCard title="Locating Process">
      <Grid container spacing={gridSpacing}>
        <Grid item lg={4}>
          <Grid container spacing={gridSpacing}>
            <Grid item lg={11}>
              <Typography align="left" variant="h4">
                About
              </Typography>
              <Typography align="left" variant="h3" sx={{ fontWeight: "bold" }}>
                Trip: ABC123
              </Typography>
            </Grid>
            <Grid item lg={12}>
              <Typography align="left" variant="h5" sx={{ fontWeight: "bold" }}>
                Pick Up Location
              </Typography>
              <Card
                variant="outlined"
                sx={{
                  width: "100%",
                  height: "40px",
                  alignItems: "center",
                  justifyContent: "left",
                  display: "flex",
                }}
              >
                <SvgIcon color="primary" fontSize="small">
                  <PlaceIcon />
                </SvgIcon>
                abc
              </Card>
            </Grid>
            <Grid item lg={12}>
              <Typography align="left" variant="h5" sx={{ fontWeight: "bold" }}>
                Drop Off Location
              </Typography>
              <Card
                variant="outlined"
                sx={{
                  width: "100%",
                  height: "40px",
                  alignItems: "center",
                  justifyContent: "left",
                  display: "flex",
                }}
              >
                <SvgIcon color="primary" fontSize="small">
                  <PlaceIcon />
                </SvgIcon>
                abc
              </Card>
            </Grid>
            {distance ? (
              <Grid item lg={12}>
                <Typography
                  align="left"
                  variant="h5"
                  sx={{ fontWeight: "bold" }}
                >
                  Distance
                </Typography>
                <Card
                  variant="outlined"
                  sx={{
                    width: "60%",
                    height: "40px",
                    alignItems: "center",
                    justifyContent: "left",
                    display: "flex",
                  }}
                >
                  <SvgIcon color="primary" fontSize="small">
                    <NearMeIcon />
                  </SvgIcon>
                  {distance}
                </Card>
              </Grid>
            ) : (
              <Typography></Typography>
            )}
            {duration ? (
              <Grid item lg={12}>
                <Typography
                  align="left"
                  variant="h5"
                  sx={{ fontWeight: "bold" }}
                >
                  Estimate Time
                </Typography>
                <Card
                  variant="outlined"
                  sx={{
                    width: "60%",
                    height: "40px",
                    alignItems: "center",
                    justifyContent: "left",
                    display: "flex",
                  }}
                >
                  <SvgIcon color="primary" fontSize="small">
                    <TimerIcon />
                  </SvgIcon>
                  {duration}
                </Card>
              </Grid>
            ) : (
              <Typography></Typography>
            )}
            <Grid item lg={6}>
              <Box sx={{ mt: 2, display: "flex", justifyContent: "center" }}>
                <AnimateButton>
                  <Button
                    disableElevation
                    fullWidth
                    size="large"
                    onClick={calculateRoute}
                    variant="contained"
                    color="secondary"
                  >
                    Locating
                  </Button>
                </AnimateButton>
              </Box>
            </Grid>
            <Grid item lg={6}>
              <Box sx={{ mt: 2, display: "flex", justifyContent: "center" }}>
                <AnimateButton>
                  <Button
                    disabled={!distance || !duration}
                    disableElevation
                    fullWidth
                    size="large"
                    onClick={calculateRoute}
                    variant="contained"
                    color="secondary"
                  >
                    Submit Booking
                  </Button>
                </AnimateButton>
              </Box>
            </Grid>
          </Grid>
        </Grid>
        <Grid item lg="8">
          <Box
            sx={{
              width: "100%",
              height: "550px",
            }}
          >
            {isLoaded ? (
              <GoogleMap
                zoom={10}
                center={center}
                mapContainerStyle={{ width: "100%", height: "100%" }}
                options={{
                  zoomControl: false,
                  streetViewControl: false,
                  mapTypeControl: false,
                  fullscreenControl: false,
                }}
                onLoad={(map) => setMap(map)}
              >
                {directionsResponse && (
                  <DirectionsRenderer directions={directionsResponse} />
                )}
                <Marker position={center} />
              </GoogleMap>
            ) : (
              <Typography>Loading...</Typography>
            )}
          </Box>
        </Grid>
      </Grid>
    </MainCard>
  );
};

export default LocatingProcess;
