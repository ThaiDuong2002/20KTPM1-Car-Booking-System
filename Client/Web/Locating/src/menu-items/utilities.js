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
      id: "locating-process",
      title: "Locating Process",
      type: "item",
      url: "/utils/locating-process",
      icon: icons.IconTypography,
      breadcrumbs: false,
    },
  ],
};

export default utilities;
