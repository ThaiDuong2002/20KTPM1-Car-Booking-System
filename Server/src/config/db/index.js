import mongoose from 'mongoose';
import dotenv from 'dotenv';
dotenv.config();

const connect = async () => {
  try {
    await mongoose.connect(
      'mongodb://localhost:27017/NodeJS_Education',
      {
        useNewUrlParser: true,

        useUnifiedTopology: true,
      }
    );
  } catch (err) {
    console.log(err);
  }
}

export default { connect };
