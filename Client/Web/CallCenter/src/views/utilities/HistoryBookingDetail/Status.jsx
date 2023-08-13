import { Chip } from "@mui/material";
import { width } from "@mui/system";
import React from "react";

const statusMap = {
  pending: "warning",
  confirmed: "primary",
  in_progress: "secondary",
  completed: "success",
  canceled: "error",
  pre_book: "default",
};

const Status = ({ status }) => {
  const chipColor = statusMap[status] || "default";
  const chipLabel = status.charAt(0).toUpperCase() + status.slice(1); // Capitalize the status label
  return (
    <div style={{ width: "100%" }}>
      <Chip
        label={chipLabel}
        width="500px"
        size="large"
        color={chipColor}
      ></Chip>
    </div>
  );
};

export default Status;
