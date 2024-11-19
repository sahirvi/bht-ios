import Cocoa

// 1.)

var myTuple : (String, Int, String, Int, String, Int, String, Int, String, Int)?


// 2.)

// Aufgabe 2 ist über for-Schleife nicht möglich, da man bei Swift aktuell nicht über Tupel iterieren kann, deswegen kann man die Elemente des Tupels nicht auf beliebige Werte setzen

myTuple = ("eins", 1, "zwei", 2, "drei", 3, "vier", 4, "fünf", 5)


// 3.)

var Arr1: [Int]?

var Arr2: [String]?


// 4.)

// Iteration über Tupel ist wieder nicht möglich, deswegen so gelöst:

let (string0, int1, string2, int3, string4, int5, string6, int7, string8, int9) = myTuple!
Arr1 = [int1, int3, int5, int7, int9]
Arr2 = [string0, string2, string4, string6, string8]


// 5.)

var myDict:[String:Int]?


// 6.)


myDict = [:]

for i in 0..<Arr1!.capacity {
    myDict![Arr2![i]] = Arr1![i]
}

print("\(myTuple!) --> \(myDict!)")

