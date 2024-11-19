import Cocoa

var myArray : [Int] = [1,2,3,4,5]

var newArray = myArray.map({ (value: Int) in return value*value })

print(newArray)
