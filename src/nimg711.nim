# Copyright (c) 2020 kur1zu
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import bitops

const alawSeg : array[128, uint8] = [
    1'u8, 1, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5,
    5, 5, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 
    6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 
    7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 
    7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 
    7, 7, 7, 7,
]
const alawToLinTable: array[256, int16] =[
    -5504'i16, -5248, -6016, -5760, -4480, -4224, -4992, -4736, -7552, -7296, 
    -8064, -7808, -6528, -6272, -7040, -6784, -2752, -2624, -3008, -2880, 
    -2240, -2112, -2496, -2368, -3776, -3648, -4032, -3904, -3264, -3136, -3520, 
    -3392, -22016, -20992, -24064, -23040, -17920, -16896, -19968, -18944,
    -30208, -29184, -32256, -31232, -26112, -25088, -28160, -27136, -11008, 
    -10496, -12032, -11520, -8960, -8448, -9984, -9472, -15104, -14592, -16128, 
    -15616, -13056, -12544, -14080, -13568, -344, -328, -376, -360, -280, -264, 
    -312, -296, -472, -456, -504, -488, -408, -392, -440, -424, -88, -72, -120, 
    -104, -24, -8, -56, -40, -216, -200, -248, -232, -152, -136, -184, -168,
    -1376, -1312, -1504, -1440, -1120, -1056, -1248, -1184, -1888, -1824, -2016,
    -1952, -1632, -1568, -1760, -1696, -688, -656, -752, -720, -560, -528, -624, 
    -592, -944, -912, -1008, -976, -816, -784, -880, -848, 5504, 5248, 6016, 
    5760, 4480, 4224, 4992, 4736, 7552, 7296, 8064, 7808, 6528, 6272, 7040, 
    6784, 2752, 2624, 3008, 2880, 2240, 2112, 2496, 2368, 3776, 3648, 4032, 
    3904, 3264, 3136, 3520, 3392, 22016, 20992, 24064, 23040, 17920, 16896, 
    19968, 18944, 30208, 29184, 32256, 31232, 26112, 25088, 28160, 27136, 11008, 
    10496, 12032, 11520, 8960, 8448, 9984, 9472, 15104, 14592, 16128, 15616, 
    13056, 12544, 14080, 13568, 344, 328, 376, 360, 280, 264, 312, 296, 472, 
    456, 504, 488, 408, 392, 440, 424, 88, 72, 120, 104, 24, 8, 56, 40, 216, 
    200, 248, 232, 152, 136, 184, 168, 1376, 1312, 1504, 1440, 1120, 1056, 1248, 
    1184, 1888, 1824, 2016, 1952, 1632, 1568, 1760, 1696, 688, 656, 752, 720, 
    560, 528, 624, 592, 944, 912, 1008, 976, 816, 784, 880, 848,
]
const alawToUlawTable: array[256, uint8] = [
    42'u8, 43, 40, 41, 46, 47, 44, 45, 34, 35, 32, 33, 38, 39, 36, 37, 57, 58, 
    55, 56, 61, 62, 59, 60, 49, 50, 47, 48, 53, 54, 51, 52, 10, 11, 8, 9, 14, 
    15, 12, 13, 2, 3, 0, 1, 6, 7, 4, 5, 26, 27, 24, 25, 30, 31, 28, 29, 18, 19, 
    16, 17, 22, 23, 20, 21, 98, 99, 96, 97, 102, 103, 100, 101, 93, 93, 92, 92, 
    95, 95, 94, 94, 116, 118, 112, 114, 124, 126, 120, 122, 106, 107, 104, 105, 
    110, 111, 108, 109, 72, 73, 70, 71, 76, 77, 74, 75, 64, 65, 63, 63, 68, 69, 
    66, 67, 86, 87, 84, 85, 90, 91, 88, 89, 79, 79, 78, 78, 82, 83, 80, 81, 170, 
    171, 168, 169, 174, 175, 172, 173, 162, 163, 160, 161, 166, 167, 164, 165,
    185, 186, 183, 184, 189, 190, 187, 188, 177, 178, 175, 176, 181, 182, 179, 
    180, 138, 139, 136, 137, 142, 143, 140, 141, 130, 131, 128, 129, 134, 135, 
    132, 133, 154, 155, 152, 153, 158, 159, 156, 157, 146, 147, 144, 145, 150, 
    151, 148, 149, 226, 227, 224, 225, 230, 231, 228, 229, 221, 221, 220, 220, 
    223, 223, 222, 222, 244, 246, 240, 242, 252, 254, 248, 250, 234, 235, 232, 
    233, 238, 239, 236, 237, 200, 201, 198, 199, 204, 205, 202, 203, 192, 193, 
    191, 191, 196, 197, 194, 195, 214, 215, 212, 213, 218, 219, 216, 217, 207, 
    207, 206, 206, 210, 211, 208, 209
]


proc linToAlawFrame*(f: int16): uint8 =
    ## encode a 16bit PCM frame to A-law
    var frame: int16 = f
    let sign = bitand((( bitnot(frame)) shr 8), 0x80)
    
    if sign == 0:
        frame = frame -% frame *% 2

    if frame > 0x7F7B:
        frame = 0x7F7B

    var comp: uint8
    if frame >= 256:
        let seg = alawSeg[bitand((frame shr 8) , 0x7F)]
        let b = bitand((frame shr (seg + 3)), 0x0F)
        comp = uint8(bitor((int16(seg) shl 4) , b))
    else:
        comp = uint8(frame shr 4)

    return bitxor(comp, uint8(bitxor(sign, 0x55)))


proc linToAlaw*(pcm: openArray[byte]): seq[byte] =
    ## encode a 16bit PCM data to A-law
    for i in 1..(len(pcm)) div 2:
        let n: int16 = bitxor(int16(pcm[i * 2 - 2]), int16(pcm[i * 2 - 1]) shl 8)
        result.add(linToAlawFrame(n))
 

proc alawToLinFrame*(frame: uint8): int16 =
    ## decodes A-law frame to 16bit PCM
    return alawToLinTable[frame]
    

proc alawToLin*(pcm: openArray[byte]): seq[byte] =
    ## decodes A-law data to 16bit PCM
    var frame: int16
    for i in 0..(len(pcm)-1):
        frame = alawToLinTable[pcm[i]]
        result.add(byte(frame))
        result.add(byte(frame shr 8))


proc alawToUlaw*(alaw: openArray[byte]): seq[byte] =
    ## alaw data to ulaw data conversion
    for i in 0..(len(alaw)-1):
        result.add(alawToUlawTable[alaw[i]])


proc alawToUlawFrame*(frame: uint8): uint8 =
    ## alaw data to ulaw data conversion
    return alawToUlawTable[frame]
