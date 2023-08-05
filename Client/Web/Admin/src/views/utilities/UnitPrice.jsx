import React from "react";

//mui
import { Grid, Typography, Box } from "@mui/material";
import { useTheme } from "@mui/material/styles";

//project component import
import MainCard from "ui-component/cards/MainCard";
import FormUnitPrice from "./FormUnitPrice";
import { gridSpacing } from "store/constant";
import theme from "themes";

const UnitPrice = () => {
  const theme = useTheme();
  return (
    <MainCard title="Unit Price Management">
      <Box>
        <Typography
          variant="h3"
          ml="3"
          mt="3"
          color={theme.palette.secondary.main}
          sx={{
            fontWeight: "bold",
          }}
        >
          Price
        </Typography>
      </Box>
    </MainCard>
  );
};

export default UnitPrice;
