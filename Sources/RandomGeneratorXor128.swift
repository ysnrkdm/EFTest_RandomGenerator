//
//  RandomGeneratorXor128.swift
//  EFTest
//
//  Created by KodamaYoshinori on 2016/10/22.
//  Copyright © 2016 Yoshinori Kodama. All rights reserved.
//

public class RandomGeneratorXor128 {
    open static var generator = {
        return RandomGeneratorXor128(seed: 19337)
    }
    
    var seed: UInt64
    
    var x: UInt64
    var y: UInt64
    var z: UInt64
    var w: UInt64
        
    fileprivate init(seed: Int) {
        self.seed = UInt64.init(seed)
        self.x = 123456789
        self.y = 362436069
        self.z = 521288629
        self.w = 88675123
        
        self.z ^= self.seed;
        self.z ^= z >> 21; z ^= z << 35; z ^= z >> 4;
        self.z = self.z &* 2685821657736338717
    }
    
    func xor128() -> UInt64 {
        let t = x ^ (x << 11)
        x = y; y = z; z = w;
        w = (w ^ (w >> 19)) ^ (t ^ (t >> 8))
        
//        print("\(x), \(y), \(z), \(w)")     // debug print
        
        return w
    }
    
    open func getNextRandomUInt() -> UInt {
        return UInt.init(truncatingBitPattern: xor128())
    }
    
    open func getNextRandomInt() -> Int {
        return Int.init(truncatingBitPattern: xor128())
    }
}
