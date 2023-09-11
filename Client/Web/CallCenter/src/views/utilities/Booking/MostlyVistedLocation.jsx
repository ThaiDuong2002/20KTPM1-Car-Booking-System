import React from "react";

import { useTheme } from "@mui/material/styles";
import ScrollBar from "react-perfect-scrollbar";
import CheckIcon from "@mui/icons-material/Check";

import {
  Box,
  Card,
  Table,
  TableBody,
  TableCell,
  TableHead,
  TablePagination,
  TableRow,
  Typography,
  Button,
  IconButton,
  Link,
  Grid,
} from "@mui/material";

import { mockDataMostlyVisitedLocation } from "data/mockData";

const MostlyVistedLocation = (props) => {
  const theme = useTheme();
  // const items = mockDataMostlyVisitedLocation;
  const items = props.mostlyLocationList;
  const handlePickUpBtnClick = () => {};
  const handleDropOffBtnClick = () => {};
  return (
    <Card>
      <Typography
        variant="h3"
        ml="5"
        mt="5"
        mb="5"
        color={theme.palette.secondary.main}
        sx={{
          fontWeight: "bold",
        }}
      >
        Mostly Visted Location
      </Typography>
      <ScrollBar>
        <Box sx={{ minWidth: 400 }}>
          <Table>
            <TableHead
              sx={{
                backgroundColor: theme.palette.primary.light,
              }}
            >
              <TableRow>
                <TableCell
                  sx={{
                    fontWeight: "bold",
                  }}
                >
                  ID
                </TableCell>
                <TableCell
                  sx={{
                    fontWeight: "bold",
                  }}
                >
                  Mostly Vesited Location
                </TableCell>
                <TableCell
                  sx={{
                    fontWeight: "bold",
                  }}
                >
                  Action
                </TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {items.map((location, index) => {
                return (
                  <TableRow hover key={index}>
                    <TableCell>{index + 1}</TableCell>
                    <TableCell>{location.address}</TableCell>
                    <TableCell>
                      <Button
                        onClick={() => handlePickUpBtnClick()}
                        variant="contained"
                        startIcon={<CheckIcon />}
                        size="small"
                      >
                        Pick Up
                      </Button>
                      <Button
                        onClick={() => handleDropOffBtnClick()}
                        variant="contained"
                        startIcon={<CheckIcon />}
                        size="small"
                      >
                        Drop Off
                      </Button>
                    </TableCell>
                  </TableRow>
                );
              })}
            </TableBody>
          </Table>
        </Box>
      </ScrollBar>
    </Card>
  );
};

export default MostlyVistedLocation;
