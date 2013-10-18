from Particle import Particle
from Attributes import *

def pretty_print(p1in, p2in, p1out, p2out, attr = None):    
    FORMAT = "{} + {} --> {} + {}"
    if not (attr == None): 
        attrmap = attr.MAP
        print FORMAT.format(attrmap[p1in.getAttr(attr)], attrmap[p2in.getAttr(attr)], attrmap[p1out.getAttr(attr)], attrmap[p2out.getAttr(attr)])
    else:        
        print FORMAT.format(p1in, p2in, p1out, p2out)
    
p1in = Particle(Color.BLUE, Shape.CIRCLE, Symbol.HEART)
p2in = Particle(Color.RED, Shape.SQUARE, Symbol.SPADE)
(p1out, p2out) = p1in.collide(p2in)

pretty_print(p1in, p2in, p1out, p2out)
#pretty_print(p1in, p2in, p1out, p2out, attr = Color)
#pretty_print(p1in, p2in, p1out, p2out, attr = Shape)
#pretty_print(p1in, p2in, p1out, p2out, attr = Symbol)