# Script for training to use rating sales: general Labeled Magnitude Scale (Bartoshuk et al. 2004, Green et al. 1993, Green et al. 1996) and Labeled Hedonic Scale (Lim et al. 2009)
# Created by Emily Perszyk in PsychoPy builder 

#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
This experiment was created using PsychoPy3 Experiment Builder (v3.1.2),
    on February 23, 2020, at 17:30
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
expName = 'gLMS-LHS-training'  # from the Builder filename that created this script
expInfo = {'participant': '', 'session': '001'}
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
    originPath='C:\\Users\\eep29\\Documents\\Odor_imagery\\Tasks\\S1_tasks\\gLMS_LHS_training_continuous\\gLMS_LHS_training_continuous.py',
    savePickle=True, saveWideText=True,
    dataFileName=filename)


endExpNow = False  # flag for 'escape' or other condition => quit the exp

# Start Code - component code to be run before the window creation

# Setup the Window
win = visual.Window(
    size=[1920, 1080], fullscr=True, screen=0, 
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

# Initialize components for Routine "intense_imagined"
intense_imaginedClock = core.Clock()
intense_text = visual.TextStim(win=win, name='intense_text',
    text='Rate intensity.',
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
trial_text = visual.TextStim(win=win, name='trial_text',
    text='Trial',
    font='Arial',
    pos=(-600, 400), height=35, wrapWidth=None, ori=0, 
    color='DarkGray', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-4.0);
trial_num_display = visual.TextStim(win=win, name='trial_num_display',
    text='default text',
    font='Arial',
    pos=(-530, 400), height=35, wrapWidth=None, ori=0, 
    color='DarkGray', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-5.0);

# Initialize components for Routine "please_wait"
please_waitClock = core.Clock()
please_wait_text = visual.TextStim(win=win, name='please_wait_text',
    text='Please wait for experimenter.',
    font='Arial',
    pos=(0, 0), height=40, wrapWidth=1000, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);

# Initialize components for Routine "intense_real"
intense_realClock = core.Clock()
intense_text2 = visual.TextStim(win=win, name='intense_text2',
    text='Rate intensity.',
    font='Arial',
    pos=(-200, 0), height=50, wrapWidth=None, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);
intense_slider2 = visual.Slider(win=win, name='intense_slider2',
    size=(1.0, 0.1), pos=(0, -0.4),
    labels=None, ticks=(1, 2, 3, 4, 5),
    granularity=0, style=('rating',),
    color='LightGray', font='HelveticaBold',
    flip=False)
intense_bottom_label2 = visual.TextStim(win=win, name='intense_bottom_label2',
    text='No sensation',
    font='Arial',
    pos=(115, -400), height=20, wrapWidth=None, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-3.0);
trial_text2 = visual.TextStim(win=win, name='trial_text2',
    text='Trial',
    font='Arial',
    pos=(-600, 400), height=35, wrapWidth=None, ori=0, 
    color='DarkGray', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-4.0);
trial_num_display2 = visual.TextStim(win=win, name='trial_num_display2',
    text='default text',
    font='Arial',
    pos=(-530, 400), height=35, wrapWidth=None, ori=0, 
    color='DarkGray', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-5.0);

# Initialize components for Routine "please_wait"
please_waitClock = core.Clock()
please_wait_text = visual.TextStim(win=win, name='please_wait_text',
    text='Please wait for experimenter.',
    font='Arial',
    pos=(0, 0), height=40, wrapWidth=1000, ori=0, 
    color='MidnightBlue', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=0.0);

# Initialize components for Routine "like"
likeClock = core.Clock()
like_text = visual.TextStim(win=win, name='like_text',
    text='How much do you like \nor dislike the sensation?',
    font='Arial',
    pos=(-200, 0), height=40, wrapWidth=1000, ori=0, 
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
trial_text3 = visual.TextStim(win=win, name='trial_text3',
    text='Trial',
    font='Arial',
    pos=(-600, 400), height=35, wrapWidth=None, ori=0, 
    color='DarkGray', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-4.0);
trial_num_display3 = visual.TextStim(win=win, name='trial_num_display3',
    text='default text',
    font='Arial',
    pos=(-530, 400), height=35, wrapWidth=None, ori=0, 
    color='DarkGray', colorSpace='rgb', opacity=1, 
    languageStyle='LTR',
    depth=-5.0);

# Create some handy timers
globalClock = core.Clock()  # to track the time since experiment started
routineTimer = core.CountdownTimer()  # to track time remaining of each (non-slip) routine 

# set up handler to look after randomisation of conditions etc
gLMS_imagined_trials = data.TrialHandler(nReps=1, method='sequential', 
    extraInfo=expInfo, originPath=-1,
    trialList=data.importConditions('gLMS_imagined.xlsx'),
    seed=None, name='gLMS_imagined_trials')
thisExp.addLoop(gLMS_imagined_trials)  # add the loop to the experiment
thisGLMS_imagined_trial = gLMS_imagined_trials.trialList[0]  # so we can initialise stimuli with some values
# abbreviate parameter names if possible (e.g. rgb = thisGLMS_imagined_trial.rgb)
if thisGLMS_imagined_trial != None:
    for paramName in thisGLMS_imagined_trial:
        exec('{} = thisGLMS_imagined_trial[paramName]'.format(paramName))

for thisGLMS_imagined_trial in gLMS_imagined_trials:
    currentLoop = gLMS_imagined_trials
    # abbreviate parameter names if possible (e.g. rgb = thisGLMS_imagined_trial.rgb)
    if thisGLMS_imagined_trial != None:
        for paramName in thisGLMS_imagined_trial:
            exec('{} = thisGLMS_imagined_trial[paramName]'.format(paramName))
    
    # ------Prepare to start Routine "intense_imagined"-------
    t = 0
    intense_imaginedClock.reset()  # clock
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
    trial_num_display.setText(gLMS_imagined)
    # keep track of which components have finished
    intense_imaginedComponents = [intense_text, intense_slider, intense_bottom_label, trial_text, trial_num_display]
    for thisComponent in intense_imaginedComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    
    # -------Start Routine "intense_imagined"-------
    while continueRoutine:
        # get current time
        t = intense_imaginedClock.getTime()
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
        
        # *trial_text* updates
        if t >= 0.0 and trial_text.status == NOT_STARTED:
            # keep track of start time/frame for later
            trial_text.tStart = t  # not accounting for scr refresh
            trial_text.frameNStart = frameN  # exact frame index
            win.timeOnFlip(trial_text, 'tStartRefresh')  # time at next scr refresh
            trial_text.setAutoDraw(True)
        
        # *trial_num_display* updates
        if t >= 0.0 and trial_num_display.status == NOT_STARTED:
            # keep track of start time/frame for later
            trial_num_display.tStart = t  # not accounting for scr refresh
            trial_num_display.frameNStart = frameN  # exact frame index
            win.timeOnFlip(trial_num_display, 'tStartRefresh')  # time at next scr refresh
            trial_num_display.setAutoDraw(True)
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in intense_imaginedComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "intense_imagined"-------
    for thisComponent in intense_imaginedComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    gLMS_imagined_trials.addData('intense_slider.response', intense_slider.getRating())
    gLMS_imagined_trials.addData('trial_text.started', trial_text.tStartRefresh)
    gLMS_imagined_trials.addData('trial_text.stopped', trial_text.tStopRefresh)
    gLMS_imagined_trials.addData('trial_num_display.started', trial_num_display.tStartRefresh)
    gLMS_imagined_trials.addData('trial_num_display.stopped', trial_num_display.tStopRefresh)
    # the Routine "intense_imagined" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    thisExp.nextEntry()
    
# completed 1 repeats of 'gLMS_imagined_trials'


# ------Prepare to start Routine "please_wait"-------
t = 0
please_waitClock.reset()  # clock
frameN = -1
continueRoutine = True
# update component parameters for each repeat
return_key = keyboard.Keyboard()
# keep track of which components have finished
please_waitComponents = [please_wait_text, return_key]
for thisComponent in please_waitComponents:
    thisComponent.tStart = None
    thisComponent.tStop = None
    thisComponent.tStartRefresh = None
    thisComponent.tStopRefresh = None
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED

# -------Start Routine "please_wait"-------
while continueRoutine:
    # get current time
    t = please_waitClock.getTime()
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # *please_wait_text* updates
    if t >= 0.0 and please_wait_text.status == NOT_STARTED:
        # keep track of start time/frame for later
        please_wait_text.tStart = t  # not accounting for scr refresh
        please_wait_text.frameNStart = frameN  # exact frame index
        win.timeOnFlip(please_wait_text, 'tStartRefresh')  # time at next scr refresh
        please_wait_text.setAutoDraw(True)
    
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
    for thisComponent in please_waitComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# -------Ending Routine "please_wait"-------
for thisComponent in please_waitComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
# the Routine "please_wait" was not non-slip safe, so reset the non-slip timer
routineTimer.reset()

# set up handler to look after randomisation of conditions etc
gLMS_real_trials = data.TrialHandler(nReps=1, method='sequential', 
    extraInfo=expInfo, originPath=-1,
    trialList=data.importConditions('gLMS_real.xlsx'),
    seed=None, name='gLMS_real_trials')
thisExp.addLoop(gLMS_real_trials)  # add the loop to the experiment
thisGLMS_real_trial = gLMS_real_trials.trialList[0]  # so we can initialise stimuli with some values
# abbreviate parameter names if possible (e.g. rgb = thisGLMS_real_trial.rgb)
if thisGLMS_real_trial != None:
    for paramName in thisGLMS_real_trial:
        exec('{} = thisGLMS_real_trial[paramName]'.format(paramName))

for thisGLMS_real_trial in gLMS_real_trials:
    currentLoop = gLMS_real_trials
    # abbreviate parameter names if possible (e.g. rgb = thisGLMS_real_trial.rgb)
    if thisGLMS_real_trial != None:
        for paramName in thisGLMS_real_trial:
            exec('{} = thisGLMS_real_trial[paramName]'.format(paramName))
    
    # ------Prepare to start Routine "intense_real"-------
    t = 0
    intense_realClock.reset()  # clock
    frameN = -1
    continueRoutine = True
    # update component parameters for each repeat
    intense_slider2.reset()
    intense_slider2 = visual.Slider(win=win, name='intense_slider2',
        size=(20, 800), pos=(200, 0),
        labels=('','Barely detectable', 'Weak', 'Moderate', 'Strong', 'Very strong', 'Strongest imaginable sensation of any kind'), 
        ticks=(0, 1.4,6,17,35,51,100),
        granularity=0, style=('triangleMarker','rating'), labelHeight=20,
        color='MidnightBlue', font='Arial',
        autoLog = True, flip=True);
    intense_slider2.marker.size=(30,30);
    intense_slider2.marker.color = 'red';
    trial_num_display2.setText(gLMS_real)
    # keep track of which components have finished
    intense_realComponents = [intense_text2, intense_slider2, intense_bottom_label2, trial_text2, trial_num_display2]
    for thisComponent in intense_realComponents:
        thisComponent.tStart = None
        thisComponent.tStop = None
        thisComponent.tStartRefresh = None
        thisComponent.tStopRefresh = None
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    
    # -------Start Routine "intense_real"-------
    while continueRoutine:
        # get current time
        t = intense_realClock.getTime()
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *intense_text2* updates
        if t >= 0.0 and intense_text2.status == NOT_STARTED:
            # keep track of start time/frame for later
            intense_text2.tStart = t  # not accounting for scr refresh
            intense_text2.frameNStart = frameN  # exact frame index
            win.timeOnFlip(intense_text2, 'tStartRefresh')  # time at next scr refresh
            intense_text2.setAutoDraw(True)
        
        # *intense_slider2* updates
        if t >= 0.0 and intense_slider2.status == NOT_STARTED:
            # keep track of start time/frame for later
            intense_slider2.tStart = t  # not accounting for scr refresh
            intense_slider2.frameNStart = frameN  # exact frame index
            win.timeOnFlip(intense_slider2, 'tStartRefresh')  # time at next scr refresh
            intense_slider2.setAutoDraw(True)
        
        # Check intense_slider2 for response to end routine
        if intense_slider2.getRating() is not None and intense_slider2.status == STARTED:
            continueRoutine = False
        
        # *intense_bottom_label2* updates
        if t >= 0.0 and intense_bottom_label2.status == NOT_STARTED:
            # keep track of start time/frame for later
            intense_bottom_label2.tStart = t  # not accounting for scr refresh
            intense_bottom_label2.frameNStart = frameN  # exact frame index
            win.timeOnFlip(intense_bottom_label2, 'tStartRefresh')  # time at next scr refresh
            intense_bottom_label2.setAutoDraw(True)
        
        # *trial_text2* updates
        if t >= 0.0 and trial_text2.status == NOT_STARTED:
            # keep track of start time/frame for later
            trial_text2.tStart = t  # not accounting for scr refresh
            trial_text2.frameNStart = frameN  # exact frame index
            win.timeOnFlip(trial_text2, 'tStartRefresh')  # time at next scr refresh
            trial_text2.setAutoDraw(True)
        
        # *trial_num_display2* updates
        if t >= 0.0 and trial_num_display2.status == NOT_STARTED:
            # keep track of start time/frame for later
            trial_num_display2.tStart = t  # not accounting for scr refresh
            trial_num_display2.frameNStart = frameN  # exact frame index
            win.timeOnFlip(trial_num_display2, 'tStartRefresh')  # time at next scr refresh
            trial_num_display2.setAutoDraw(True)
        
        # check for quit (typically the Esc key)
        if endExpNow or defaultKeyboard.getKeys(keyList=["escape"]):
            core.quit()
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in intense_realComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "intense_real"-------
    for thisComponent in intense_realComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    gLMS_real_trials.addData('intense_text2.started', intense_text2.tStartRefresh)
    gLMS_real_trials.addData('intense_text2.stopped', intense_text2.tStopRefresh)
    gLMS_real_trials.addData('intense_slider2.response', intense_slider2.getRating())
    gLMS_real_trials.addData('intense_slider2.rt', intense_slider2.getRT())
    gLMS_real_trials.addData('intense_slider2.started', intense_slider2.tStartRefresh)
    gLMS_real_trials.addData('intense_slider2.stopped', intense_slider2.tStopRefresh)
    gLMS_real_trials.addData('intense_bottom_label2.started', intense_bottom_label2.tStartRefresh)
    gLMS_real_trials.addData('intense_bottom_label2.stopped', intense_bottom_label2.tStopRefresh)
    gLMS_real_trials.addData('trial_text2.started', trial_text2.tStartRefresh)
    gLMS_real_trials.addData('trial_text2.stopped', trial_text2.tStopRefresh)
    gLMS_real_trials.addData('trial_num_display2.started', trial_num_display2.tStartRefresh)
    gLMS_real_trials.addData('trial_num_display2.stopped', trial_num_display2.tStopRefresh)
    # the Routine "intense_real" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    thisExp.nextEntry()
    
# completed 1 repeats of 'gLMS_real_trials'


# ------Prepare to start Routine "please_wait"-------
t = 0
please_waitClock.reset()  # clock
frameN = -1
continueRoutine = True
# update component parameters for each repeat
return_key = keyboard.Keyboard()
# keep track of which components have finished
please_waitComponents = [please_wait_text, return_key]
for thisComponent in please_waitComponents:
    thisComponent.tStart = None
    thisComponent.tStop = None
    thisComponent.tStartRefresh = None
    thisComponent.tStopRefresh = None
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED

# -------Start Routine "please_wait"-------
while continueRoutine:
    # get current time
    t = please_waitClock.getTime()
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # *please_wait_text* updates
    if t >= 0.0 and please_wait_text.status == NOT_STARTED:
        # keep track of start time/frame for later
        please_wait_text.tStart = t  # not accounting for scr refresh
        please_wait_text.frameNStart = frameN  # exact frame index
        win.timeOnFlip(please_wait_text, 'tStartRefresh')  # time at next scr refresh
        please_wait_text.setAutoDraw(True)
    
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
    for thisComponent in please_waitComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# -------Ending Routine "please_wait"-------
for thisComponent in please_waitComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
# the Routine "please_wait" was not non-slip safe, so reset the non-slip timer
routineTimer.reset()

# set up handler to look after randomisation of conditions etc
LHS_trials = data.TrialHandler(nReps=1, method='sequential', 
    extraInfo=expInfo, originPath=-1,
    trialList=data.importConditions('LHS.xlsx'),
    seed=None, name='LHS_trials')
thisExp.addLoop(LHS_trials)  # add the loop to the experiment
thisLHS_trial = LHS_trials.trialList[0]  # so we can initialise stimuli with some values
# abbreviate parameter names if possible (e.g. rgb = thisLHS_trial.rgb)
if thisLHS_trial != None:
    for paramName in thisLHS_trial:
        exec('{} = thisLHS_trial[paramName]'.format(paramName))

for thisLHS_trial in LHS_trials:
    currentLoop = LHS_trials
    # abbreviate parameter names if possible (e.g. rgb = thisLHS_trial.rgb)
    if thisLHS_trial != None:
        for paramName in thisLHS_trial:
            exec('{} = thisLHS_trial[paramName]'.format(paramName))
    
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
    trial_num_display3.setText(LHS)
    # keep track of which components have finished
    likeComponents = [like_text, like_slider, like_neutral_label, trial_text3, trial_num_display3]
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
        
        # *trial_text3* updates
        if t >= 0.0 and trial_text3.status == NOT_STARTED:
            # keep track of start time/frame for later
            trial_text3.tStart = t  # not accounting for scr refresh
            trial_text3.frameNStart = frameN  # exact frame index
            win.timeOnFlip(trial_text3, 'tStartRefresh')  # time at next scr refresh
            trial_text3.setAutoDraw(True)
        
        # *trial_num_display3* updates
        if t >= 0.0 and trial_num_display3.status == NOT_STARTED:
            # keep track of start time/frame for later
            trial_num_display3.tStart = t  # not accounting for scr refresh
            trial_num_display3.frameNStart = frameN  # exact frame index
            win.timeOnFlip(trial_num_display3, 'tStartRefresh')  # time at next scr refresh
            trial_num_display3.setAutoDraw(True)
        
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
    LHS_trials.addData('like_slider.response', like_slider.getRating())
    LHS_trials.addData('trial_text3.started', trial_text3.tStartRefresh)
    LHS_trials.addData('trial_text3.stopped', trial_text3.tStopRefresh)
    LHS_trials.addData('trial_num_display3.started', trial_num_display3.tStartRefresh)
    LHS_trials.addData('trial_num_display3.stopped', trial_num_display3.tStopRefresh)
    # the Routine "like" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
    thisExp.nextEntry()
    
# completed 1 repeats of 'LHS_trials'


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
