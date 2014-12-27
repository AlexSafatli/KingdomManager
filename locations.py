''' Definitions for locations in the city. '''

# Date:   Dec 26 2014
# Author: Alex Safatli
# Email:  safatli@cs.dal.ca

from npc import character

class location(character):
    
    def __init__(self,name,traits=None,owner=None):
        super(self,location).__init__(name,traits)
        self.owner = owner
    
    def getOwner(self): return self.owner         
    
