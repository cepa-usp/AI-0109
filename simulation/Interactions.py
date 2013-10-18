from Particle import Particle
from Attributes import *

def pretty_print(p1in, p2in, p1out, p2out, attr = None):    
    FORMAT = "{} + {} --> {} + {}"
    if not (attr == None): 
        attrmap = attr.MAP
        print FORMAT.format(attrmap[p1in.getAttr(attr)], attrmap[p2in.getAttr(attr)], attrmap[p1out.getAttr(attr)], attrmap[p2out.getAttr(attr)])
    else:        
        print FORMAT.format(p1in, p2in, p1out, p2out)
    
def wrap(x):
    if x == -1: return 3
    if x == -2: return 2
    if x == -3: return 1
    return x
    
p1in = Particle(Color.BLUE, Shape.CIRCLE, Symbol.HEART)
p2in = Particle(Color.RED, Shape.SQUARE, Symbol.SPADE)
(p1out, p2out) = p1in.collide(p2in)

pretty_print(p1in, p2in, p1out, p2out)
#pretty_print(p1in, p2in, p1out, p2out, attr = Color)
#pretty_print(p1in, p2in, p1out, p2out, attr = Shape)
#pretty_print(p1in, p2in, p1out, p2out, attr = Symbol)

line = ["\t0\t1\t2\t3\n"]
for x in range(4):
    line.append("%d\t" % x)
    p1in = Particle(x, Shape.CIRCLE, Symbol.HEART)
    for y in range(4):        
        p2in = Particle(y, Shape.CIRCLE, Symbol.HEART)
        (p1out, p2out) = p1in.collide(p2in)
        line.append("%d\t" % wrap(p1out.color))
    line.append("\n")
    
print "".join(line)