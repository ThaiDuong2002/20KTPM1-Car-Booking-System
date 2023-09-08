import React from "react";
import { lazy } from "react";

import MainLayout from "../layout/MainLayout/MainLayout";
import Loadable from "ui-component/Loadable";

//utilities routing
const Locating = Loadable(
  lazy(() => import("../views/utilities/Locating Process/LocatingList"))
);

const MainRoutes = {
  path: "/",
  element: <MainLayout />,
  children: [
    {
      path: "utils",
      children: [
        {
          path: "locating-process",
          element: <Locating />,
        },
      ],
    },
  ],
};

export default MainRoutes;
