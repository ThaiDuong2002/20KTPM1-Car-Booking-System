import React from "react";

import { lazy } from "react";
import Loadable from "ui-component/Loadable";

import MainLayout from "../layout/MainLayout/MainLayout";

import MyProfile from "views/account/MyProfile";

const MainRoutes = {
  path: "/",
  element: <MainLayout />,
  children: [
    {
      path: "/my-profile",
      element: <MyProfile />,
    },
  ],
};

export default MainRoutes;
