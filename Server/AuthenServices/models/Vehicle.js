import {CarModel, MotorbikeModel} from '../schemas/VehicleSchema.js'

class Vehicle {
    constructor(data) {
        this.color = data.color
        this.licensePlate = data.licensePlate
        this.image = data.image
        this.typeId = data.typeId
    }
    async saveToDB() {}
    async update(id, updateInfo) {}
    async delete(id) {}
}

class Car extends Vehicle {
    constructor(data) {
        super(data)
        this.capacity = data.capacity
    }
    async saveToDB() {
        const newCar = new CarModel(this)
        return await newCar.save()
    }
    async update(id, updateInfo) {}
    async delete(id) {}
}


class Motorbike extends Vehicle {
    constructor(data) {
        super(data)
    }
    async saveToDB() {
        const newMotorbike = new MotorbikeModel(this)
        return await newMotorbike.save()
    }
    async update(id, updateInfo) {}
    async delete(id) {}
}

export {
    Vehicle,
    Car,
    Motorbike,
}