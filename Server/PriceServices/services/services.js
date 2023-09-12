import { Price } from '../models/PriceModel.js'
import { Promotion } from '../models/PromotionModel.js'
import { PaymentMethod } from '../models/PaymentMethodModel.js'
import { Rule } from '../models/RuleModel.js'
import dotenv from 'dotenv';

dotenv.config();

const baseFare = parseInt(process.env.BASE_FARE);

const noonTimeFare = parseInt(process.env.NOON_TIME_FARE);
const eveningTimeFare = parseInt(process.env.EVENING_TIME_FARE);
const nightTimeFare = parseInt(process.env.NIGHT_TIME_FARE);

const carTypeFare = parseInt(process.env.CAR_TYPE_FARE);
const bikeTypeFare = parseInt(process.env.BIKE_TYPE_FARE);

const PriceService = {
    async get_price_list(filter, projection) {
        return await Price.find(filter).select(projection);
    },
    async get_price_by_type_name (type) {
        const price = await Price.findOne({type: type});
        if(!price) {
            throw new Error(`Price's info of "${type}" not found`);
        }
        return price;
    },
    async get_price_details(price_id) {
        return await Price.findById(price_id);
    },
    async create_price(price_data) {
        try {
            const price = new Price(price_data);
            return await price.save();
        } catch (err) {
            throw err
        }
    },
    async updatePrice(price_id, updateInfo) {
        try {
            return await Price.findByIdAndUpdate(price_id, updateInfo, {new: true});
        } catch (err) {
            throw err;
        }
    },
    async deletePrice(price_id) {
        try {
            return await Price.findByIdAndDelete(price_id);
        } catch (err) {
            throw err;
        }
    },
    async get_calculate_fee(distance, time, tripType, badWeather) {
        try {
            const priceInfo = await PriceService.get_price_by_type_name(tripType);
            const timestamp = Date.parse(time);
            const dateObject = new Date(timestamp);

            // Get the hour component
            const hours = dateObject.getHours();

            let config = {
                baseFare: priceInfo.baseFare,
                distanceFare: priceInfo.distanceFare,
                distance: distance,
                hours: hours,
                badWeather: badWeather,
                type: tripType,
            }
            config = await RuleService.applyRules(config);
            const fareInfo = {
                totalFare: config.baseFare + config.distanceFare * config.distance,
                rulesApplied: config.rulesApplied,
            }
            return fareInfo
        } catch (err) {
            console.log(err.message)
            throw new Error(err);
        }
    },
}

const PaymentService = {
    async getPaymentMethodList (filter, projection) {
        return await PaymentMethod.find(filter).select(projection);
    },
    async getPaymentMethodDetails (paymentMethodId) {
        return await PaymentMethod.findById(paymentMethodId)
    },
    async createPaymentMethod (paymentMethodInfo) {
        try {
            const paymentMethod = new PaymentMethod(paymentMethodInfo);
            return await paymentMethod.save();
        } catch (err) {
            throw err
        }
    },
    async updatePaymentMethod (paymentMethodId, updateInfo) {
        try {
            const updatedPaymentMethod = await PaymentMethod.findByIdAndUpdate(paymentMethodId, updateInfo, {new: true});
            return updatedPaymentMethod;
        } catch (err) {
            throw err;
        }
    },
    async deletePaymentMethod (paymentMethodId) {
        try {
            const deletedPaymentMethod = await PaymentMethod.findByIdAndDelete(paymentMethodId);
            return deletedPaymentMethod;
        } catch (err) {
            throw err;
        }
    }
}

const RuleService = {
    async getRuleLlist (filter, projection) {
        return await Rule.find(filter).select(projection);
    },
    async getRuleDetails (ruleId) {
        return await Rule.findById(ruleId)
    },
    async getRuleDetailsByName (ruleName) {
        return await Rule.findOne({name: ruleName})
    },
    async createRule (ruleInfo) {
        try {
            const rule = new Rule(ruleInfo);
            return await rule.save();
        }
        catch (err) {
            throw err
        }
    },
    async updateRule (ruleId, updateInfo) {
        return await Rule.findByIdAndUpdate(ruleId, updateInfo, {new: true});
    },
    async deleteRule (ruleId) {
        return await Rule.findByIdAndDelete(ruleId);
    },
    async applyRules(config) {
        try {
            let rulesApplied = [];
            const rules = await RuleService.getRuleLlist({}, {});
            for (const rule of rules) {
                const condition = new Function ('config', `return ${rule.condition};`)
                const action = new Function ('config', `return ${rule.action};`)

                if(condition(config)) {
                    rulesApplied.push(rule.name);
                    action(config);
                }
            }
            config.rulesApplied = rulesApplied;
            return config;
        } catch (err) {
            throw new Error("Error applying rules");
        }
    },
}

export {
    PriceService,
    PaymentService,
    RuleService,
}
