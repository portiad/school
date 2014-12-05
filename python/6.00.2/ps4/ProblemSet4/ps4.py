# 6.00.2x Problem Set 4

import numpy
import random
import pylab
from ps3b import *

#
# PROBLEM 1
#        
def simulationDelayedTreatment(numTrials):
    """
    Runs simulations and make histograms for problem 1.

    Runs numTrials simulations to show the relationship between delayed
    treatment and patient outcome using a histogram.

    Histograms of final total virus populations are displayed for delays of 300,
    150, 75, 0 timesteps (followed by an additional 150 timesteps of
    simulation).

    numTrials: number of simulation runs to execute (an integer)
    """
    numViruses = 100
    maxPop = 1000
    maxBirthProb = .1
    clearProb =.05
    resistances = {'guttagonol': False}
    mutProb = .0005
    
    timeSteps, treatStep = 150, 150
    totalVs = [0] * timeSteps  
    
    # run number of trials
    for trial in range(numTrials):
                
        # instantiate viruses and patient
        viruses = []
        for i in range(numViruses):
            viruses.append(ResistantVirus(maxBirthProb, clearProb, resistances, mutProb))
        patient = TreatedPatient(viruses, maxPop)
        
        # update total virus population
        # add drug
        # repeat above
        for step in range(timeSteps):
            if step == treatStep:
                patient.addPrescription('guttagonol')
            patient.update()
            totalVs[step] += patient.getTotalPop()

    # average results
    for step in range(timeSteps):
        totalVs[step] = float(totalVs[step]) / numTrials
    
    pylab.hist(totalVs, label='Total Virus Pop.')
    pylab.title('Virus simulation')
    pylab.xlabel('time step')

#
# PROBLEM 2
#
def simulationTwoDrugsDelayedTreatment(numTrials):
    """
    Runs simulations and make histograms for problem 2.

    Runs numTrials simulations to show the relationship between administration
    of multiple drugs and patient outcome.

    Histograms of final total virus populations are displayed for lag times of
    300, 150, 75, 0 timesteps between adding drugs (followed by an additional
    150 timesteps of simulation).

    numTrials: number of simulation runs to execute (an integer)
    """
    numViruses = 100
    maxPop = 1000
    maxBirthProb = .1
    clearProb =.05
    resistances = {'guttagonol': False}
    mutProb = .0005
    
    timeSteps, treatStep1, treatStep2 = 150, 0, 150
    totalSteps = timeSteps  + treatStep1 + treatStep2
    totalVs = [0] * totalSteps
    
    # run number of trials
    for trial in range(numTrials):
                
        # instantiate viruses and patient
        viruses = []
        for i in range(numViruses):
            viruses.append(ResistantVirus(maxBirthProb, clearProb, resistances, mutProb))
        patient = TreatedPatient(viruses, maxPop)
        
        # update total virus population
        # add drug
        # repeat above
        for step in range(timeSteps):
            if step == treatStep1:
                patient.addPrescription('guttagonol')
                if step ==treatStep2:
                    patient.addPrescription('grimpex')
            patient.update()
            totalVs[step] += patient.getTotalPop()

    # average results
    for step in range(timeSteps):
        totalVs[step] = float(totalVs[step]) / numTrials
    
    pylab.hist(totalVs, label='Total Virus Pop.')
    pylab.title('Virus simulation')
    pylab.xlabel('time step')
