# CARNIFLEX rush
Conway's game of life in SBCL, and my first exposure to CL.

Rushes are a particular exercise at [42](http://www.42.fr/) with the following format :
- Unknown subject before the start of the exercise
- Random teammates
- Limited time

## Disclaimers
This sucks.  
It's bad CL. My first time ever writing CL, with 48h deadline.  
The lisp is horribly written and all formatting rules are broken.  
The UI is terrible.  

But Hey, it runs !

## Dependencies
[SBCL](http://www.sbcl.org/)
[Quicklisp](https://www.quicklisp.org/beta/)
[SDL2](https://www.libsdl.org)


## Running
```sh
sbcl --script main.lisp x y
```
Where X and Y are the dimensions of the grid.  

Press P to toggle between pause and running state.  
Click on the grid to give birth / kill cells.  
Press `,` to slow the game down.  
Press `.` to sleep it up.  
Press `+` to zoom in.  
Press `-` to zoom out.  
Use arrow keys to move around the grid.  

I advise you pause the game before clicking, makes things simpler.  
