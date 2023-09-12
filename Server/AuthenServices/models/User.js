import {AdminModel, CustomerModel, DriverModel, ConsultantModel} from '../schemas/UserSchema.js'

class User {
    constructor(data) {
        this.firstname = data.firstname
        this.lastname = data.lastname
        this.email = data.email
        this.phone = data.phone
        this.password = data.password
        this.avatar = data.avatar || undefined
        this.dob = data.dob || undefined
        this.userRole = data.userRole
        this.gender = data.gender || undefined
        this.refreshToken = data.refreshToken || undefined
    }
    async saveToDB() {}
    async update(id, updateInfo) {}
    async delete(id) {}
}

class Admin extends User {
    constructor(data) {
        super(data)
    }

    async saveToDB() {
        const newAdmin = new AdminModel(this)
        return await newAdmin.save()
    }

    async update(id, updateInfo) {}
    async delete(id) {}
}

class Customer extends User {
    constructor(data) {
        super(data)
        this.address = data.address || undefined
        this.userType = data.userType || undefined
        this.isDisabled = data.isDisabled || undefined
    }

    async saveToDB() {
        const newCustomer = new CustomerModel(this)
        return await newCustomer.save()
    }

    async update(id, updateInfo) {}
    async delete(id) {}
}

class Driver extends User {
    constructor(data) {
        super(data)
        this.driverLicense = data.driverLicense
        this.vehicleId = data.vehicleId
        this.isActive = data.isActive || undefined
        this.isDisabled = data.isDisabled || undefined
        this.isValid = data.isValid || undefined
        this.rating = data.rating || undefined // Rating id
    }

    async saveToDB() {
        const newDriver = new DriverModel(this)
        return await newDriver.save()
    }

    async update(id, updateInfo) {}
    async delete(id) {}
}

class Consultant extends User {
    constructor(data) {
        this.salary = data.salary || undefined
    }

    async saveToDB() {
        const newConsultant = new ConsultantModel(this)
        return await newConsultant.save()
    }

    async update(id, updateInfo) {}
    async delete(id) {}
}

export {
    User,
    Admin,
    Customer,
    Driver,
    Consultant,
}