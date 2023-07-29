import {
  Avatar,
  Box,
  Button,
  Card,
  CardActions,
  CardContent,
  Divider,
  Typography,
} from "@mui/material";
import MainCard from "ui-component/cards/MainCard";

const user = {
  avatar: "/assets/profile.jpg",
  city: "Los Angeles",
  country: "USA",
  jobTitle: "Senior Developer",
  name: "Anika Visser",
  timezone: "GTM-7",
};

export const AccountProfile = () => (
  <MainCard>
    <CardContent>
      <Box
        sx={{
          alignItems: "center",
          display: "flex",
          flexDirection: "column",
        }}
      >
        <Avatar
          src={user.avatar}
          sx={{
            height: 80,
            mb: 2,
            width: 80,
          }}
        />
        <Typography gutterBottom variant="h5">
          {user.name}
        </Typography>
        <Typography color="text.secondary" variant="body2">
          {user.city} {user.country}
        </Typography>
        <Typography color="text.secondary" variant="body2">
          {user.timezone}
        </Typography>
      </Box>
    </CardContent>
    <Divider />
    <CardActions>
      <Button fullWidth variant="text">
        Upload picture
      </Button>
    </CardActions>
  </MainCard>
);
