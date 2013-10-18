import numpy as np
from Attributes import *

class Particle:    
        
    def __init__(self, color, shape, symbol):
        self.color = color
        self.shape = shape
        self.symbol = symbol
        
    def __str__(self):
        return "(%s,%s,%s)" % (Color.MAP[self.color], Shape.MAP[self.shape], Symbol.MAP[self.symbol])
    
    def getAttr(self, attr):
        if attr == Color:
            return self.color
        elif attr == Shape:
            return self.shape
        else:
            return self.symbol
        
    def collide(self, other):        
    
        colors_in = np.matrix([self.color, other.color])
        shapes_in = np.matrix([self.shape, other.shape])
        symbols_in = np.matrix([self.symbol, other.symbol])
        
        colors_out = colors_in.dot(Color.TRANSFORM)
        shapes_out = shapes_in.dot(Shape.TRANSFORM)
        symbols_out = symbols_in.dot(Symbol.TRANSFORM)
        
        self_out = Particle(colors_out[0,0], shapes_out[0,0], symbols_out[0,0])
        other_out = Particle(colors_out[0,1], shapes_out[0,1], symbols_out[0,1])
                
        return (self_out, other_out)