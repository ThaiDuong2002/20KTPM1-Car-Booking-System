import dotenv from 'dotenv';
import mongoose from 'mongoose';
import Redis from 'ioredis';

dotenv.config();

// // Set up the Redis client
// const redisClient = new Redis({
//     host: process.env.REDIS_HOST,
//     port: process.env.REDIS_PORT,
// });
//
// // Handle connection event
// redisClient.on('connect', () => {
//     console.log('Connected to Redis');
// });
//
// // Handle disconnection event
// redisClient.on('end', () => {
//     console.log('Disconnected from Redis');
// });

export default async () => {
    try {
        mongoose.set('strictQuery', true);
        const conn = await mongoose.connect(process.env.MONGO, {
            useNewUrlParser: true,
            useUnifiedTopology: true,
        });
        console.log('MongoDB Connected: ' + conn.connection.host);

        return {
            mongoose: conn,        // Export the MongoDB connection
            // redisClient: redisClient // Export the Redis client
        };
    } catch (err) {
        console.log(err);
        throw err; // Re-throw the error to be caught by the caller
    }
};
