import dotenv from 'dotenv';
import mongoose from 'mongoose';

dotenv.config();

const config = process.env;

export default async () => {
    try {
        mongoose.set('strictQuery', true);
        const conn = await mongoose.connect(config.MONGO_DB, {
            useNewUrlParser: true,
            useUnifiedTopology: true,
        });
        console.log('MongoDB Connected: ' + conn.connection.host);
    } catch (err) {
        console.log(err);
    }
};
