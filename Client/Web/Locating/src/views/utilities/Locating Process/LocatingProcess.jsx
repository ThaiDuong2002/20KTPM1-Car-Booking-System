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
import { configDotenv } from "dotenv";

import dotenv from "dotenv";

dotenv.config();

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
  const [pickUpCoordinate, setPickUpCoordinate] = useState(null);
  const [dropOffCoordinate, setDropOffCoordinate] = useState(null);

  const { isLoaded } = useLoadScript({
    googleMapsApiKey: process.env.GOOGLE_MAP_API_KEY,
  });

  async function calculateRoute() {
    // if (originRef.current.value === "" || destinationRef.current.value === "") {
    //   return;
    // }
    try {
      const origin = objectBooking.pickupLocation.address;
      const destination = objectBooking.destinationLocation.address;

      // Lấy tọa độ của vị trí bắt đầu (origin)
      // eslint-disable-next-line no-undef
      const originGeocodeResult = await new google.maps.Geocoder().geocode({
        address: "Đại học Khoa học Tự nhiên",
      });
      if (!originGeocodeResult || originGeocodeResult.length === 0) {
        throw new Error("Không thể tìm thấy tọa độ cho vị trí bắt đầu.");
      }
      const originCoordinate = originGeocodeResult.results[0].geometry.location;
      setPickUpCoordinate({
        lat: originCoordinate.lat,
        lng: originCoordinate.lng,
      });

      // Lấy tọa độ của vị trí đích (destination)
      // eslint-disable-next-line no-undef
      const destinationGeocodeResult = await new google.maps.Geocoder().geocode(
        { address: destination }
      );
      if (!destinationGeocodeResult || destinationGeocodeResult.length === 0) {
        throw new Error("Không thể tìm thấy tọa độ cho vị trí đích.");
      }
      const destinationCoordinate =
        destinationGeocodeResult.results[0].geometry.location;
      setDropOffCoordinate({
        lat: destinationCoordinate.lat,
        lng: destinationCoordinate.lng,
      });

      // eslint-disable-next-line no-undef
      const directionsService = new google.maps.DirectionsService();
      const results = await directionsService.route({
        origin: objectBooking.pickupLocation.address,
        destination: objectBooking.destinationLocation.address,
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

  const handleSubmitClick = () => {
    const postBody = {
      customerName: objectBooking.customerName,
      customerPhone: objectBooking.customerPhone,
      pickupLocation: {
        address: objectBooking.pickupLocation.address,
        coordinate: pickUpCoordinate,
      },
      destinationLocation: {
        address: objectBooking.destinationLocation.address,
        cooordinate: dropOffCoordinate,
      },
      type: objectBooking.type,
    };

    console.log("Post Body: ", postBody);
  };

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
                {objectBooking.pickupLocation.address}
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
                {objectBooking.destinationLocation.address}
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
                    onClick={handleSubmitClick}
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
