//: Playground - noun: a place where people can play

import UIKit

@objc protocol Speaker {
    func Speak()
    optional func TellJoke()
}

protocol DateSimulatorDelegate {
    func dateSimulatorDidStart(sim: DateSimulator, a: Speaker, b: Speaker)
    func dateSimulatorDidEnd(sim: DateSimulator, a:Speaker, b: Speaker)
}

class LoggingDateSimulator: DateSimulatorDelegate {
    func dateSimulatorDidStart(sim: DateSimulator, a: Speaker, b: Speaker) {
        print("Date started!")
    }
    func dateSimulatorDidEnd(sim: DateSimulator, a: Speaker, b: Speaker) {
        print("Date ended!")
    }
}

class DateSimulator {
    let a:Speaker
    let b:Speaker
    var delegate: DateSimulatorDelegate?
    
    init(a: Speaker, b: Speaker) {
        self.a = a
        self.b = b
    }
    
    func simulate() {
        delegate?.dateSimulatorDidStart(self, a: a, b: b)
        print("Off to dinner...")
        a.Speak()
        b.Speak()
        print("Walking back home...")
        delegate?.dateSimulatorDidEnd(self, a: a, b: b)
        a.TellJoke?()
        b.TellJoke?()
    }
}

class Vicki: Speaker {
    @objc func Speak() {
        print("hi, i'm vicki")
    }
    @objc func TellJoke() {
        print("Q: What did Sushi A say to Sushi B?")
    }
}
class Ray: Speaker {
    @objc func Speak() {
        print("Yo, I am Ray!")
    }
    @objc func TellJoke() {
        print("Q: Whats the object-oriented way to become wealthy?")
    }
    func WriteTutorial() {
        print("I'm on it!")
    }
}

let sim = DateSimulator(a: Vicki(), b: Ray())
sim.delegate = LoggingDateSimulator()
sim.simulate()

/*
let distances = [1.0, 2000.0, 10000.0, 1000000.0, 1000000000.0]

for distance in distances {
    let difficulty = -1.0 * pow(0.99, distance) + 1.0
    print(difficulty)
}
*/
















