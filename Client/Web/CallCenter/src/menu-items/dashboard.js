// assets
import { IconDashboard } from "@tabler/icons";

// constant
const icons = { IconDashboard };

// ==============================|| DASHBOARD MENU ITEMS ||============================== //

const dashboard = {
  id: "dashboard",
  title: "Home",
  type: "group",
  children: [
    {
      id: "home",
      title: "Call Center",
      type: "item",
      url: "/dashboard",
      icon: icons.IconDashboard,
      breadcrumbs: false,
    },
  ],
};

export default dashboard;
