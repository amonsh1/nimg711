# nimg711

This package implements decoding and encoding PCM data

## Installation

```nimble install https://github.com/amonsh1/nimg711```

## Usage

```nim
import nimg711

when isMainModule:
    let alaw =  @[0'u8, 0, 52, 18, 103, 69]
    let lin = alawToLin(alaw)
    doAssert linToAlaw(lin) == alaw
```
