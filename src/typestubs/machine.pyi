from typing import List, Union

_DataType = Union[bytes,bytearray,memoryview]
_BufferType = Union[bytearray,memoryview]

class Pin(object):
    def __init__(self, num:int): ...

class I2C(object):
    def __init__(self, sda:Pin, scl:Pin) -> None: ...
    def writeto(self, address:int, data:_DataType) -> None: ...
    def readfrom(self, address:int, length:int) -> bytes: ...
    def readfrom_into(self, address:int, buffer:_BufferType) -> None: ...
    def scan(self) -> List[int]: ...
