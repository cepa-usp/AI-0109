class Color(object):
    import numpy as np
    
    GREEN  = 0
    ORANGE = 1
    BLUE   = 2
    RED    = 3
    MAP = ["GREEN", "ORANGE", "BLUE", "RED"]
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
    
    COPA   = 0
    ESPADA = 1
    OURO   = 2
    PAU    = 3
    MAP = ["COPA", "ESPADA", "OURO", "PAU"]
    TRANSFORM = np.matrix([[+1, -1],
                           [-1, +1]])
    
    value = None
    
    def __init__(self, symbol):
        self.value = symbol
        
    def __str__(self):
        return self.MAP[self.value]