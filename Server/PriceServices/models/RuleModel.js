import mongoose from 'mongoose';

const Schema = mongoose.Schema;

const RuleSchema = new Schema(
    {
        name: {
            type: String,
            required: true,
        },
        condition: {
            type: String,
            required: true,
        },
        action: {
            type: String,
            required: true,
        }
    },
    {
        timestamps: true,
    }
);

export const Rule = mongoose.model('Rule', RuleSchema, 'rules');
