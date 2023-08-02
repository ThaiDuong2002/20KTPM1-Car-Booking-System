import mongoose from 'mongoose';

const Schema = mongoose.Schema;

const Consultant = new Schema({
    salary: {
        type: Number,
        default: 0,
    },
});

export default User.discriminator('Consultant', Consultant);
