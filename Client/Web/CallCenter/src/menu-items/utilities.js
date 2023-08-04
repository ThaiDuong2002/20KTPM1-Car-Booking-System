// assets
import {
  IconTypography,
  IconPalette,
  IconShadow,
  IconWindmill,
} from "@tabler/icons";

// constant
const icons = {
  IconTypography,
  IconPalette,
  IconShadow,
  IconWindmill,
};

// ==============================|| UTILITIES MENU ITEMS ||============================== //

const utilities = {
  id: "utilities",
  title: "Utilities",
  type: "group",
  children: [
    {
      id: "booking",
      title: "Booking",
      type: "item",
      url: "/utils/booking",
      icon: icons.IconTypography,
      breadcrumbs: false,
    },
    {
      id: "history-booking",
      title: "History Booking",
      type: "item",
      url: "/utils/history-booking",
      icon: icons.IconPalette,
      breadcrumbs: false,
    },
    // {
    //   id: "util-shadow",
    //   title: "Consultant",
    //   type: "item",
    //   url: "/utils/util-shadow",
    //   icon: icons.IconShadow,
    //   breadcrumbs: false,
    // },
    // {
    //   id: 'icons',
    //   title: 'Icons',
    //   type: 'collapse',
    //   icon: icons.IconWindmill,
    //   children: [
    //     {
    //       id: 'tabler-icons',
    //       title: 'Tabler Icons',
    //       type: 'item',
    //       url: '/icons/tabler-icons',
    //       breadcrumbs: false
    //     },
    //     {
    //       id: 'material-icons',
    //       title: 'Material Icons',
    //       type: 'item',
    //       external: true,
    //       target: '_blank',
    //       url: 'https://mui.com/material-ui/material-icons/',
    //       breadcrumbs: false
    //     }
    //   ]
    // }
  ],
};

export default utilities;
