import {Admin, Customer, Driver, Consultant} from './User.js'

class UserFactory {
    createUser () {
        throw new Error('createUser() must be implemented')
    }
}

class AdminFactory extends UserFactory {
    createUser (data) {
        return new Admin(data)
    }
}

class CustomerFactory extends UserFactory {
    createUser (data) {
        return new Customer(data)
    }
}

class DriverFactory extends UserFactory {
    createUser (data) {
        return new Driver(data)
    }
}

class ConsultantFactory extends UserFactory {
    createUser (data) {
        return new Consultant(data)
    }
}

export {
    UserFactory,
    AdminFactory,
    CustomerFactory,
    DriverFactory,
    ConsultantFactory,
}