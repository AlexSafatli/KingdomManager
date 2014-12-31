''' A collection of code to facilitate NPC generation using FATE-style aspects, personality traits, and other information rather than system-dependent stats. '''

# Date:   Dec 26 2014
# Author: Alex Safatli
# Email:  safatli@cs.dal.ca

class character(object):
    
    def __init__(self,name,traits=None):
        self.name = name
        self.traits = []
        if traits != None: self.traits = traits
    
    def getName(self): return self.name
    def getTraits(self): return self.traits
    
    def hasTraits(self,trait):
        return (trait in self.traits)
    
class npc(character):
    
    def __init__(self,name,traits=None,profession='',home=None,work=None):
        super(self,npc).__init__(name,traits)
        self.profession = profession
        self.home = home        
        self.quests = []
        self.work = work
        
    def getProfession(self): return self.profession
    def getHome(self): return self.home        
    def getQuests(self): return self.quests
    def getWork(self): return self.work
    
        