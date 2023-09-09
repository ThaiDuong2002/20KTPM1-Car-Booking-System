import React, { useMemo, useState } from "react";

import { useNavigate } from "react-router-dom";

// material-ui
import { styled, useTheme } from "@mui/material/styles";
import {
  Box,
  Grid,
  Typography,
  Card,
  SvgIcon,
  ButtonBase,
  Avatar,
} from "@mui/material";
import { IconMenu2 } from "@tabler/icons";
import MapIcon from "@mui/icons-material/Map";

import {
  GoogleMap,
  useLoadScript,
  Marker,
  useJsApiLoader,
} from "@react-google-maps/api";

import PlaceIcon from "@mui/icons-material/Place";
import CalendarMonthIcon from "@mui/icons-material/CalendarMonth";

// compononet import
import { gridSpacing } from "store/constant";
import MainCard from "ui-component/cards/MainCard";
import Status from "./Status";

const StyledProductImg = styled("img")({
  top: 0,
  width: "100%",
  height: "100%",
  objectFit: "cover",
  position: "absolute",
});

const statusMap = {
  pending: "warning",
  success: "success",
  refunded: "error",
};

const CardWrapper = styled(MainCard)(({ theme }) => ({
  backgroundColor: theme.palette.primary.dark,
  color: theme.palette.primary.light,
  overflow: "hidden",
  position: "relative",
  height: "50px",
  display: "flex",
  justifyContent: "center",
  "&:after": {
    content: '""',
    position: "absolute",
    width: 210,
    height: 210,
    background: `linear-gradient(210.04deg, ${theme.palette.primary[200]} -50.94%, rgba(144, 202, 249, 0) 83.49%)`,
    borderRadius: "50%",
    top: -30,
    right: -180,
  },
  "&:before": {
    content: '""',
    position: "absolute",
    width: 210,
    height: 210,
    background: `linear-gradient(140.9deg, ${theme.palette.primary[200]} -14.02%, rgba(144, 202, 249, 0) 77.58%)`,
    borderRadius: "50%",
    top: -160,
    right: -130,
  },
}));

const mockData = {
  pickupLocation: {
    coordinate: {
      lat: 0.12,
      lng: 0.12,
    },
    address: "A",
  },
  destinationLocation: {
    coordinate: {
      lat: 0.15,
      lng: 0.15,
    },
    address: "B",
  },
  _id: "64f17fd10036d9ad3dde74ff",
  userId: {
    _id: "64ca771ce1971471cca748b4",
    firstname: "consultant",
    lastname: "consultant",
    email: "consultant@gmail.com",
    phone: "3333333333",
    avatar:
      "https://haycafe.vn/wp-content/uploads/2022/02/Avatar-trang-den.png",
    salary: 0,
    __t: "Consultant",
    createdAt: "2023-08-02T15:32:44.133Z",
    updatedAt: "2023-09-01T06:26:07.968Z",
    __v: 0,
    gender: "male",
    dob: "2002-05-21T00:00:00.000Z",
    userRole: "consultant",
  },
  driverId: {
    _id: "64f1709a0c4ce1db877fb083",
    firstname: "driver1",
    lastname: "driver1",
    email: "driver1@gmail.com",
    phone: "0795907075",
    avatar:
      "https://haycafe.vn/wp-content/uploads/2022/02/Avatar-trang-den.png",
    userRole: "driver",
    driverLicense: ["asdasdasdas", "asdasdasdas"],
    vehicleId: "64f1709a0c4ce1db877fb081",
    isActive: true,
    isDisabled: false,
    isValid: false,
    __t: "Driver",
    createdAt: "2023-09-01T05:03:22.142Z",
    updatedAt: "2023-09-04T18:14:05.565Z",
    __v: 0,
  },
  customerName: "A",
  customerPhone: "0795907075",
  type: "Motorbike",
  distance: 500,
  preTotal: 500000,
  total: 700000,
  promotionId: null,
  status: "Pending",
  pickupTime: "2023-09-01T06:08:13.561Z",
  dropOffTime: "2023-09-01T06:08:13.561Z",
  paymentMethodId: {
    _id: "64cb6802bf5a624f310fe49e",
    name: "test payment method",
    status: true,
  },
  refundId: {
    _id: "64cca289b2ebe93ee0eb2c95",
    booking_id: "64cc826b7fa66a342b7f63e5",
    amount: 10000,
    date: "2020-01-12T00:00:00.000Z",
    reason: "test",
    status: "refunded",
    user_id: "64cca5c8b2ebe93ee0eb2ca5",
  },
  createdAt: "2023-09-01T06:08:17.200Z",
  updatedAt: "2023-09-01T06:08:17.200Z",
  __v: 0,
};

const TripCard = (props) => {
  const theme = useTheme();
  const navigate = useNavigate();
  const color = theme.palette.secondary.light;
  const gridSpacing = 2;
  const bookingInfo = props.bookingInfo;
  // const bookingInfo = mockData;

  // const center = {
  //   lat: -34.397,
  //   lng: 150.644,
  // };

  // const [isLoaded, setIsLoaded] = useState(false); // Sử dụng state để quản lý trạng thái nạp

  // const { loadError } = useLoadScript({
  //   googleMapsApiKey: "AIzaSyDegGs0gQhRVn5osHdt_hOmjwiXpjpJL9Q",
  //   onLoad: () => {
  //     // Đã nạp thành công
  //     setIsLoaded(true);
  //     console.log("Is Loaded:", isLoaded);
  //   },
  // });

  // const { isLoaded } = useJsApiLoader({
  //   googleMapsApiKey: "AIzaSyCMLT-TdypxBr0EYYuEvVIQTt1-zBWoQWg",
  //   libraries: ["places"],
  // });

  const { isLoaded } = useLoadScript({
    googleMapsApiKey: "AIzaSyCMLT-TdypxBr0EYYuEvVIQTt1-zBWoQWg",
  });

  const handleDisplayMap = () => {
    console.log("Here");
    navigate("/utils/map", { state: mockData });
  };

  return (
    <MainCard>
      <Grid
        container
        spacing={gridSpacing}
        sx={{
          display: "flex",
          alignItems: "center",
        }}
      >
        <Grid item lg={11}>
          <Typography align="left" variant="h4">
            About
          </Typography>
          <Typography align="left" variant="h1" sx={{ fontWeight: "bold" }}>
            Trip: ABC123
          </Typography>
        </Grid>
        <Grid item lg={1}>
          <ButtonBase
            sx={{
              borderRadius: "12px",
              overflow: "hidden",
            }}
          >
            <Avatar
              sx={{
                ...theme.typography.commonAvatar,
                ...theme.typography.mediumAvatar,
                transition: "all .2s ease-in-out",
                background: theme.palette.secondary.light,
                color: theme.palette.secondary.dark,
                "&:hover": {
                  background: theme.palette.secondary.dark,
                  color: theme.palette.secondary.light,
                },
              }}
              onClick={handleDisplayMap}
            >
              <MapIcon stroke={1.5} size="1.3rem" />
            </Avatar>
          </ButtonBase>
        </Grid>
        {/* <Grid item lg={6}>
          <Box sx={{ pt: "100%", position: "absolute" }}>
            {isLoaded ? (
              <GoogleMap
                // mapContainerStyle={mapStyles}
                zoom={10}
                center={center}
                mapContainerStyle={{ width: "100%", height: "100%" }}
              >
                <Marker position={center} />
              </GoogleMap>
            ) : (
              <Typography>Loading...</Typography>
            )}
          </Box>
        </Grid> */}
        <Grid item lg={12}>
          <Grid item lg={12}>
            <Typography align="left" variant="h5" sx={{ fontWeight: "bold" }}>
              From
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
              {bookingInfo.pickupLocation?.address}
            </Card>
          </Grid>

          <Grid item lg={12}>
            <Typography
              align="left"
              variant="h5"
              mt={2}
              sx={{ fontWeight: "bold" }}
            >
              To
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
              {bookingInfo.destinationLocation?.address}
            </Card>
          </Grid>

          <Grid container lg={12} mt={2} spacing={gridSpacing}>
            <Grid item lg={6}>
              <Typography align="left" variant="h5" sx={{ fontWeight: "bold" }}>
                Date
              </Typography>
              <Card
                variant="outlined"
                sx={{
                  width: "100%",
                  height: "40px",
                  alignItems: "center",
                  justifyContent: "center",
                  display: "flex",
                }}
              >
                <SvgIcon color="primary" fontSize="small">
                  <CalendarMonthIcon />
                </SvgIcon>
                {bookingInfo?.createdAt}
              </Card>
            </Grid>
            <Grid item lg={6}>
              <Typography align="left" variant="h5" sx={{ fontWeight: "bold" }}>
                Type
              </Typography>
              <Card
                variant="outlined"
                sx={{
                  width: "100%",
                  height: "40px",
                  alignItems: "center",
                  justifyContent: "center",
                  display: "flex",
                }}
              >
                {bookingInfo.type}
              </Card>
            </Grid>
          </Grid>

          <Grid item lg={12} mt={2}>
            <Typography align="left" variant="h5" sx={{ fontWeight: "bold" }}>
              Trip Status
            </Typography>
            <CardWrapper border={false} content={false}>
              <Typography
                variant="h3"
                sx={{
                  color: "#fff",
                  justifyContent: "center",
                  alignItems: "center",
                  display: "flex",
                }}
              >
                {bookingInfo.status}
              </Typography>
            </CardWrapper>
          </Grid>
        </Grid>
      </Grid>
    </MainCard>
  );
};

export default TripCard;
