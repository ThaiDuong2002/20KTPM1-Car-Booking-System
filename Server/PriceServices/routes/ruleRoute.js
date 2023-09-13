import express from 'express';
import RuleController from '../controllers/ruleController.js';
const router = express.Router();

router.get('', RuleController.get_rule_list);
router.get('/:id', RuleController.get_rule_details);
router.post('/', RuleController.create_rule);
router.put('/:id', RuleController.update_rule);
router.delete('/:id', RuleController.delete_rule);

export default router;