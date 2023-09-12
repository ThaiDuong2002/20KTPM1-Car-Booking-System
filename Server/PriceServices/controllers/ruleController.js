import createError from 'http-errors'
import {RuleService} from '../services/services.js';

const RuleController = {
    get_rule_list: async (req, res, next) => {
        try {
            let filter = req.body
            const list = await RuleService.getRuleLlist(filter, {});
            if (!list) {
                return next(createError.BadRequest("Get rules list failed"));
            }
            if (list.length === 0) {
                return next(createError.NotFound("No Rule found"));
            }
            console.log("req", req.method)
            res.json({
                message: 'Get rules list successfully',
                status: 200,
                data: list,
            })
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
    get_rule_details: async (req, res, next) => {
        try {
            const ruleId = req.params.id
            const rule = await RuleService.getRuleDetails(ruleId);
            if (!rule) {
                return next(createError.NotFound("Rule not found"));
            }
            res.json({
                message: 'Get rule details successfully',
                status: 200,
                data: rule,
            })
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
    create_rule: async (req, res, next) => {
        try {
            const ruleInfo = req.body;
            // Check if rule type is existed
            const rule = await RuleService.getRuleDetailsByName(ruleInfo.name);
            if (rule) {
                return next(createError.Conflict("Rule type is existed"));
            }
            // Create rule
            const rule_re = await RuleService.createRule(ruleInfo);
            if (!rule_re) {
                return next(createError.Conflict("Create rule failed"));
            }
            res.status(201).json({
                message: 'Create rule successfully',
                status: 200,
                data: rule_re,
            })
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
    update_rule: async (req, res, next) => {
        try {
            const ruleId = req.params.id;
            const updateInfo = req.body;
            // Check if rule is existed
            const rule = await RuleService.getRuleDetails(ruleId);
            if (!rule) {
                return next(createError.NotFound("Rule not found"));
            }
            // Update rule
            const rule_re = await RuleService.updateRule(ruleId, updateInfo);
            if (!rule_re) {
                return next(createError.NotFound("Update rule failed"));
            }
            res.status(200).json({
                message: 'Update rule successfully',
                status: 200,
                data: rule_re,
            })
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
    delete_rule: async (req, res, next) => {
        try {
            const ruleId = req.params.id;
            // Check if rule is existed
            const rule = await RuleService.getRuleDetails(ruleId);
            if (!rule) {
                return next(createError.NotFound("Rule not found"));
            }
            // Delete rule
            const rule_re = await RuleService.deleteRule(ruleId);
            if (!rule_re) {
                return next(createError.NotFound("Delete rule failed"));
            }
            res.status(200).json({
                message: 'Delete rule successfully',
                status: 200,
                data: rule_re,
            })
        } catch (err) {
            next(createError.InternalServerError(err.message));
        }
    },
};

export default RuleController;
