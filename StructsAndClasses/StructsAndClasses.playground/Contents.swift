//: Playground - noun: a place where people can play

import UIKit

// Value Types
var a = 42
var b = a
b += 1

// reference type

//let inputParameters = [
//    kCIInputRadiusKey: 10,
//    kCIInputImageKey: image
//]
//
//let blurFilter = CIFilter(name: "CIGaussianBlur", withInputParameters: inputParameters)!
//
//let scondBlurFilter = blurFilter
//scondBlurFilter.setValue(20, forKey: kCIInputRadiusKey)
//
//
/////  make it more safe, copy it!
//
////
//let blueFilterCopy = blurFilter.copy() as! CIFilter
//
//
//// or 
//
//struct GaussianBlur {
//    var inputImage: CIImage
//    var radius: Double
//}
//
//
//var blur = GaussianBlur(inputImage: image, radius: 10)

struct GaussianBlur {
    private var filter: CIFilter {
        get { return boxedFilter.unbox }
        set { boxedFilter = Box(newValue) }
    }

    private var boxedFilter: Box<CIFilter> = {
        var  filter = CIFilter(name: "CIGaussianBlur", withInputParameters: [:])!
        filter.setDefaults()
        return Box(filter)
    }()

    init(inputImage: CIImage, radius: Double) {
        filter = CIFilter(name: "CIGaussianBlur", withInputParameters: [kCIInputImageKey: inputImage,
            kCIInputRadiusKey: radius])!
    }
}

extension GaussianBlur {
    var inputImage: CIImage {
        get { return filter.valueForKey(kCIInputImageKey) as! CIImage }
        set { filterForWriting.setValue(newValue, forKey: kCIInputImageKey)}
    }

    var radius: Double {
        get { return filter.valueForKey(kCIInputRadiusKey) as! Double }
        set { filterForWriting.setValue(newValue, forKeyPath: kCIInputRadiusKey)}
    }

    var outputImage: CIImage {
        return filter.outputImage!
    }
    
}

// Copying the wrapped object every time the struct gets modified. That's it!

// 这里因为 `isUniquelyReferencedNonObjC` 只能在 Swift 对象中使用，所以要用 class 封装一下
final class Box<A> {
    var unbox: A
    init(_ value: A) { unbox = value}
}

extension GaussianBlur {
    private var filterForWriting: CIFilter {
        mutating get {
            if !isUniquelyReferencedNonObjC(&boxedFilter) {
                 filter = filter.copy() as! CIFilter
            }
            return filter
        }
    }
}

var i = 0

func uniqueInteger() -> Int {
    i += 1
    return i
}

uniqueInteger()
uniqueInteger()
uniqueInteger()

let otherFunction: () -> Int = uniqueInteger
otherFunction()
otherFunction()

func uniqueIntegerProvider() -> () -> Int {
    var i = 0
    return {
        i += 1
        return i
    }
}

let d: () -> Int = uniqueIntegerProvider()
d()
d()
