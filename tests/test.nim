# To run these tests, simply execute `nimble test`.

import unittest

import nimg711

test "test":
  let alaw =  @[0'u8, 0, 52, 18, 103, 69, 153, 186, 255, 127, 0, 128]
  let lin = alawToLin(alaw)
  doAssert lin == @[128'u8, 234, 128, 234, 0, 221, 64, 244, 96, 251, 248, 254, 
                    64, 14, 0, 63, 80, 3, 176, 252, 128, 234, 128, 21]

  doAssert linToAlaw(lin) == alaw
