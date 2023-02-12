# Script for participants to compare the sensory properties of two types of cookies (cookie A/cookie B) labeled on plates in front of them (aka, a bogus taste test). The participants should not be explicitly made aware of the fact that the primary goal of the task is for the researcher to determine how much was consumed (weigh the cookie plates prior to and after the task is complete). Task time was 10 minutes.

# Created by Emily Perszyk in PsychoPy

#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
This experiment was created using PsychoPy3 Experiment Builder (v3.1.2),
    on October 08, 2020, at 14:55
If you publish work using this script please cite the PsychoPy publications:
    Peirce, JW (2007) PsychoPy - Psychophysics software in Python.
        Journal of Neuroscience Methods, 162(1-2), 8-13.
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
expName = 'taste_test'  # from the Builder filename that created this script
expInfo = {'participant': '', 'session': 'fMRI_training'}
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
    originPath='C:\\Users\\eep29\\Documents\\Odor_imagery\\Tasks\\S2_S3_tasks\\fMRI_training_day\\taste_test\\taste_test.py',
    savePickle=True, saveWideText=True,
    dataFileName=filename)
logging.console.setLevel(logging.WARNING)  # this outputs to the screen, not a file

endExpNow = False  # flag for 'escape' or other condition => quit the exp

# Start Code - component code to be run before the window creation

# Setup the Window
win = visual.Window(
    size=[1280, 720], fullscr=True, screen=0, 
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
    units='pix', pos=(0, 300), height=50, wrapWidth=1500, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);
rating_slider = visual.Slider(win=win, name='rating_slider',
    size=(1.0, 0.1), pos=(0, -0.4),
    labels=None, ticks=(1, 2, 3, 4, 5),
    granularity=0, style=['rating'],
    color='LightGray', font='HelveticaBold',
    flip=False)
rating_slider = visual.Slider(win=win, name='rating_slider',
    size=(1200, 30), pos=(0, 0),
    granularity=0, style=('triangleMarker','rating'), labelHeight=20, ticks = [0,1],
    color='MidnightBlue', font='Arial',
    autoLog = True, flip=False);
rating_slider.marker.size=(30,30);
rating_slider.marker.color = 'red';
label1 = visual.TextStim(win=win, name='label1',
    text='default text',
    font='Arial',
    units='pix', pos=(-600,-80), height=35, wrapWidth=None, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-3.0);
label2 = visual.TextStim(win=win, name='label2',
    text='default text',
    font='Arial',
    units='pix', pos=(600,-80), height=35, wrapWidth=None, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-4.0);

# Initialize components for Routine "wait"
waitClock = core.Clock()
please_wait2 = visual.TextStim(win=win, name='please_wait2',
    text='Please wait for the experimenter.\n\n\n\nPress enter to continue.',
    font='Arial',
    pos=(0, 0), height=50, wrapWidth=1500, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);

# Initialize components for Routine "instr"
instrClock = core.Clock()
taste_instr = visual.TextStim(win=win, name='taste_instr',
    text='Instructions:\n\nOver the next 10 minutes, please answer the following questions about the cookies in front of you. There will be 14 total questions, 4 specific to Cookie A, 4 to Cookie B, and 6 in which you will compare the two brands.\n\nPress enter to continue.',
    font='Arial',
    pos=(0, 0), height=50, wrapWidth=1500, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);

# Initialize components for Routine "select_brand"
select_brandClock = core.Clock()
new_cookie = visual.TextStim(win=win, name='new_cookie',
    text='Please make the following ratings for:\n\nCookie',
    font='Arial',
    pos=(0,180), height=50, wrapWidth=None, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);
select_cookie_text = visual.TextStim(win=win, name='select_cookie_text',
    text='default text',
    font='Arial',
    pos=(-30, 98), height=50, wrapWidth=None, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-1.0);
press_enter = visual.TextStim(win=win, name='press_enter',
    text='\nPress enter to continue.',
    font='Arial',
    pos=(0, -200), height=50, wrapWidth=1500, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-2.0);

# Initialize components for Routine "sweet"
sweetClock = core.Clock()
sweet_text = visual.TextStim(win=win, name='sweet_text',
    text='Rate the sweetness\nof Cookie',
    font='Arial',
    pos=(-200, 100), height=50, wrapWidth=1500, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);
sweet_slider = visual.Slider(win=win, name='sweet_slider',
    size=(1.0, 0.1), pos=(0, -0.4),
    labels=None, ticks=(1, 2, 3, 4, 5),
    granularity=0, style=['rating'],
    color='LightGray', font='HelveticaBold',
    flip=False)
sweet_bottom_label = visual.TextStim(win=win, name='sweet_bottom_label',
    text='No sensation',
    font='Arial',
    pos=(115, -400), height=20, wrapWidth=None, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-3.0);
brand1 = visual.TextStim(win=win, name='brand1',
    text='default text',
    font='Arial',
    pos=(-170,73), height=50, wrapWidth=None, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-4.0);

# Initialize components for Routine "salty"
saltyClock = core.Clock()
intense_text = visual.TextStim(win=win, name='intense_text',
    text='Rate the saltiness \nof Cookie ',
    font='Arial',
    pos=(-200,100), height=50, wrapWidth=1500, ori=0, 
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
    pos=(115, -400), height=20, wrapWidth=None, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-3.0);
brand2 = visual.TextStim(win=win, name='brand2',
    text='default text',
    font='Arial',
    pos=(-160, 73), height=50, wrapWidth=None, ori=0, 
    color='Midnightblue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-4.0);

# Initialize components for Routine "frequency"
frequencyClock = core.Clock()
frequency_text = visual.TextStim(win=win, name='frequency_text',
    text='How often do you eat cookies like Cookie   ?',
    font='Arial',
    pos=(0, 300), height=50, wrapWidth=1500, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);
frequency_slider = visual.Slider(win=win, name='frequency_slider',
    size=(1.0, 0.1), pos=(0, -0.4),
    labels=None, ticks=(0,1,2,3,4,5),
    granularity=0, style=['rating'],
    color='LightGray', font='HelveticaBold',
    flip=False)
brand3 = visual.TextStim(win=win, name='brand3',
    text='default text',
    font='Arial',
    pos=(455, 300), height=50, wrapWidth=None, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-3.0);

# Initialize components for Routine "like"
likeClock = core.Clock()
like_text = visual.TextStim(win=win, name='like_text',
    text='How much do you like \nor dislike Cookie   ?',
    font='Arial',
    pos=(-200,100), height=50, wrapWidth=2000, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);
like_slider = visual.Slider(win=win, name='like_slider',
    size=(10000,10), pos=(0, 0),
    labels=None, ticks=(0, 1, 2),
    granularity=0, style=['rating'],
    color='LightGray', font='HelveticaBold',
    flip=False)
like_neutral_label = visual.TextStim(win=win, name='like_neutral_label',
    text='Neutral',
    font='Arial',
    pos=(150, 0), height=20, wrapWidth=None, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-3.0);
brand4 = visual.TextStim(win=win, name='brand4',
    text='default text',
    font='Arial',
    pos=(-47, 73), height=50, wrapWidth=None, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-4.0);

# Initialize components for Routine "compare_brand"
compare_brandClock = core.Clock()
comp_text = visual.TextStim(win=win, name='comp_text',
    text='Please compare the two brands.\n\n\nPress enter to continue.',
    font='Arial',
    pos=(0, 0), height=50, wrapWidth=1500, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);

# Initialize components for Routine "comp_sweet"
comp_sweetClock = core.Clock()
comp_sweet_text = visual.TextStim(win=win, name='comp_sweet_text',
    text="Which cookie brand is sweeter?\n\n\nPress 'A' or 'B' on the \nkeyboard to make your choice.",
    font='Arial',
    pos=(0, 0), height=50, wrapWidth=1500, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);

# Initialize components for Routine "comp_salt"
comp_saltClock = core.Clock()
comp_salt_text = visual.TextStim(win=win, name='comp_salt_text',
    text="Which cookie brand is saltier?\n\n\nPress 'A' or 'B' on the \nkeyboard to make your choice.",
    font='Arial',
    pos=(0, 0), height=50, wrapWidth=1500, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);

# Initialize components for Routine "comp_fresh"
comp_freshClock = core.Clock()
comp_fresh_text = visual.TextStim(win=win, name='comp_fresh_text',
    text="Which cookie brand is fresher \n(i.e., baked more recently)?\n\n\nPress 'A' or 'B' on the \nkeyboard to make your choice.",
    font='Arial',
    pos=(0, 0), height=50, wrapWidth=1500, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);

# Initialize components for Routine "comp_soft"
comp_softClock = core.Clock()
comp_soft_text = visual.TextStim(win=win, name='comp_soft_text',
    text="Which cookie brand is softer? \n\n\nPress 'A' or 'B' on the \nkeyboard to make your choice.",
    font='Arial',
    pos=(0, 0), height=50, wrapWidth=1500, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);

# Initialize components for Routine "comp_quality"
comp_qualityClock = core.Clock()
comp_qual_text = visual.TextStim(win=win, name='comp_qual_text',
    text="Which cookie brand is made \nfrom higher quality chocolate?\n\n\nPress 'A' or 'B' on the \nkeyboard to make your choice.",
    font='Arial',
    pos=(0, 0), height=50, wrapWidth=1500, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);

# Initialize components for Routine "comp_like"
comp_likeClock = core.Clock()
comp_like_text = visual.TextStim(win=win, name='comp_like_text',
    text="Which cookie brand do you like more?\n\n\nPress 'A' or 'B' on the \nkeyboard to make your choice.",
    font='Arial',
    pos=(0, 0), height=50, wrapWidth=1500, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);

# Initialize components for Routine "write"
writeClock = core.Clock()
write_text = visual.TextStim(win=win, name='write_text',
    text='If you have any additional comments \nthat you would like to make in comparing\nthe two cookie brands (A and B), please\nrecord them on the paper next to you.\n\n\nPress enter to continue.',
    font='Arial',
    pos=(0, 0), height=50, wrapWidth=1500, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);

# Initialize components for Routine "end"
endClock = core.Clock()
end_text = visual.TextStim(win=win, name='end_text',
    text='This completes the taste test.\n\nPlease wait in this room. \n\nThe experimenter will let you know \nwhen the 10 minutes is up.',
    font='Arial',
    pos=(0, 0), height=50, wrapWidth=1500, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);

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
    label1.setText(LeftAnchor)
    label2.setText(RightAnchor)
    # keep track of which components have finished
    statesComponents = [states_text, rating_slider, label1, label2]
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
        
        # Check rating_slider for response to end routine
        if rating_slider.getRating() is not None and rating_slider.status == STARTED:
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
    state_trials.addData('rating_slider.response', rating_slider.getRating())
    # the Routine "states" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    thisExp.nextEntry()
    
# completed 1 repeats of 'state_trials'


# ------Prepare to start Routine "wait"-------
t = 0
waitClock.reset()  # clock
frameN = -1
continueRoutine = True
# update component parameters for each repeat
return_key_2 = keyboard.Keyboard()
# keep track of which components have finished
waitComponents = [please_wait2, return_key_2]
for thisComponent in waitComponents:
    thisComponent.tStart = None
    thisComponent.tStop = None
    thisComponent.tStartRefresh = None
    thisComponent.tStopRefresh = None
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED

# -------Start Routine "wait"-------
while continueRoutine:
    # get current time
    t = waitClock.getTime()
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # *please_wait2* updates
    if t >= 0.0 and please_wait2.status == NOT_STARTED:
        # keep track of start time/frame for later
        please_wait2.tStart = t  # not accounting for scr refresh
        please_wait2.frameNStart = frameN  # exact frame index
        win.timeOnFlip(please_wait2, 'tStartRefresh')  # time at next scr refresh
        please_wait2.setAutoDraw(True)
    
    # *return_key_2* updates
    if t >= 0.0 and return_key_2.status == NOT_STARTED:
        # keep track of start time/frame for later
        return_key_2.tStart = t  # not accounting for scr refresh
        return_key_2.frameNStart = frameN  # exact frame index
        win.timeOnFlip(return_key_2, 'tStartRefresh')  # time at next scr refresh
        return_key_2.status = STARTED
        # keyboard checking is just starting
        return_key_2.clearEvents(eventType='keyboard')
    if return_key_2.status == STARTED:
        theseKeys = return_key_2.getKeys(keyList=['return'], waitRelease=False)
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
    for thisComponent in waitComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# -------Ending Routine "wait"-------
for thisComponent in waitComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
# the Routine "wait" was not non-slip safe, so reset the non-slip timer
routineTimer.reset()

# ------Prepare to start Routine "instr"-------
t = 0
instrClock.reset()  # clock
frameN = -1
continueRoutine = True
# update component parameters for each repeat
key_resp_3 = keyboard.Keyboard()
# keep track of which components have finished
instrComponents = [taste_instr, key_resp_3]
for thisComponent in instrComponents:
    thisComponent.tStart = None
    thisComponent.tStop = None
    thisComponent.tStartRefresh = None
    thisComponent.tStopRefresh = None
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED

# -------Start Routine "instr"-------
while continueRoutine:
    # get current time
    t = instrClock.getTime()
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # *taste_instr* updates
    if t >= 0.0 and taste_instr.status == NOT_STARTED:
        # keep track of start time/frame for later
        taste_instr.tStart = t  # not accounting for scr refresh
        taste_instr.frameNStart = frameN  # exact frame index
        win.timeOnFlip(taste_instr, 'tStartRefresh')  # time at next scr refresh
        taste_instr.setAutoDraw(True)
    
    # *key_resp_3* updates
    if t >= 0.0 and key_resp_3.status == NOT_STARTED:
        # keep track of start time/frame for later
        key_resp_3.tStart = t  # not accounting for scr refresh
        key_resp_3.frameNStart = frameN  # exact frame index
        win.timeOnFlip(key_resp_3, 'tStartRefresh')  # time at next scr refresh
        key_resp_3.status = STARTED
        # keyboard checking is just starting
        key_resp_3.clearEvents(eventType='keyboard')
    if key_resp_3.status == STARTED:
        theseKeys = key_resp_3.getKeys(keyList=['return'], waitRelease=False)
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
    for thisComponent in instrComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# -------Ending Routine "instr"-------
for thisComponent in instrComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
# the Routine "instr" was not non-slip safe, so reset the non-slip timer
routineTimer.reset()

# set up handler to look after randomisation of conditions etc
brand = data.TrialHandler(nReps=1, method='sequential', 
    extraInfo=expInfo, originPath=-1,
    trialList=data.importConditions('cookies.xlsx'),
    seed=None, name='brand')
thisExp.addLoop(brand)  # add the loop to the experiment
thisBrand = brand.trialList[0]  # so we can initialise stimuli with some values
# abbreviate parameter names if possible (e.g. rgb = thisBrand.rgb)
if thisBrand != None:
    for paramName in thisBrand:
        exec('{} = thisBrand[paramName]'.format(paramName))

for thisBrand in brand:
    currentLoop = brand
    # abbreviate parameter names if possible (e.g. rgb = thisBrand.rgb)
    if thisBrand != None:
        for paramName in thisBrand:
            exec('{} = thisBrand[paramName]'.format(paramName))
    
    # ------Prepare to start Routine "select_brand"-------
    t = 0
    select_brandClock.reset()  # clock
    frameN = -1
    continueRoutine = True
    # update component parameters for each repeat
    select_cookie_text.setText(Cookie)
    return_key = keyboard.Keyboard()
    # keep track of which components have finished
    select_brandComponents = [new_cookie, select_cookie_text, press_enter, return_key]
    for thisComponent in select_brandComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    
    # -------Start Routine "select_brand"-------
    while continueRoutine:
        # get current time
        t = select_brandClock.getTime()
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *new_cookie* updates
        if t >= 0.0 and new_cookie.status == NOT_STARTED:
            # keep track of start time/frame for later
            new_cookie.tStart = t  # not accounting for scr refresh
            new_cookie.frameNStart = frameN  # exact frame index
            win.timeOnFlip(new_cookie, 'tStartRefresh')  # time at next scr refresh
            new_cookie.setAutoDraw(True)
        
        # *select_cookie_text* updates
        if t >= 0.0 and select_cookie_text.status == NOT_STARTED:
            # keep track of start time/frame for later
            select_cookie_text.tStart = t  # not accounting for scr refresh
            select_cookie_text.frameNStart = frameN  # exact frame index
            win.timeOnFlip(select_cookie_text, 'tStartRefresh')  # time at next scr refresh
            select_cookie_text.setAutoDraw(True)
        
        # *press_enter* updates
        if t >= 0.0 and press_enter.status == NOT_STARTED:
            # keep track of start time/frame for later
            press_enter.tStart = t  # not accounting for scr refresh
            press_enter.frameNStart = frameN  # exact frame index
            win.timeOnFlip(press_enter, 'tStartRefresh')  # time at next scr refresh
            press_enter.setAutoDraw(True)
        
        # *return_key* updates
        if t >= 0.0 and return_key.status == NOT_STARTED:
            # keep track of start time/frame for later
            return_key.tStart = t  # not accounting for scr refresh
            return_key.frameNStart = frameN  # exact frame index
            win.timeOnFlip(return_key, 'tStartRefresh')  # time at next scr refresh
            return_key.status = STARTED
            # keyboard checking is just starting
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
        for thisComponent in select_brandComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "select_brand"-------
    for thisComponent in select_brandComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    # the Routine "select_brand" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    
    # ------Prepare to start Routine "sweet"-------
    t = 0
    sweetClock.reset()  # clock
    frameN = -1
    continueRoutine = True
    # update component parameters for each repeat
    sweet_slider.reset()
    sweet_slider = visual.Slider(win=win, name='intense_slider',
        size=(20, 800), pos=(200, 0),
        labels=('','Barely detectable', 'Weak', 'Moderate', 'Strong', 'Very strong', 'Strongest imaginable sensation of any kind'), 
        ticks=(0, 1.4,6,17,35,51,100),
        granularity=0, style=('triangleMarker','rating'), labelHeight=20,
        color='MidnightBlue', font='Arial',
        autoLog = True, flip=True);
    sweet_slider.marker.size=(30,30);
    sweet_slider.marker.color = 'red';
    brand1.setText(Cookie)
    # keep track of which components have finished
    sweetComponents = [sweet_text, sweet_slider, sweet_bottom_label, brand1]
    for thisComponent in sweetComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    
    # -------Start Routine "sweet"-------
    while continueRoutine:
        # get current time
        t = sweetClock.getTime()
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *sweet_text* updates
        if t >= 0.0 and sweet_text.status == NOT_STARTED:
            # keep track of start time/frame for later
            sweet_text.tStart = t  # not accounting for scr refresh
            sweet_text.frameNStart = frameN  # exact frame index
            win.timeOnFlip(sweet_text, 'tStartRefresh')  # time at next scr refresh
            sweet_text.setAutoDraw(True)
        
        # *sweet_slider* updates
        if t >= 0.0 and sweet_slider.status == NOT_STARTED:
            # keep track of start time/frame for later
            sweet_slider.tStart = t  # not accounting for scr refresh
            sweet_slider.frameNStart = frameN  # exact frame index
            win.timeOnFlip(sweet_slider, 'tStartRefresh')  # time at next scr refresh
            sweet_slider.setAutoDraw(True)
        
        # Check sweet_slider for response to end routine
        if sweet_slider.getRating() is not None and sweet_slider.status == STARTED:
            continueRoutine = False
        
        # *sweet_bottom_label* updates
        if t >= 0.0 and sweet_bottom_label.status == NOT_STARTED:
            # keep track of start time/frame for later
            sweet_bottom_label.tStart = t  # not accounting for scr refresh
            sweet_bottom_label.frameNStart = frameN  # exact frame index
            win.timeOnFlip(sweet_bottom_label, 'tStartRefresh')  # time at next scr refresh
            sweet_bottom_label.setAutoDraw(True)
        
        # *brand1* updates
        if t >= 0.0 and brand1.status == NOT_STARTED:
            # keep track of start time/frame for later
            brand1.tStart = t  # not accounting for scr refresh
            brand1.frameNStart = frameN  # exact frame index
            win.timeOnFlip(brand1, 'tStartRefresh')  # time at next scr refresh
            brand1.setAutoDraw(True)
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in sweetComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "sweet"-------
    for thisComponent in sweetComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    brand.addData('sweet_slider.response', sweet_slider.getRating())
    brand.addData('sweet_slider.rt', sweet_slider.getRT())
    # the Routine "sweet" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    
    # ------Prepare to start Routine "salty"-------
    t = 0
    saltyClock.reset()  # clock
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
    brand2.setText(Cookie)
    # keep track of which components have finished
    saltyComponents = [intense_text, intense_slider, intense_bottom_label, brand2]
    for thisComponent in saltyComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    
    # -------Start Routine "salty"-------
    while continueRoutine:
        # get current time
        t = saltyClock.getTime()
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
        
        # *intense_bottom_label* updates
        if t >= 0.0 and intense_bottom_label.status == NOT_STARTED:
            # keep track of start time/frame for later
            intense_bottom_label.tStart = t  # not accounting for scr refresh
            intense_bottom_label.frameNStart = frameN  # exact frame index
            win.timeOnFlip(intense_bottom_label, 'tStartRefresh')  # time at next scr refresh
            intense_bottom_label.setAutoDraw(True)
        
        # *brand2* updates
        if t >= 0.0 and brand2.status == NOT_STARTED:
            # keep track of start time/frame for later
            brand2.tStart = t  # not accounting for scr refresh
            brand2.frameNStart = frameN  # exact frame index
            win.timeOnFlip(brand2, 'tStartRefresh')  # time at next scr refresh
            brand2.setAutoDraw(True)
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in saltyComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "salty"-------
    for thisComponent in saltyComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    brand.addData('intense_slider.response', intense_slider.getRating())
    brand.addData('intense_slider.rt', intense_slider.getRT())
    # the Routine "salty" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    
    # ------Prepare to start Routine "frequency"-------
    t = 0
    frequencyClock.reset()  # clock
    frameN = -1
    continueRoutine = True
    # update component parameters for each repeat
    frequency_slider.reset()
    frequency_slider = visual.Slider(win=win, name='frequency',
        size=(1200, 30), pos=(0, 0),
        granularity=0, style=('triangleMarker','rating'), labelHeight=30,
        ticks=(0,0.25,0.5,0.75,1),
        labels =('<1 per month', '2-3 per month', '1-2 per week', '3-4 per week', '5+ per week'),
        color='MidnightBlue', font='Arial',
        autoLog = True, flip=False);
    frequency_slider.marker.size=(30,30);
    frequency_slider.marker.color = 'red';
    brand3.setText(Cookie)
    # keep track of which components have finished
    frequencyComponents = [frequency_text, frequency_slider, brand3]
    for thisComponent in frequencyComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    
    # -------Start Routine "frequency"-------
    while continueRoutine:
        # get current time
        t = frequencyClock.getTime()
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *frequency_text* updates
        if t >= 0.0 and frequency_text.status == NOT_STARTED:
            # keep track of start time/frame for later
            frequency_text.tStart = t  # not accounting for scr refresh
            frequency_text.frameNStart = frameN  # exact frame index
            win.timeOnFlip(frequency_text, 'tStartRefresh')  # time at next scr refresh
            frequency_text.setAutoDraw(True)
        
        # *frequency_slider* updates
        if t >= 0.0 and frequency_slider.status == NOT_STARTED:
            # keep track of start time/frame for later
            frequency_slider.tStart = t  # not accounting for scr refresh
            frequency_slider.frameNStart = frameN  # exact frame index
            win.timeOnFlip(frequency_slider, 'tStartRefresh')  # time at next scr refresh
            frequency_slider.setAutoDraw(True)
        
        # Check frequency_slider for response to end routine
        if frequency_slider.getRating() is not None and frequency_slider.status == STARTED:
            continueRoutine = False
        
        # *brand3* updates
        if t >= 0.0 and brand3.status == NOT_STARTED:
            # keep track of start time/frame for later
            brand3.tStart = t  # not accounting for scr refresh
            brand3.frameNStart = frameN  # exact frame index
            win.timeOnFlip(brand3, 'tStartRefresh')  # time at next scr refresh
            brand3.setAutoDraw(True)
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in frequencyComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "frequency"-------
    for thisComponent in frequencyComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    brand.addData('frequency_slider.response', frequency_slider.getRating())
    brand.addData('frequency_slider.rt', frequency_slider.getRT())
    # the Routine "frequency" was not non-slip safe, so reset the non-slip timer
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
        ticks=(-100.00, -62.89, -41.58, -17.59, -5.92, 0, 6.25, 17.82, 44.43, 65.72, 100.00),
        granularity=0, style=('triangleMarker','rating'), labelHeight=20,
        color='MidnightBlue', font='Arial',
        autoLog = True, flip=True);
    like_slider.marker.size=(30,30);
    like_slider.marker.color = 'red';
    brand4.setText(Cookie)
    # keep track of which components have finished
    likeComponents = [like_text, like_slider, like_neutral_label, brand4]
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
        
        # *like_neutral_label* updates
        if t >= 0.0 and like_neutral_label.status == NOT_STARTED:
            # keep track of start time/frame for later
            like_neutral_label.tStart = t  # not accounting for scr refresh
            like_neutral_label.frameNStart = frameN  # exact frame index
            win.timeOnFlip(like_neutral_label, 'tStartRefresh')  # time at next scr refresh
            like_neutral_label.setAutoDraw(True)
        
        # *brand4* updates
        if t >= 0.0 and brand4.status == NOT_STARTED:
            # keep track of start time/frame for later
            brand4.tStart = t  # not accounting for scr refresh
            brand4.frameNStart = frameN  # exact frame index
            win.timeOnFlip(brand4, 'tStartRefresh')  # time at next scr refresh
            brand4.setAutoDraw(True)
        
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
    brand.addData('like_slider.response', like_slider.getRating())
    brand.addData('like_slider.rt', like_slider.getRT())
    # the Routine "like" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    thisExp.nextEntry()
    
# completed 1 repeats of 'brand'


# ------Prepare to start Routine "compare_brand"-------
t = 0
compare_brandClock.reset()  # clock
frameN = -1
continueRoutine = True
# update component parameters for each repeat
key_resp_2 = keyboard.Keyboard()
# keep track of which components have finished
compare_brandComponents = [comp_text, key_resp_2]
for thisComponent in compare_brandComponents:
    thisComponent.tStart = None
    thisComponent.tStop = None
    thisComponent.tStartRefresh = None
    thisComponent.tStopRefresh = None
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED

# -------Start Routine "compare_brand"-------
while continueRoutine:
    # get current time
    t = compare_brandClock.getTime()
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # *comp_text* updates
    if t >= 0.0 and comp_text.status == NOT_STARTED:
        # keep track of start time/frame for later
        comp_text.tStart = t  # not accounting for scr refresh
        comp_text.frameNStart = frameN  # exact frame index
        win.timeOnFlip(comp_text, 'tStartRefresh')  # time at next scr refresh
        comp_text.setAutoDraw(True)
    
    # *key_resp_2* updates
    if t >= 0.0 and key_resp_2.status == NOT_STARTED:
        # keep track of start time/frame for later
        key_resp_2.tStart = t  # not accounting for scr refresh
        key_resp_2.frameNStart = frameN  # exact frame index
        win.timeOnFlip(key_resp_2, 'tStartRefresh')  # time at next scr refresh
        key_resp_2.status = STARTED
        # keyboard checking is just starting
        key_resp_2.clearEvents(eventType='keyboard')
    if key_resp_2.status == STARTED:
        theseKeys = key_resp_2.getKeys(keyList=['return'], waitRelease=False)
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
    for thisComponent in compare_brandComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# -------Ending Routine "compare_brand"-------
for thisComponent in compare_brandComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
# the Routine "compare_brand" was not non-slip safe, so reset the non-slip timer
routineTimer.reset()

# ------Prepare to start Routine "comp_sweet"-------
t = 0
comp_sweetClock.reset()  # clock
frameN = -1
continueRoutine = True
# update component parameters for each repeat
comp_sweet_resp = keyboard.Keyboard()
# keep track of which components have finished
comp_sweetComponents = [comp_sweet_text, comp_sweet_resp]
for thisComponent in comp_sweetComponents:
    thisComponent.tStart = None
    thisComponent.tStop = None
    thisComponent.tStartRefresh = None
    thisComponent.tStopRefresh = None
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED

# -------Start Routine "comp_sweet"-------
while continueRoutine:
    # get current time
    t = comp_sweetClock.getTime()
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # *comp_sweet_text* updates
    if t >= 0.0 and comp_sweet_text.status == NOT_STARTED:
        # keep track of start time/frame for later
        comp_sweet_text.tStart = t  # not accounting for scr refresh
        comp_sweet_text.frameNStart = frameN  # exact frame index
        win.timeOnFlip(comp_sweet_text, 'tStartRefresh')  # time at next scr refresh
        comp_sweet_text.setAutoDraw(True)
    
    # *comp_sweet_resp* updates
    if t >= 0.0 and comp_sweet_resp.status == NOT_STARTED:
        # keep track of start time/frame for later
        comp_sweet_resp.tStart = t  # not accounting for scr refresh
        comp_sweet_resp.frameNStart = frameN  # exact frame index
        win.timeOnFlip(comp_sweet_resp, 'tStartRefresh')  # time at next scr refresh
        comp_sweet_resp.status = STARTED
        # keyboard checking is just starting
        win.callOnFlip(comp_sweet_resp.clock.reset)  # t=0 on next screen flip
        comp_sweet_resp.clearEvents(eventType='keyboard')
    if comp_sweet_resp.status == STARTED:
        theseKeys = comp_sweet_resp.getKeys(keyList=['a', 'b'], waitRelease=False)
        if len(theseKeys):
            theseKeys = theseKeys[0]  # at least one key was pressed
            
            # check for quit:
            if "escape" == theseKeys:
                endExpNow = True
            comp_sweet_resp.keys = theseKeys.name  # just the last key pressed
            comp_sweet_resp.rt = theseKeys.rt
            # a response ends the routine
            continueRoutine = False
    
    # check for quit (typically the Esc key)
    if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
        core.quit()
    
    # check if all components have finished
    if not continueRoutine:  # a component has requested a forced-end of Routine
        break
    continueRoutine = False  # will revert to True if at least one component still running
    for thisComponent in comp_sweetComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# -------Ending Routine "comp_sweet"-------
for thisComponent in comp_sweetComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
# check responses
if comp_sweet_resp.keys in ['', [], None]:  # No response was made
    comp_sweet_resp.keys = None
thisExp.addData('comp_sweet_resp.keys',comp_sweet_resp.keys)
if comp_sweet_resp.keys != None:  # we had a response
    thisExp.addData('comp_sweet_resp.rt', comp_sweet_resp.rt)
thisExp.nextEntry()
# the Routine "comp_sweet" was not non-slip safe, so reset the non-slip timer
routineTimer.reset()

# ------Prepare to start Routine "comp_salt"-------
t = 0
comp_saltClock.reset()  # clock
frameN = -1
continueRoutine = True
# update component parameters for each repeat
comp_salt_resp = keyboard.Keyboard()
# keep track of which components have finished
comp_saltComponents = [comp_salt_text, comp_salt_resp]
for thisComponent in comp_saltComponents:
    thisComponent.tStart = None
    thisComponent.tStop = None
    thisComponent.tStartRefresh = None
    thisComponent.tStopRefresh = None
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED

# -------Start Routine "comp_salt"-------
while continueRoutine:
    # get current time
    t = comp_saltClock.getTime()
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # *comp_salt_text* updates
    if t >= 0.0 and comp_salt_text.status == NOT_STARTED:
        # keep track of start time/frame for later
        comp_salt_text.tStart = t  # not accounting for scr refresh
        comp_salt_text.frameNStart = frameN  # exact frame index
        win.timeOnFlip(comp_salt_text, 'tStartRefresh')  # time at next scr refresh
        comp_salt_text.setAutoDraw(True)
    
    # *comp_salt_resp* updates
    if t >= 0.0 and comp_salt_resp.status == NOT_STARTED:
        # keep track of start time/frame for later
        comp_salt_resp.tStart = t  # not accounting for scr refresh
        comp_salt_resp.frameNStart = frameN  # exact frame index
        win.timeOnFlip(comp_salt_resp, 'tStartRefresh')  # time at next scr refresh
        comp_salt_resp.status = STARTED
        # keyboard checking is just starting
        win.callOnFlip(comp_salt_resp.clock.reset)  # t=0 on next screen flip
        comp_salt_resp.clearEvents(eventType='keyboard')
    if comp_salt_resp.status == STARTED:
        theseKeys = comp_salt_resp.getKeys(keyList=['a', 'b'], waitRelease=False)
        if len(theseKeys):
            theseKeys = theseKeys[0]  # at least one key was pressed
            
            # check for quit:
            if "escape" == theseKeys:
                endExpNow = True
            comp_salt_resp.keys = theseKeys.name  # just the last key pressed
            comp_salt_resp.rt = theseKeys.rt
            # a response ends the routine
            continueRoutine = False
    
    # check for quit (typically the Esc key)
    if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
        core.quit()
    
    # check if all components have finished
    if not continueRoutine:  # a component has requested a forced-end of Routine
        break
    continueRoutine = False  # will revert to True if at least one component still running
    for thisComponent in comp_saltComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# -------Ending Routine "comp_salt"-------
for thisComponent in comp_saltComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
# check responses
if comp_salt_resp.keys in ['', [], None]:  # No response was made
    comp_salt_resp.keys = None
thisExp.addData('comp_salt_resp.keys',comp_salt_resp.keys)
if comp_salt_resp.keys != None:  # we had a response
    thisExp.addData('comp_salt_resp.rt', comp_salt_resp.rt)
thisExp.nextEntry()
# the Routine "comp_salt" was not non-slip safe, so reset the non-slip timer
routineTimer.reset()

# ------Prepare to start Routine "comp_fresh"-------
t = 0
comp_freshClock.reset()  # clock
frameN = -1
continueRoutine = True
# update component parameters for each repeat
key_resp_4 = keyboard.Keyboard()
# keep track of which components have finished
comp_freshComponents = [comp_fresh_text, key_resp_4]
for thisComponent in comp_freshComponents:
    thisComponent.tStart = None
    thisComponent.tStop = None
    thisComponent.tStartRefresh = None
    thisComponent.tStopRefresh = None
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED

# -------Start Routine "comp_fresh"-------
while continueRoutine:
    # get current time
    t = comp_freshClock.getTime()
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # *comp_fresh_text* updates
    if t >= 0.0 and comp_fresh_text.status == NOT_STARTED:
        # keep track of start time/frame for later
        comp_fresh_text.tStart = t  # not accounting for scr refresh
        comp_fresh_text.frameNStart = frameN  # exact frame index
        win.timeOnFlip(comp_fresh_text, 'tStartRefresh')  # time at next scr refresh
        comp_fresh_text.setAutoDraw(True)
    
    # *key_resp_4* updates
    if t >= 0.0 and key_resp_4.status == NOT_STARTED:
        # keep track of start time/frame for later
        key_resp_4.tStart = t  # not accounting for scr refresh
        key_resp_4.frameNStart = frameN  # exact frame index
        win.timeOnFlip(key_resp_4, 'tStartRefresh')  # time at next scr refresh
        key_resp_4.status = STARTED
        # keyboard checking is just starting
        win.callOnFlip(key_resp_4.clock.reset)  # t=0 on next screen flip
        key_resp_4.clearEvents(eventType='keyboard')
    if key_resp_4.status == STARTED:
        theseKeys = key_resp_4.getKeys(keyList=['a', 'b'], waitRelease=False)
        if len(theseKeys):
            theseKeys = theseKeys[0]  # at least one key was pressed
            
            # check for quit:
            if "escape" == theseKeys:
                endExpNow = True
            key_resp_4.keys = theseKeys.name  # just the last key pressed
            key_resp_4.rt = theseKeys.rt
            # a response ends the routine
            continueRoutine = False
    
    # check for quit (typically the Esc key)
    if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
        core.quit()
    
    # check if all components have finished
    if not continueRoutine:  # a component has requested a forced-end of Routine
        break
    continueRoutine = False  # will revert to True if at least one component still running
    for thisComponent in comp_freshComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# -------Ending Routine "comp_fresh"-------
for thisComponent in comp_freshComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
# check responses
if key_resp_4.keys in ['', [], None]:  # No response was made
    key_resp_4.keys = None
thisExp.addData('key_resp_4.keys',key_resp_4.keys)
if key_resp_4.keys != None:  # we had a response
    thisExp.addData('key_resp_4.rt', key_resp_4.rt)
thisExp.nextEntry()
# the Routine "comp_fresh" was not non-slip safe, so reset the non-slip timer
routineTimer.reset()

# ------Prepare to start Routine "comp_soft"-------
t = 0
comp_softClock.reset()  # clock
frameN = -1
continueRoutine = True
# update component parameters for each repeat
comp_soft_resp = keyboard.Keyboard()
# keep track of which components have finished
comp_softComponents = [comp_soft_text, comp_soft_resp]
for thisComponent in comp_softComponents:
    thisComponent.tStart = None
    thisComponent.tStop = None
    thisComponent.tStartRefresh = None
    thisComponent.tStopRefresh = None
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED

# -------Start Routine "comp_soft"-------
while continueRoutine:
    # get current time
    t = comp_softClock.getTime()
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # *comp_soft_text* updates
    if t >= 0.0 and comp_soft_text.status == NOT_STARTED:
        # keep track of start time/frame for later
        comp_soft_text.tStart = t  # not accounting for scr refresh
        comp_soft_text.frameNStart = frameN  # exact frame index
        win.timeOnFlip(comp_soft_text, 'tStartRefresh')  # time at next scr refresh
        comp_soft_text.setAutoDraw(True)
    
    # *comp_soft_resp* updates
    if t >= 0.0 and comp_soft_resp.status == NOT_STARTED:
        # keep track of start time/frame for later
        comp_soft_resp.tStart = t  # not accounting for scr refresh
        comp_soft_resp.frameNStart = frameN  # exact frame index
        win.timeOnFlip(comp_soft_resp, 'tStartRefresh')  # time at next scr refresh
        comp_soft_resp.status = STARTED
        # keyboard checking is just starting
        win.callOnFlip(comp_soft_resp.clock.reset)  # t=0 on next screen flip
        comp_soft_resp.clearEvents(eventType='keyboard')
    if comp_soft_resp.status == STARTED:
        theseKeys = comp_soft_resp.getKeys(keyList=['a', 'b'], waitRelease=False)
        if len(theseKeys):
            theseKeys = theseKeys[0]  # at least one key was pressed
            
            # check for quit:
            if "escape" == theseKeys:
                endExpNow = True
            comp_soft_resp.keys = theseKeys.name  # just the last key pressed
            comp_soft_resp.rt = theseKeys.rt
            # a response ends the routine
            continueRoutine = False
    
    # check for quit (typically the Esc key)
    if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
        core.quit()
    
    # check if all components have finished
    if not continueRoutine:  # a component has requested a forced-end of Routine
        break
    continueRoutine = False  # will revert to True if at least one component still running
    for thisComponent in comp_softComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# -------Ending Routine "comp_soft"-------
for thisComponent in comp_softComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
# check responses
if comp_soft_resp.keys in ['', [], None]:  # No response was made
    comp_soft_resp.keys = None
thisExp.addData('comp_soft_resp.keys',comp_soft_resp.keys)
if comp_soft_resp.keys != None:  # we had a response
    thisExp.addData('comp_soft_resp.rt', comp_soft_resp.rt)
thisExp.nextEntry()
# the Routine "comp_soft" was not non-slip safe, so reset the non-slip timer
routineTimer.reset()

# ------Prepare to start Routine "comp_quality"-------
t = 0
comp_qualityClock.reset()  # clock
frameN = -1
continueRoutine = True
# update component parameters for each repeat
comp_qual_resp = keyboard.Keyboard()
# keep track of which components have finished
comp_qualityComponents = [comp_qual_text, comp_qual_resp]
for thisComponent in comp_qualityComponents:
    thisComponent.tStart = None
    thisComponent.tStop = None
    thisComponent.tStartRefresh = None
    thisComponent.tStopRefresh = None
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED

# -------Start Routine "comp_quality"-------
while continueRoutine:
    # get current time
    t = comp_qualityClock.getTime()
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # *comp_qual_text* updates
    if t >= 0.0 and comp_qual_text.status == NOT_STARTED:
        # keep track of start time/frame for later
        comp_qual_text.tStart = t  # not accounting for scr refresh
        comp_qual_text.frameNStart = frameN  # exact frame index
        win.timeOnFlip(comp_qual_text, 'tStartRefresh')  # time at next scr refresh
        comp_qual_text.setAutoDraw(True)
    
    # *comp_qual_resp* updates
    if t >= 0.0 and comp_qual_resp.status == NOT_STARTED:
        # keep track of start time/frame for later
        comp_qual_resp.tStart = t  # not accounting for scr refresh
        comp_qual_resp.frameNStart = frameN  # exact frame index
        win.timeOnFlip(comp_qual_resp, 'tStartRefresh')  # time at next scr refresh
        comp_qual_resp.status = STARTED
        # keyboard checking is just starting
        win.callOnFlip(comp_qual_resp.clock.reset)  # t=0 on next screen flip
        comp_qual_resp.clearEvents(eventType='keyboard')
    if comp_qual_resp.status == STARTED:
        theseKeys = comp_qual_resp.getKeys(keyList=['a', 'b'], waitRelease=False)
        if len(theseKeys):
            theseKeys = theseKeys[0]  # at least one key was pressed
            
            # check for quit:
            if "escape" == theseKeys:
                endExpNow = True
            comp_qual_resp.keys = theseKeys.name  # just the last key pressed
            comp_qual_resp.rt = theseKeys.rt
            # a response ends the routine
            continueRoutine = False
    
    # check for quit (typically the Esc key)
    if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
        core.quit()
    
    # check if all components have finished
    if not continueRoutine:  # a component has requested a forced-end of Routine
        break
    continueRoutine = False  # will revert to True if at least one component still running
    for thisComponent in comp_qualityComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# -------Ending Routine "comp_quality"-------
for thisComponent in comp_qualityComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
# check responses
if comp_qual_resp.keys in ['', [], None]:  # No response was made
    comp_qual_resp.keys = None
thisExp.addData('comp_qual_resp.keys',comp_qual_resp.keys)
if comp_qual_resp.keys != None:  # we had a response
    thisExp.addData('comp_qual_resp.rt', comp_qual_resp.rt)
thisExp.nextEntry()
# the Routine "comp_quality" was not non-slip safe, so reset the non-slip timer
routineTimer.reset()

# ------Prepare to start Routine "comp_like"-------
t = 0
comp_likeClock.reset()  # clock
frameN = -1
continueRoutine = True
# update component parameters for each repeat
comp_like_resp = keyboard.Keyboard()
# keep track of which components have finished
comp_likeComponents = [comp_like_text, comp_like_resp]
for thisComponent in comp_likeComponents:
    thisComponent.tStart = None
    thisComponent.tStop = None
    thisComponent.tStartRefresh = None
    thisComponent.tStopRefresh = None
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED

# -------Start Routine "comp_like"-------
while continueRoutine:
    # get current time
    t = comp_likeClock.getTime()
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # *comp_like_text* updates
    if t >= 0.0 and comp_like_text.status == NOT_STARTED:
        # keep track of start time/frame for later
        comp_like_text.tStart = t  # not accounting for scr refresh
        comp_like_text.frameNStart = frameN  # exact frame index
        win.timeOnFlip(comp_like_text, 'tStartRefresh')  # time at next scr refresh
        comp_like_text.setAutoDraw(True)
    
    # *comp_like_resp* updates
    if t >= 0.0 and comp_like_resp.status == NOT_STARTED:
        # keep track of start time/frame for later
        comp_like_resp.tStart = t  # not accounting for scr refresh
        comp_like_resp.frameNStart = frameN  # exact frame index
        win.timeOnFlip(comp_like_resp, 'tStartRefresh')  # time at next scr refresh
        comp_like_resp.status = STARTED
        # keyboard checking is just starting
        win.callOnFlip(comp_like_resp.clock.reset)  # t=0 on next screen flip
        comp_like_resp.clearEvents(eventType='keyboard')
    if comp_like_resp.status == STARTED:
        theseKeys = comp_like_resp.getKeys(keyList=['a', 'b'], waitRelease=False)
        if len(theseKeys):
            theseKeys = theseKeys[0]  # at least one key was pressed
            
            # check for quit:
            if "escape" == theseKeys:
                endExpNow = True
            comp_like_resp.keys = theseKeys.name  # just the last key pressed
            comp_like_resp.rt = theseKeys.rt
            # a response ends the routine
            continueRoutine = False
    
    # check for quit (typically the Esc key)
    if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
        core.quit()
    
    # check if all components have finished
    if not continueRoutine:  # a component has requested a forced-end of Routine
        break
    continueRoutine = False  # will revert to True if at least one component still running
    for thisComponent in comp_likeComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# -------Ending Routine "comp_like"-------
for thisComponent in comp_likeComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
# check responses
if comp_like_resp.keys in ['', [], None]:  # No response was made
    comp_like_resp.keys = None
thisExp.addData('comp_like_resp.keys',comp_like_resp.keys)
if comp_like_resp.keys != None:  # we had a response
    thisExp.addData('comp_like_resp.rt', comp_like_resp.rt)
thisExp.nextEntry()
# the Routine "comp_like" was not non-slip safe, so reset the non-slip timer
routineTimer.reset()

# ------Prepare to start Routine "write"-------
t = 0
writeClock.reset()  # clock
frameN = -1
continueRoutine = True
# update component parameters for each repeat
key_resp_8 = keyboard.Keyboard()
# keep track of which components have finished
writeComponents = [write_text, key_resp_8]
for thisComponent in writeComponents:
    thisComponent.tStart = None
    thisComponent.tStop = None
    thisComponent.tStartRefresh = None
    thisComponent.tStopRefresh = None
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED

# -------Start Routine "write"-------
while continueRoutine:
    # get current time
    t = writeClock.getTime()
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # *write_text* updates
    if t >= 0.0 and write_text.status == NOT_STARTED:
        # keep track of start time/frame for later
        write_text.tStart = t  # not accounting for scr refresh
        write_text.frameNStart = frameN  # exact frame index
        win.timeOnFlip(write_text, 'tStartRefresh')  # time at next scr refresh
        write_text.setAutoDraw(True)
    
    # *key_resp_8* updates
    if t >= 0.0 and key_resp_8.status == NOT_STARTED:
        # keep track of start time/frame for later
        key_resp_8.tStart = t  # not accounting for scr refresh
        key_resp_8.frameNStart = frameN  # exact frame index
        win.timeOnFlip(key_resp_8, 'tStartRefresh')  # time at next scr refresh
        key_resp_8.status = STARTED
        # keyboard checking is just starting
        key_resp_8.clearEvents(eventType='keyboard')
    if key_resp_8.status == STARTED:
        theseKeys = key_resp_8.getKeys(keyList=['return'], waitRelease=False)
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
    for thisComponent in writeComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# -------Ending Routine "write"-------
for thisComponent in writeComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
# the Routine "write" was not non-slip safe, so reset the non-slip timer
routineTimer.reset()

# ------Prepare to start Routine "end"-------
t = 0
endClock.reset()  # clock
frameN = -1
continueRoutine = True
# update component parameters for each repeat
# keep track of which components have finished
endComponents = [end_text]
for thisComponent in endComponents:
    thisComponent.tStart = None
    thisComponent.tStop = None
    thisComponent.tStartRefresh = None
    thisComponent.tStopRefresh = None
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED

# -------Start Routine "end"-------
while continueRoutine:
    # get current time
    t = endClock.getTime()
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # *end_text* updates
    if t >= 0.0 and end_text.status == NOT_STARTED:
        # keep track of start time/frame for later
        end_text.tStart = t  # not accounting for scr refresh
        end_text.frameNStart = frameN  # exact frame index
        win.timeOnFlip(end_text, 'tStartRefresh')  # time at next scr refresh
        end_text.setAutoDraw(True)
    
    # check for quit (typically the Esc key)
    if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
        core.quit()
    
    # check if all components have finished
    if not continueRoutine:  # a component has requested a forced-end of Routine
        break
    continueRoutine = False  # will revert to True if at least one component still running
    for thisComponent in endComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# -------Ending Routine "end"-------
for thisComponent in endComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
# the Routine "end" was not non-slip safe, so reset the non-slip timer
routineTimer.reset()

# Flip one final time so any remaining win.callOnFlip() 
# and win.timeOnFlip() tasks get executed before quitting
win.flip()

# these shouldn't be strictly necessary (should auto-save)
thisExp.saveAsWideText(filename+'.csv')
thisExp.saveAsPickle(filename)
# make sure everything is closed down
thisExp.abort()  # or data files will save again on exit
win.close()
core.quit()
