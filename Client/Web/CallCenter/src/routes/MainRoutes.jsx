import React from "react";

import { lazy } from "react";
import Loadable from "ui-component/Loadable";

import MainLayout from "../layout/MainLayout/MainLayout";

const MyProfile = Loadable(lazy(() => import("views/account/MyProfile")));
const UtilsBooking = Loadable(lazy(() => import("views/utilities/Booking")));
const UtilsHistoryBooking = Loadable(
  lazy(() => import("views/utilities/HistoryBooking"))
);

const MainRoutes = {
  path: "/",
  element: <MainLayout />,
  children: [
    {
      path: "my-profile",
      element: <MyProfile />,
    },
    {
      path: "utils",
      children: [
        {
          path: "booking",
          element: <UtilsBooking />,
        },
      ],
    },
    {
      path: "utils",
      children: [
        {
          path: "history-booking",
          element: <UtilsHistoryBooking />,
        },
      ],
    },
  ],
};

export default MainRoutes;
