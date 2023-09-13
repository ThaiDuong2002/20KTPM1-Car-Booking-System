import React from "react";
import { lazy } from "react";

import MainLayout from "../layout/MainLayout/MainLayout";
import Loadable from "ui-component/Loadable";
import LocatingProcess from "views/utilities/Locating Process/LocatingProcess";
//utilities routing
const Locating = Loadable(
  lazy(() => import("../views/utilities/Locating Process/LocatingList"))
);

const Dashboard = Loadable(lazy(() => import("../views/dashboard/dashboard")));

const MainRoutes = {
  path: "/",
  element: <MainLayout />,
  children: [
    {
      path: "dashboard",
      element: <Dashboard />,
    },
    {
      path: "utils",
      children: [
        {
          path: "locating-process",
          element: <Locating />,
        },
        {
          path: "locating-process/:id",
          element: <LocatingProcess />,
        },
      ],
    },
  ],
};

export default MainRoutes;
