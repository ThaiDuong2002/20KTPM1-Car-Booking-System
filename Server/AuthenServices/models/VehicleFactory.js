import {Car, Motorbike} from './Vehicle.js'

class VehicleFactory {
    createVehicle () {
        throw new Error('createVehicle() must be implemented')
    }
}

class CarFactory extends VehicleFactory {
    createVehicle (data) {
        return new Car(data)
    }
}

class MotorbikeFactory extends VehicleFactory {
    createVehicle (data) {
        return new Motorbike(data)
    }
}

export {
    VehicleFactory,
    CarFactory,
    MotorbikeFactory,
}