import mongoose from "mongoose";

const Schema = mongoose.Schema;

const Vehicle = new Schema({
  color: {
    type: String,
    required: true,
    trim: true,
    default: "white",
  },
  licensePlate: {
    type: String,
    required: true,
    trim: true,
    default: "",
  },
  image: {
    type: String,
    required: true,
    default: "",
  },
});

export default mongoose.model("Vehicle", Vehicle);