// app.js - MicroKernel
import dotenv from 'dotenv';

dotenv.config();

class BookingLocator {
    constructor() {
        this.locatorService = [];
    }

    registerService(name, service) {
        this.locatorService[name] = service;
    }

    executeService(name, method, data) {
        const service = this.locatorService[name];
        if (service && typeof service[method] === 'function') {
            return service[method](data);
        }
        throw new Error(`Service or method not found: ${name}.${method}`);
    }

    getServices() {
        return this.locatorService
    }
}

export default BookingLocator;