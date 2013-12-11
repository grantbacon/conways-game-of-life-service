Conway's Game of Life Service
===============

An implementation of Conway's Game of Life using ACL2. Python Bottle is used to provide a front end to the game, which can in turn be hosted as a service.

Usage
=============

Requirements
-------------

+ python2.7
+ proofpad (or some way to compile ACL2 code)

Start-up
--------------

1. Compile Conway.lisp into an executable
2. Edit 'harness/web_ui.py' to point to the executable you compiled
3. Run the web UI (using terminal/command line)

    python web_ui.py

4. Connect to <http://localhost:8085/>
