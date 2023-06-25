import mongoose from 'mongoose';
import User from './User.js';

const Schema = mongoose.Schema;

export default User.discriminator('Admin', new Schema({}));