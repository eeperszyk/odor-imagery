# Script to have participants rate their internal states (e.g., hunger/thirst/anxiety) and properties of odor stimuli delivered via an olfactometer (e.g., liking/intensity/familiarity) while laying inside of an fMRI scanner bore. They will use a button box and button click to move the arrows of the rating scales to the left or right.

# Created by Emily Perszyk in PsychoPy


#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
This experiment was created using PsychoPy3 Experiment Builder (v3.1.2),
    on February 27, 2020, at 11:51
If you publish work using this script please cite the PsychoPy publications:
    Peirce, JW (2007) PsychoPy - Psychophysics software in Python.
        Journal of Neuroscience Methods, 162(1-2), 8-13.3
    Peirce, JW (2009) Generating stimuli for neuroscience using PsychoPy.
        Frontiers in Neuroinformatics, 2:10. doi: 10.3389/neuro.11.010.2008
"""

from __future__ import absolute_import, division
from psychopy import locale_setup, sound, gui, visual, core, data, event, logging, clock
from psychopy.constants import (NOT_STARTED, STARTED, PLAYING, PAUSED,
                                STOPPED, FINISHED, PRESSED, RELEASED, FOREVER)
import numpy as np  # whole numpy lib is available, prepend 'np.'
from numpy import (sin, cos, tan, log, log10, pi, average,
                   sqrt, std, deg2rad, rad2deg, linspace, asarray)
from numpy.random import random, randint, normal, shuffle
import os  # handy system and path functions
import sys  # to get file system encoding

from psychopy.hardware import keyboard

# Ensure that relative paths start from the same directory as this script
_thisDir = os.path.dirname(os.path.abspath(__file__))
os.chdir(_thisDir)

# Store info about the experiment session
psychopyVersion = '3.1.2'
expName = 'pre-scan-ratings'  # from the Builder filename that created this script
expInfo = {'participant': '', 'session': '004'}
dlg = gui.DlgFromDict(dictionary=expInfo, sortKeys=False, title=expName)
if dlg.OK == False:
    core.quit()  # user pressed cancel
expInfo['date'] = data.getDateStr()  # add a simple timestamp
expInfo['expName'] = expName
expInfo['psychopyVersion'] = psychopyVersion

# Data file name stem = absolute path + name; later add .psyexp, .csv, .log, etc
filename = _thisDir + os.sep + u'data/%s_%s_%s' % (expInfo['participant'], expName, expInfo['date'])

# An ExperimentHandler isn't essential but helps with data saving
thisExp = data.ExperimentHandler(name=expName, version='',
    extraInfo=expInfo, runtimeInfo=None,
    originPath='C:\\Users\\eep29\\Documents\\Odor_imagery\\Tasks\\S4_tasks\\scan_ratings\\pre_scan_ratings.py',
    savePickle=True, saveWideText=True,
    dataFileName=filename)


endExpNow = False  # flag for 'escape' or other condition => quit the exp

# Start Code - component code to be run before the window creation

# Setup the Window
win = visual.Window(
    size=[1280, 720], fullscr=True, screen=1, 
    winType='pyglet', allowGUI=False, allowStencil=False,
    monitor='testMonitor', color='AliceBlue', colorSpace='rgb',
    blendMode='avg', useFBO=True, 
    units='pix')
# store frame rate of monitor if we can measure it
expInfo['frameRate'] = win.getActualFrameRate()
if expInfo['frameRate'] != None:
    frameDur = 1.0 / round(expInfo['frameRate'])
else:
    frameDur = 1.0 / 60.0  # could not measure, so guess

# create a default keyboard (e.g. to check for escape)
defaultKeyboard = keyboard.Keyboard()

# Initialize components for Routine "states"
statesClock = core.Clock()
states_text = visual.TextStim(win=win, name='states_text',
    text='default text',
    font='Arial',
    pos=(0, 300), height=50, wrapWidth=1000, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);
rating_slider = visual.Slider(win=win, name='rating_slider',
    size=(1.0, 0.1), pos=(0, -0.4),
    labels=None, ticks=(1, 2, 3, 4, 5),
    granularity=0, style=['triangleMarker'],
    color='LightGray', font='HelveticaBold',
    flip=False)
label1 = visual.TextStim(win=win, name='label1',
    text='default text',
    font='Arial',
    pos=(-600,-80), height=35, wrapWidth=250, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-3.0);
label2 = visual.TextStim(win=win, name='label2',
    text='default text',
    font='Arial',
    pos=(600,-80), height=35, wrapWidth=250, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-4.0);

# Initialize components for Routine "select_odor"
select_odorClock = core.Clock()
new_odor = visual.TextStim(win=win, name='new_odor',
    text='Odor:',
    font='Arial',
    pos=(-130, 180), height=40, wrapWidth=500, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);
select_odor_text = visual.TextStim(win=win, name='select_odor_text',
    text='default text',
    font='Arial',
    pos=(-30,100), height=70, wrapWidth=None, ori=0, 
    color='DarkGrey', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-1.0);
please_wait = visual.TextStim(win=win, name='please_wait',
    text='Please wait for experimenter.',
    font='Arial',
    pos=(0, -200), height=40, wrapWidth=1000, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-2.0);

# Initialize components for Routine "intense"
intenseClock = core.Clock()
intense_text = visual.TextStim(win=win, name='intense_text',
    text='How intense \nis this smell?',
    font='Arial',
    pos=(-200, 0), height=50, wrapWidth=1000, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);
intense_slider = visual.Slider(win=win, name='intense_slider',
    size=(1.0, 0.1), pos=(0, -0.4),
    labels=None, ticks=(1, 2, 3, 4, 5),
    granularity=0, style=['rating'],
    color='LightGray', font='HelveticaBold',
    flip=False)
intense_bottom_label = visual.TextStim(win=win, name='intense_bottom_label',
    text='No sensation',
    font='Arial',
    pos=(115,-400), height=20, wrapWidth=1000, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-3.0);

# Initialize components for Routine "familiarity"
familiarityClock = core.Clock()
familiarity_text = visual.TextStim(win=win, name='familiarity_text',
    text='How familiar is this smell?',
    font='Arial',
    pos=(0, 300), height=50, wrapWidth=1000, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);
familiarity_slider = visual.Slider(win=win, name='familiarity_slider',
    size=(1.0, 0.1), pos=(0, -0.4),
    labels=None, ticks=(1, 2, 3, 4, 5),
    granularity=0, style=['rating'],
    color='LightGray', font='HelveticaBold',
    flip=False)
familiarity_label1 = visual.TextStim(win=win, name='familiarity_label1',
    text='not at all familiar',
    font='Arial',
    pos=(-600, -80), height=35, wrapWidth=250, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-3.0);
familiarity_label2 = visual.TextStim(win=win, name='familiarity_label2',
    text='more familiar than anything',
    font='Arial',
    pos=(600, -80), height=35, wrapWidth=250, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-4.0);

# Initialize components for Routine "like"
likeClock = core.Clock()
like_text = visual.TextStim(win=win, name='like_text',
    text='How much do you like \nor dislike this smell?',
    font='Arial',
    pos=(-200, 0), height=50, wrapWidth=1000, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);
like_slider = visual.Slider(win=win, name='like_slider',
    size=(1000,10), pos=(0,0),
    labels=None, ticks=(0,1,2),
    granularity=0, style=['rating', 'triangleMarker'],
    color='LightGray', font='HelveticaBold',
    flip=False)
like_neutral_label = visual.TextStim(win=win, name='like_neutral_label',
    text='Neutral',
    font='Arial',
    pos=(150, 0), height=20, wrapWidth=None, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-3.0);

# Initialize components for Routine "want"
wantClock = core.Clock()
want_text = visual.TextStim(win=win, name='want_text',
    text='How much do you want to eat this?',
    font='Arial',
    pos=(0, 300), height=50, wrapWidth=1000, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);
want_slider = visual.Slider(win=win, name='want_slider',
    size=(1.0, 0.1), pos=(0, -0.4),
    labels=None, ticks=(1, 2, 3, 4, 5),
    granularity=0, style=['rating'],
    color='LightGray', font='HelveticaBold',
    flip=False)
want_label1 = visual.TextStim(win=win, name='want_label1',
    text='not at all',
    font='Arial',
    pos=(-600, -80), height=35, wrapWidth=250, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-3.0);
want_label2 = visual.TextStim(win=win, name='want_label2',
    text='more than anything',
    font='Arial',
    pos=(600, -80), height=35, wrapWidth=250, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-4.0);

# Create some handy timers
globalClock = core.Clock()  # to track the time since experiment started
routineTimer = core.CountdownTimer()  # to track time remaining of each (non-slip) routine 

# set up handler to look after randomisation of conditions etc
state_trials = data.TrialHandler(nReps=1, method='sequential', 
    extraInfo=expInfo, originPath=-1,
    trialList=data.importConditions('internal_states.xlsx'),
    seed=None, name='state_trials')
thisExp.addLoop(state_trials)  # add the loop to the experiment
thisState_trial = state_trials.trialList[0]  # so we can initialise stimuli with some values
# abbreviate parameter names if possible (e.g. rgb = thisState_trial.rgb)
if thisState_trial != None:
    for paramName in thisState_trial:
        exec('{} = thisState_trial[paramName]'.format(paramName))

for thisState_trial in state_trials:
    currentLoop = state_trials
    # abbreviate parameter names if possible (e.g. rgb = thisState_trial.rgb)
    if thisState_trial != None:
        for paramName in thisState_trial:
            exec('{} = thisState_trial[paramName]'.format(paramName))
    
    # ------Prepare to start Routine "states"-------
    t = 0
    statesClock.reset()  # clock
    frameN = -1
    continueRoutine = True
    # update component parameters for each repeat
    states_text.setText(Question)
    rating_slider.reset()
    rating_slider = visual.Slider(win=win, name='rating_slider',
        size=(1200, 30), pos=(0, 0),
        granularity=0, style=('triangleMarker','rating'), labelHeight=20, ticks = [0,1],
        color='MidnightBlue', font='Arial',
        flip=False);
    rating_slider.marker.size=(30,30);
    rating_slider.marker.color = 'red';
    rating_slider.markerPos = 0.5;
    label1.setText(LeftAnchor)
    label2.setText(RightAnchor)
    resp = keyboard.Keyboard()
    # keep track of which components have finished
    statesComponents = [states_text, rating_slider, label1, label2, resp]
    for thisComponent in statesComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    
    # -------Start Routine "states"-------
    while continueRoutine:
        # get current time
        t = statesClock.getTime()
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *states_text* updates
        if t >= 0.0 and states_text.status == NOT_STARTED:
            # keep track of start time/frame for later
            states_text.tStart = t  # not accounting for scr refresh
            states_text.frameNStart = frameN  # exact frame index
            win.timeOnFlip(states_text, 'tStartRefresh')  # time at next scr refresh
            states_text.setAutoDraw(True)
        
        # *rating_slider* updates
        if t >= 0.0 and rating_slider.status == NOT_STARTED:
            # keep track of start time/frame for later
            rating_slider.tStart = t  # not accounting for scr refresh
            rating_slider.frameNStart = frameN  # exact frame index
            win.timeOnFlip(rating_slider, 'tStartRefresh')  # time at next scr refresh
            rating_slider.setAutoDraw(True)
        keys = event.getKeys()
        if '1' in keys:
            rating_slider.markerPos -= .02
        if '2' in keys:
            rating_slider.markerPos += .02
        if 'escape' in keys:
            core.quit()
            rating_slider.draw()
            win.flip()
        
        if resp.keys == '3':
            continueRoutine = False
        
        # *label1* updates
        if t >= 0.0 and label1.status == NOT_STARTED:
            # keep track of start time/frame for later
            label1.tStart = t  # not accounting for scr refresh
            label1.frameNStart = frameN  # exact frame index
            win.timeOnFlip(label1, 'tStartRefresh')  # time at next scr refresh
            label1.setAutoDraw(True)
        
        # *label2* updates
        if t >= 0.0 and label2.status == NOT_STARTED:
            # keep track of start time/frame for later
            label2.tStart = t  # not accounting for scr refresh
            label2.frameNStart = frameN  # exact frame index
            win.timeOnFlip(label2, 'tStartRefresh')  # time at next scr refresh
            label2.setAutoDraw(True)
        
        # *resp* updates
        if t >= 0.0 and resp.status == NOT_STARTED:
            # keep track of start time/frame for later
            resp.tStart = t  # not accounting for scr refresh
            resp.frameNStart = frameN  # exact frame index
            win.timeOnFlip(resp, 'tStartRefresh')  # time at next scr refresh
            resp.status = STARTED
            # keyboard checking is just starting
            resp.clearEvents(eventType='keyboard')
        if resp.status == STARTED:
            theseKeys = resp.getKeys(keyList=['3', 'num_1', 'num_2'], waitRelease=False)
            if len(theseKeys):
                theseKeys = theseKeys[0]  # at least one key was pressed
                
                # check for quit:
                if "escape" == theseKeys:
                    endExpNow = True
                # a response ends the routine
                continueRoutine = False
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in statesComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "states"-------
    for thisComponent in statesComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    thisExp.addData("StatesRating",rating_slider.markerPos)
    rating_slider.reset()
    
    # the Routine "states" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    thisExp.nextEntry()
    
# completed 1 repeats of 'state_trials'


# set up handler to look after randomisation of conditions etc
odor_trials = data.TrialHandler(nReps=1, method='random', 
    extraInfo=expInfo, originPath=-1,
    trialList=data.importConditions('odors.xlsx'),
    seed=None, name='odor_trials')
thisExp.addLoop(odor_trials)  # add the loop to the experiment
thisOdor_trial = odor_trials.trialList[0]  # so we can initialise stimuli with some values
# abbreviate parameter names if possible (e.g. rgb = thisOdor_trial.rgb)
if thisOdor_trial != None:
    for paramName in thisOdor_trial:
        exec('{} = thisOdor_trial[paramName]'.format(paramName))

for thisOdor_trial in odor_trials:
    currentLoop = odor_trials
    # abbreviate parameter names if possible (e.g. rgb = thisOdor_trial.rgb)
    if thisOdor_trial != None:
        for paramName in thisOdor_trial:
            exec('{} = thisOdor_trial[paramName]'.format(paramName))
    
    # ------Prepare to start Routine "select_odor"-------
    t = 0
    select_odorClock.reset()  # clock
    frameN = -1
    continueRoutine = True
    # update component parameters for each repeat
    select_odor_text.setText(Odor)
    return_key = keyboard.Keyboard()
    # keep track of which components have finished
    select_odorComponents = [new_odor, select_odor_text, please_wait, return_key]
    for thisComponent in select_odorComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    
    # -------Start Routine "select_odor"-------
    while continueRoutine:
        # get current time
        t = select_odorClock.getTime()
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *new_odor* updates
        if t >= 0.0 and new_odor.status == NOT_STARTED:
            # keep track of start time/frame for later
            new_odor.tStart = t  # not accounting for scr refresh
            new_odor.frameNStart = frameN  # exact frame index
            win.timeOnFlip(new_odor, 'tStartRefresh')  # time at next scr refresh
            new_odor.setAutoDraw(True)
        
        # *select_odor_text* updates
        if t >= 0.0 and select_odor_text.status == NOT_STARTED:
            # keep track of start time/frame for later
            select_odor_text.tStart = t  # not accounting for scr refresh
            select_odor_text.frameNStart = frameN  # exact frame index
            win.timeOnFlip(select_odor_text, 'tStartRefresh')  # time at next scr refresh
            select_odor_text.setAutoDraw(True)
        
        # *please_wait* updates
        if t >= 0.0 and please_wait.status == NOT_STARTED:
            # keep track of start time/frame for later
            please_wait.tStart = t  # not accounting for scr refresh
            please_wait.frameNStart = frameN  # exact frame index
            win.timeOnFlip(please_wait, 'tStartRefresh')  # time at next scr refresh
            please_wait.setAutoDraw(True)
        
        # *return_key* updates
        if t >= 0.0 and return_key.status == NOT_STARTED:
            # keep track of start time/frame for later
            return_key.tStart = t  # not accounting for scr refresh
            return_key.frameNStart = frameN  # exact frame index
            win.timeOnFlip(return_key, 'tStartRefresh')  # time at next scr refresh
            return_key.status = STARTED
            # keyboard checking is just starting
            return_key.clearEvents(eventType='keyboard')
        if return_key.status == STARTED:
            theseKeys = return_key.getKeys(keyList=['return'], waitRelease=False)
            if len(theseKeys):
                theseKeys = theseKeys[0]  # at least one key was pressed
                
                # check for quit:
                if "escape" == theseKeys:
                    endExpNow = True
                # a response ends the routine
                continueRoutine = False
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in select_odorComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "select_odor"-------
    for thisComponent in select_odorComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    # the Routine "select_odor" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    
    # ------Prepare to start Routine "intense"-------
    t = 0
    intenseClock.reset()  # clock
    frameN = -1
    continueRoutine = True
    # update component parameters for each repeat
    intense_slider.reset()
    intense_slider = visual.Slider(win=win, name='intense_slider',
        size=(20, 800), pos=(200, 0),
        labels=('','Barely detectable', 'Weak', 'Moderate', 'Strong', 'Very strong', 'Strongest imaginable sensation of any kind'), 
        ticks=(0, 1.4,6,17,35,51,100),
        granularity=0, style=('triangleMarker','rating'), labelHeight=20,
        color='MidnightBlue', font='Arial',
        autoLog = True, flip=True);
    intense_slider.marker.size=(30,30);
    intense_slider.marker.color = 'red';
    intense_slider.markerPos = 0;
    resp2 = keyboard.Keyboard()
    # keep track of which components have finished
    intenseComponents = [intense_text, intense_slider, intense_bottom_label, resp2]
    for thisComponent in intenseComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    
    # -------Start Routine "intense"-------
    while continueRoutine:
        # get current time
        t = intenseClock.getTime()
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *intense_text* updates
        if t >= 0.0 and intense_text.status == NOT_STARTED:
            # keep track of start time/frame for later
            intense_text.tStart = t  # not accounting for scr refresh
            intense_text.frameNStart = frameN  # exact frame index
            win.timeOnFlip(intense_text, 'tStartRefresh')  # time at next scr refresh
            intense_text.setAutoDraw(True)
        
        # *intense_slider* updates
        if t >= 0.0 and intense_slider.status == NOT_STARTED:
            # keep track of start time/frame for later
            intense_slider.tStart = t  # not accounting for scr refresh
            intense_slider.frameNStart = frameN  # exact frame index
            win.timeOnFlip(intense_slider, 'tStartRefresh')  # time at next scr refresh
            intense_slider.setAutoDraw(True)
        
        # Check intense_slider for response to end routine
        if intense_slider.getRating() is not None and intense_slider.status == STARTED:
            continueRoutine = False
        keys = event.getKeys()
        if '1' in keys:
            intense_slider.markerPos-= 2
        if '2' in keys:
            intense_slider.markerPos+= 2
        if 'escape' in keys:
            core.quit()
            intense_slider.draw()
            win.flip()
        
        if resp2.keys == '3':
            continueRoutine = False
        
        # *intense_bottom_label* updates
        if t >= 0.0 and intense_bottom_label.status == NOT_STARTED:
            # keep track of start time/frame for later
            intense_bottom_label.tStart = t  # not accounting for scr refresh
            intense_bottom_label.frameNStart = frameN  # exact frame index
            win.timeOnFlip(intense_bottom_label, 'tStartRefresh')  # time at next scr refresh
            intense_bottom_label.setAutoDraw(True)
        
        # *resp2* updates
        if t >= 0.0 and resp2.status == NOT_STARTED:
            # keep track of start time/frame for later
            resp2.tStart = t  # not accounting for scr refresh
            resp2.frameNStart = frameN  # exact frame index
            win.timeOnFlip(resp2, 'tStartRefresh')  # time at next scr refresh
            resp2.status = STARTED
            # keyboard checking is just starting
            resp2.clearEvents(eventType='keyboard')
        if resp2.status == STARTED:
            theseKeys = resp2.getKeys(keyList=['3'], waitRelease=False)
            if len(theseKeys):
                theseKeys = theseKeys[0]  # at least one key was pressed
                
                # check for quit:
                if "escape" == theseKeys:
                    endExpNow = True
                # a response ends the routine
                continueRoutine = False
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in intenseComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "intense"-------
    for thisComponent in intenseComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    odor_trials.addData('intense_slider.response', intense_slider.getRating())
    thisExp.addData("Intensity",intense_slider.markerPos)
    intense_slider.reset()
    
    # the Routine "intense" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    
    # ------Prepare to start Routine "familiarity"-------
    t = 0
    familiarityClock.reset()  # clock
    frameN = -1
    continueRoutine = True
    # update component parameters for each repeat
    familiarity_slider.reset()
    familiarity_slider = visual.Slider(win=win, name='intense_slider',
        size=(1200, 30), pos=(0, 0),
        granularity=0, style=('triangleMarker','rating'), labelHeight=20, ticks = [0,1],
        color='MidnightBlue', font='Arial',
        autoLog = True, flip=False);
    familiarity_slider.marker.size=(30,30);
    familiarity_slider.marker.color = 'red';
    familiarity_slider.markerPos = 0.5;
    resp3 = keyboard.Keyboard()
    # keep track of which components have finished
    familiarityComponents = [familiarity_text, familiarity_slider, familiarity_label1, familiarity_label2, resp3]
    for thisComponent in familiarityComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    
    # -------Start Routine "familiarity"-------
    while continueRoutine:
        # get current time
        t = familiarityClock.getTime()
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *familiarity_text* updates
        if t >= 0.0 and familiarity_text.status == NOT_STARTED:
            # keep track of start time/frame for later
            familiarity_text.tStart = t  # not accounting for scr refresh
            familiarity_text.frameNStart = frameN  # exact frame index
            win.timeOnFlip(familiarity_text, 'tStartRefresh')  # time at next scr refresh
            familiarity_text.setAutoDraw(True)
        
        # *familiarity_slider* updates
        if t >= 0.0 and familiarity_slider.status == NOT_STARTED:
            # keep track of start time/frame for later
            familiarity_slider.tStart = t  # not accounting for scr refresh
            familiarity_slider.frameNStart = frameN  # exact frame index
            win.timeOnFlip(familiarity_slider, 'tStartRefresh')  # time at next scr refresh
            familiarity_slider.setAutoDraw(True)
        
        # Check familiarity_slider for response to end routine
        if familiarity_slider.getRating() is not None and familiarity_slider.status == STARTED:
            continueRoutine = False
        keys = event.getKeys()
        if '1' in keys:
            familiarity_slider.markerPos -= .02
        if '2' in keys:
            familiarity_slider.markerPos += .02
        if 'escape' in keys:
            core.quit()
            familiarity_slider.draw()
            win.flip()
        
        if resp3.keys == '3':
            continueRoutine = False
        
        # *familiarity_label1* updates
        if t >= 0.0 and familiarity_label1.status == NOT_STARTED:
            # keep track of start time/frame for later
            familiarity_label1.tStart = t  # not accounting for scr refresh
            familiarity_label1.frameNStart = frameN  # exact frame index
            win.timeOnFlip(familiarity_label1, 'tStartRefresh')  # time at next scr refresh
            familiarity_label1.setAutoDraw(True)
        
        # *familiarity_label2* updates
        if t >= 0.0 and familiarity_label2.status == NOT_STARTED:
            # keep track of start time/frame for later
            familiarity_label2.tStart = t  # not accounting for scr refresh
            familiarity_label2.frameNStart = frameN  # exact frame index
            win.timeOnFlip(familiarity_label2, 'tStartRefresh')  # time at next scr refresh
            familiarity_label2.setAutoDraw(True)
        
        # *resp3* updates
        if t >= 0.0 and resp3.status == NOT_STARTED:
            # keep track of start time/frame for later
            resp3.tStart = t  # not accounting for scr refresh
            resp3.frameNStart = frameN  # exact frame index
            win.timeOnFlip(resp3, 'tStartRefresh')  # time at next scr refresh
            resp3.status = STARTED
            # keyboard checking is just starting
            resp3.clearEvents(eventType='keyboard')
        if resp3.status == STARTED:
            theseKeys = resp3.getKeys(keyList=['3'], waitRelease=False)
            if len(theseKeys):
                theseKeys = theseKeys[0]  # at least one key was pressed
                
                # check for quit:
                if "escape" == theseKeys:
                    endExpNow = True
                # a response ends the routine
                continueRoutine = False
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in familiarityComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "familiarity"-------
    for thisComponent in familiarityComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    odor_trials.addData('familiarity_slider.response', familiarity_slider.getRating())
    thisExp.addData("Familiarity",familiarity_slider.markerPos)
    familiarity_slider.reset()
    
    # the Routine "familiarity" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    
    # ------Prepare to start Routine "like"-------
    t = 0
    likeClock.reset()  # clock
    frameN = -1
    continueRoutine = True
    # update component parameters for each repeat
    like_slider.reset()
    like_slider = visual.Slider(win=win, name='like_slider',
        size=(20, 800), pos=(200, 0),
        labels=('Most disliked sensation imaginable','Dislike extremely','Dislike very much','Dislike moderately','Dislike slightly',' ','Like slightly','Like moderately','Like very much','Like extremely','Most liked sensation imaginable'), 
        ticks=(-100, -62.89, -41.58, -17.59, -5.92, 0, 6.25, 17.82, 44.43, 65.72, 100),
        granularity=0, style=('triangleMarker','rating'), labelHeight=20,
        color='MidnightBlue', font='Arial',
        autoLog = True, flip=True);
    like_slider.marker.size=(30,30);
    like_slider.marker.color = 'red';
    like_slider.markerPos = 0;
    resp4 = keyboard.Keyboard()
    # keep track of which components have finished
    likeComponents = [like_text, like_slider, like_neutral_label, resp4]
    for thisComponent in likeComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    
    # -------Start Routine "like"-------
    while continueRoutine:
        # get current time
        t = likeClock.getTime()
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *like_text* updates
        if t >= 0.0 and like_text.status == NOT_STARTED:
            # keep track of start time/frame for later
            like_text.tStart = t  # not accounting for scr refresh
            like_text.frameNStart = frameN  # exact frame index
            win.timeOnFlip(like_text, 'tStartRefresh')  # time at next scr refresh
            like_text.setAutoDraw(True)
        
        # *like_slider* updates
        if t >= 0.0 and like_slider.status == NOT_STARTED:
            # keep track of start time/frame for later
            like_slider.tStart = t  # not accounting for scr refresh
            like_slider.frameNStart = frameN  # exact frame index
            win.timeOnFlip(like_slider, 'tStartRefresh')  # time at next scr refresh
            like_slider.setAutoDraw(True)
        
        # Check like_slider for response to end routine
        if like_slider.getRating() is not None and like_slider.status == STARTED:
            continueRoutine = False
        keys = event.getKeys()
        if '1' in keys:
            like_slider.markerPos -= 4
        if '2' in keys:
            like_slider.markerPos += 4
        if 'escape' in keys:
            core.quit()
            like_slider.draw()
            win.flip()
        
        if resp4.keys == '3':
            continueRoutine = False
        
        # *like_neutral_label* updates
        if t >= 0.0 and like_neutral_label.status == NOT_STARTED:
            # keep track of start time/frame for later
            like_neutral_label.tStart = t  # not accounting for scr refresh
            like_neutral_label.frameNStart = frameN  # exact frame index
            win.timeOnFlip(like_neutral_label, 'tStartRefresh')  # time at next scr refresh
            like_neutral_label.setAutoDraw(True)
        
        # *resp4* updates
        if t >= 0.0 and resp4.status == NOT_STARTED:
            # keep track of start time/frame for later
            resp4.tStart = t  # not accounting for scr refresh
            resp4.frameNStart = frameN  # exact frame index
            win.timeOnFlip(resp4, 'tStartRefresh')  # time at next scr refresh
            resp4.status = STARTED
            # keyboard checking is just starting
            resp4.clearEvents(eventType='keyboard')
        if resp4.status == STARTED:
            theseKeys = resp4.getKeys(keyList=['3'], waitRelease=False)
            if len(theseKeys):
                theseKeys = theseKeys[0]  # at least one key was pressed
                
                # check for quit:
                if "escape" == theseKeys:
                    endExpNow = True
                # a response ends the routine
                continueRoutine = False
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in likeComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "like"-------
    for thisComponent in likeComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    odor_trials.addData('like_slider.response', like_slider.getRating())
    thisExp.addData("Liking",like_slider.markerPos)
    like_slider.reset()
    
    # the Routine "like" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    
    # ------Prepare to start Routine "want"-------
    t = 0
    wantClock.reset()  # clock
    frameN = -1
    continueRoutine = True
    # update component parameters for each repeat
    want_slider.reset()
    want_slider = visual.Slider(win=win, name='want_slider',
        size=(1200, 30), pos=(0, 0),
        granularity=0, style=('triangleMarker','rating'), labelHeight=20, ticks = [0,1],
        color='MidnightBlue', font='Arial',
        autoLog = True, flip=False);
    want_slider.marker.size=(30,30);
    want_slider.marker.color = 'red';
    want_slider.markerPos = 0.5;
    resp5 = keyboard.Keyboard()
    # keep track of which components have finished
    wantComponents = [want_text, want_slider, want_label1, want_label2, resp5]
    for thisComponent in wantComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    
    # -------Start Routine "want"-------
    while continueRoutine:
        # get current time
        t = wantClock.getTime()
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *want_text* updates
        if t >= 0.0 and want_text.status == NOT_STARTED:
            # keep track of start time/frame for later
            want_text.tStart = t  # not accounting for scr refresh
            want_text.frameNStart = frameN  # exact frame index
            win.timeOnFlip(want_text, 'tStartRefresh')  # time at next scr refresh
            want_text.setAutoDraw(True)
        
        # *want_slider* updates
        if t >= 0.0 and want_slider.status == NOT_STARTED:
            # keep track of start time/frame for later
            want_slider.tStart = t  # not accounting for scr refresh
            want_slider.frameNStart = frameN  # exact frame index
            win.timeOnFlip(want_slider, 'tStartRefresh')  # time at next scr refresh
            want_slider.setAutoDraw(True)
        
        # Check want_slider for response to end routine
        if want_slider.getRating() is not None and want_slider.status == STARTED:
            continueRoutine = False
        keys = event.getKeys()
        if '1' in keys:
            want_slider.markerPos -= .02
        if '2' in keys:
            want_slider.markerPos += .02
        if 'escape' in keys:
            core.quit()
            want_slider.draw()
            win.flip()
        
        if resp5.keys == '3':
            continueRoutine = False
        
        # *want_label1* updates
        if t >= 0.0 and want_label1.status == NOT_STARTED:
            # keep track of start time/frame for later
            want_label1.tStart = t  # not accounting for scr refresh
            want_label1.frameNStart = frameN  # exact frame index
            win.timeOnFlip(want_label1, 'tStartRefresh')  # time at next scr refresh
            want_label1.setAutoDraw(True)
        
        # *want_label2* updates
        if t >= 0.0 and want_label2.status == NOT_STARTED:
            # keep track of start time/frame for later
            want_label2.tStart = t  # not accounting for scr refresh
            want_label2.frameNStart = frameN  # exact frame index
            win.timeOnFlip(want_label2, 'tStartRefresh')  # time at next scr refresh
            want_label2.setAutoDraw(True)
        
        # *resp5* updates
        if t >= 0.0 and resp5.status == NOT_STARTED:
            # keep track of start time/frame for later
            resp5.tStart = t  # not accounting for scr refresh
            resp5.frameNStart = frameN  # exact frame index
            win.timeOnFlip(resp5, 'tStartRefresh')  # time at next scr refresh
            resp5.status = STARTED
            # keyboard checking is just starting
            resp5.clearEvents(eventType='keyboard')
        if resp5.status == STARTED:
            theseKeys = resp5.getKeys(keyList=['3'], waitRelease=False)
            if len(theseKeys):
                theseKeys = theseKeys[0]  # at least one key was pressed
                
                # check for quit:
                if "escape" == theseKeys:
                    endExpNow = True
                # a response ends the routine
                continueRoutine = False
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in wantComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "want"-------
    for thisComponent in wantComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    odor_trials.addData('want_slider.response', want_slider.getRating())
    thisExp.addData("Wanting",want_slider.markerPos)
    want_slider.reset()
    
    # the Routine "want" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    thisExp.nextEntry()
    
# completed 1 repeats of 'odor_trials'


# Flip one final time so any remaining win.callOnFlip() 
# and win.timeOnFlip() tasks get executed before quitting
win.flip()

# these shouldn't be strictly necessary (should auto-save)
thisExp.saveAsWideText(filename+'.csv')
thisExp.saveAsPickle(filename)
logging.flush()
# make sure everything is closed down
thisExp.abort()  # or data files will save again on exit
win.close()
core.quit()
