class Color(object):
    import numpy as np
    
    BLUE   = 0
    ORANGE = 1
    GREEN  = 2
    RED    = 3
    MAP = ["BLUE", "ORANGE", "GREEN", "RED"]
    TRANSFORM = np.matrix([[+1, -1],
                           [-1, +1]])
    
    value = None
    
    def __init__(self, color):
        self.value = color
        
    def __str__(self):
        return self.MAP[self.value]
    
class Shape(object):
    import numpy as np
    
    CIRCLE   = 0
    TRIANGLE = 1
    SQUARE   = 2
    PENTAGON = 3
    MAP = ["CIRCLE", "TRIANGLE", "SQUARE", "PENTAGON"]
    TRANSFORM = np.matrix([[+1,  0],
                           [ 0, +1]])
    
    value = None
    
    def __init__(self, shape):
        self.value = shape
        
    def __str__(self):
        return self.MAP[self.value]
    
class Symbol(object):
    import numpy as np
    
    HEART   = 0
    SPADE   = 1
    DIAMOND = 2
    CLUB    = 3
    MAP = ["HEART", "SPADE", "DIAMOND", "CLUB"]
    TRANSFORM = np.matrix([[+1, -1],
                           [-1, +1]])
    
    value = None
    
    def __init__(self, symbol):
        self.value = symbol
        
    def __str__(self):
        return self.MAP[self.value]