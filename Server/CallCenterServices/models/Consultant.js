import mongoose from 'mongoose';
import User from './User.js';

const Schema = mongoose.Schema;

const ConsultantSchema = new Schema({
    salary: {
        type: Number,
        default: 0,
    },
});

export default User.discriminator('Consultant', ConsultantSchema);
