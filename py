#!/bin/bash

ipython -c "import sys, os, time, glob, json;\
  import numpy as np;\
  import scipy.interpolate;\
  import scipy.signal;\
  import pprint;\
  import inspect;\
  import rawpipe;\
  import imgio;\
  import imsize;\
  import pyplottr;\
  import code;\
  code.interact(local=locals())"
