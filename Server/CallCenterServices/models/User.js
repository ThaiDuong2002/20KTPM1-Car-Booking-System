import mongoose from 'mongoose';

const Schema = mongoose.Schema;

const User = new Schema(
  {
    firstname: {
      type: String,
      required: true,
      trim: true,
      default: '',
      minlength: 3,
      maxlength: 50,
    },
    lastname: {
      type: String,
      required: true,
      trim: true,
      default: '',
      minlength: 3,
      maxlength: 50,
    },
    email: {
      type: String,
      required: true,
      trim: true,
      default: '',
      minlength: 3,
      maxlength: 50,
      unique: true,
    },
    phone: {
      type: String,
      required: true,
      trim: true,
      default: '',
      minlength: 3,
      maxlength: 15,
      unique: true,
    },
    password: {
      type: String,
      required: true,
      default: '',
    },
    avatar: {
      type: String,
      required: false,
      default: "https://haycafe.vn/wp-content/uploads/2022/02/Avatar-trang-den.png",
    },
    refreshToken: {
      type: String,
      required: true,
      default: " ",
    },
  },
  {
    timestamps: true,
  }
);

export default mongoose.model('User', User);
