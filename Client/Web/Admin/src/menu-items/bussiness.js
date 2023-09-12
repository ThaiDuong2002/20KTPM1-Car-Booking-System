// assets
import { IconBrandChrome, IconHelp } from "@tabler/icons";

// constant
const icons = { IconBrandChrome, IconHelp };

const bussiness = {
  id: "bussiness",
  type: "group",
  children: [
    {
      id: "unit-price",
      title: "Unit Price",
      type: "item",
      url: "/bussiness/unit_price",
      icon: icons.IconHelp,
      breadcrumbs: false,
    },
    {
      id: "rules",
      title: "Rules",
      type: "item",
      url: "/bussiness/rules",
      icon: icons.IconBrandChrome,
      breadcrumbs: false,
    },
  ],
};

export default bussiness;
