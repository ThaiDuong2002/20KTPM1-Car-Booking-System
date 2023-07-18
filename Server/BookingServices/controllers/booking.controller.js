import CreateError from 'http-errors';

const BookingController = {
    async create_booking(req, res, next) {
        console.log(req.body);
        res.status(200).json({
            message: 'Create booking successfully'
        })
    },
}

export default BookingController;