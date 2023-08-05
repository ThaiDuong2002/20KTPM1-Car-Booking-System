import express from 'express';
import AddressController from "../controllers/address.controller.js";
import {authorization} from "../middlewares/authorization.js";

const router = express.Router();

router.get('', authorization(['customer']), AddressController.get_addresses)
router.get('/:id', authorization(['customer']), AddressController.get_address_details)
router.post('/save', authorization(['customer']), AddressController.save_address)
router.put('/edit/:id', authorization(['customer']), AddressController.edit_address)
router.delete('/delete/:id', authorization(['customer']), AddressController.delete_address)

export default router;