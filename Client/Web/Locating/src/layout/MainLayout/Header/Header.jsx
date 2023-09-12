import PropTypes from "prop-types";
import { useEffect } from "react";

// MUI
import { useTheme } from "@mui/material/styles";
import { Avatar, Box, ButtonBase } from "@mui/material";

// component imports
import NotificationSection from "./NotificationSection/NotificationSection";
import ProfileSection from "./ProfileSection/ProfileSection";
import LogoSection from "./LogoSection/LogoSection";

//assets
import { IconMenu2 } from "@tabler/icons";
import { width } from "@mui/system";

const Header = (props) => {
  // const socket = props.socket;
  // const notificationList = props.notificationList;
  const theme = useTheme();

  return (
    <>
      <Box
        //customeize layout UI component
        sx={{
          width: 228,
          display: "flex",
          [theme.breakpoints.down("md")]: {
            width: "auto",
          },
        }}
      >
        <Box
          component="span"
          sx={{
            display: { xs: "none", md: "block" },
            flexGrow: 1,
          }}
        >
          <LogoSection />
        </Box>
        <ButtonBase sx={{ borderRadius: "12px", overflow: "hidden" }}>
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
          >
            <IconMenu2 stroke={1.5} size="1.3rem" />
          </Avatar>
        </ButtonBase>
      </Box>

      <Box sx={{ flexGrow: 1 }} />
      <Box sx={{ flexGrow: 1 }} />

      <NotificationSection
      // socket={socket}
      // notificationList={notificationList}
      />
      <ProfileSection />
    </>
  );
};

export default Header;
