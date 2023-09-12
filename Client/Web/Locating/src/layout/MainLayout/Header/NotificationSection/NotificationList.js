// material-ui
import { useTheme, styled } from "@mui/material/styles";
import {
  Avatar,
  Button,
  Card,
  CardContent,
  Chip,
  Divider,
  Grid,
  List,
  ListItem,
  ListItemAvatar,
  ListItemSecondaryAction,
  ListItemText,
  Stack,
  Typography,
} from "@mui/material";

// assets
import {
  IconBrandTelegram,
  IconBuildingStore,
  IconMailbox,
  IconPhoto,
} from "@tabler/icons";
import User1 from "../../../../assets/images/users/user-round.svg";
import System from "assets/images/system.png";
import { useEffect, useState } from "react";
import axiosClient from "axiosConfig/axiosClient";

// styles
const ListItemWrapper = styled("div")(({ theme }) => ({
  cursor: "pointer",
  padding: 16,
  "&:hover": {
    background: theme.palette.primary.light,
  },
  "& .MuiListItem-root": {
    padding: 0,
  },
}));

// ==============================|| NOTIFICATION LIST ITEM ||============================== //

const initialNotification = {
  _id: "",
  title: "",
  content: "",
  userid: "",
  deviceId: "",
  isRead: "",
  type: "",
  createdAt: "",
  updatedAt: "",
};
const NotificationList = () => {
  const theme = useTheme();
  const [notificationList, setNotificationList] = useState([]);

  const chipSX = {
    height: 24,
    padding: "0 6px",
  };
  const chipErrorSX = {
    ...chipSX,
    color: theme.palette.orange.dark,
    backgroundColor: theme.palette.orange.light,
    marginRight: "5px",
  };

  const chipWarningSX = {
    ...chipSX,
    color: theme.palette.warning.dark,
    backgroundColor: theme.palette.warning.light,
  };

  const chipSuccessSX = {
    ...chipSX,
    color: theme.palette.success.dark,
    backgroundColor: theme.palette.success.light,
    height: 28,
  };

  useEffect(() => {
    async function fetchData() {
      try {
        const response = await axiosClient.get("/notifications");
        setNotificationList(response.data.data);
        console.log("Notification list: ", response);
      } catch (error) {
        console.log("Error: ", error);
      }
    }
    fetchData();
  }, []);

  return (
    <List
      sx={{
        width: "100%",
        maxWidth: 330,
        py: 0,
        borderRadius: "10px",
        [theme.breakpoints.down("md")]: {
          maxWidth: 300,
        },
        "& .MuiListItemSecondaryAction-root": {
          top: 22,
        },
        "& .MuiDivider-root": {
          my: 0,
        },
        "& .list-container": {
          pl: 7,
        },
      }}
    >
      {notificationList.map((notification) => {
        return (
          <>
            <ListItemWrapper key={notification._id}>
              <ListItem alignItems="center">
                <ListItemAvatar>
                  <Avatar alt="John Doe" src={System} />
                </ListItemAvatar>
                <ListItemText primary="Reception System" />
                <ListItemSecondaryAction>
                  <Grid container justifyContent="flex-end">
                    <Grid item xs={12}>
                      <Typography
                        variant="caption"
                        display="block"
                        gutterBottom
                      >
                        2 min ago
                      </Typography>
                    </Grid>
                  </Grid>
                </ListItemSecondaryAction>
              </ListItem>
              <Grid container direction="column" className="list-container">
                <Grid item xs={12} sx={{ pb: 1 }}>
                  <Typography variant="subtitle2">
                    {notification.title}
                  </Typography>
                </Grid>
                <Grid item xs={12} sx={{ pb: 1 }}>
                  <Typography variant="subtitle2">
                    {notification?.content}
                  </Typography>
                </Grid>
                {/* <Grid item xs={12}>
                  <Grid container>
                    <Grid item>
                      <Chip label="Unread" sx={chipErrorSX} />
                    </Grid>
                    <Grid item>
                      <Chip label="New" sx={chipWarningSX} />
                    </Grid>
                  </Grid>
                </Grid> */}
              </Grid>
            </ListItemWrapper>
            <Divider />
          </>
        );
      })}
    </List>
  );
};

export default NotificationList;
