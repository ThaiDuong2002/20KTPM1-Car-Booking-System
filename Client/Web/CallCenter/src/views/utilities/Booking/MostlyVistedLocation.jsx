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

const MostlyVistedLocation = () => {
  const theme = useTheme();
  const items = mockDataMostlyVisitedLocation;
  const handlePickUpBtnClick = () => {};
  const handleDropOffBtnClick = () => {};
  return (
    <Card>
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
              {items.map((location) => {
                return (
                  <TableRow hover key={location._id}>
                    <TableCell>{location._id}</TableCell>
                    <TableCell>
                      {location.mostlyVisitedLocation?.location}
                    </TableCell>
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
