import dotenv from 'dotenv';
import mongoose from 'mongoose';
import Redis from 'ioredis';

dotenv.config();

let redis;
let mongoose_conn

const initializeApp = async () => {
  try {
    mongoose.set('strictQuery', true);
    mongoose_conn = await mongoose.connect(process.env.MONGO, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });

    // Create a Redis client
    redis = new Redis(process.env.REDIS_URI);

    // Handle connection errors
    redis.on('error', (err) => {
      console.error('Redis Error:', err);
    });

    // Flush Redis
    // await redis.flushdb();

    const redisStatus = await redis.ping();

    console.log('Redis ' + (redisStatus === 'PONG' ? 'Connected' : 'Not Connected'));
    console.log('MongoDB Connected: ' + mongoose_conn.connection.host);
  } catch (err) {
    console.log(err);
  }
};

export {
  redis,
  mongoose_conn,
  initializeApp,
}