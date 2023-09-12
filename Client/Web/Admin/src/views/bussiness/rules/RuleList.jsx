import React from "react";
import { useState, useEffect } from "react";
import axiosClient from "axiosConfig/axiosClient";
import { useNavigate } from "react-router-dom";

const initialRule = {
  _id: "",
  name: "",
  condition: "",
  action: "",
  createdAt: "",
  updatedAt: "",
};

const RuleList = () => {
  const [rules, setRules] = useState([]);
  const navigate = useNavigate();

  useEffect(() => {
    async function fetchData() {
      try {
        const response = await axiosClient.get("rule");
        setRules(response.data.data);

        console.log("Repponse Rule List: ", response.data.data);
      } catch (error) {
        console.log(error);
      }
    }
    fetchData();
  }, []);

  const handleTableRowClick = (bookingId) => {
    navigate(`/utils/history-booking/${bookingId}`, { state: bookingId });
  };

  return <div>RuleList</div>;
};

export default RuleList;
