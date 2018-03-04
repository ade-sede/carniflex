;;const
(defconstant WIDTH 720)
(defconstant HEIGHT 720)

(defvar current_grid) ; The grid used as input on loop t + 0
(defvar next_grid) ; The grid used as input on loop t + 1

(defvar *usage-string* "Usage: sbcl --script main.lisp height width

With:		height, non-zero positiv integer, the height of the grid
	width, non-zero positiv integer, the width of the grid

Note: Integers are `one-indexed`")

(defconstant DEAD 0)
(defconstant ALIVE 1)

(defvar N 16) ; y
(defvar M 16) ; x

(defvar COLOR_ALIVE (sdl:color :r 255 :g 0 :b 0)) ;;red
(defvar COLOR_DEAD (sdl:color :r 0 :g 0 :b 0)) ;;black
(defvar COLOR_BACKGROUND (sdl:color :r 0 :g 0 :b 255)) ;;white

(defvar IMAGE_PER_SEC 1)
(defvar PAUSE t)

(defvar offX 0)
(defvar offY 0)
(defvar zoom 0)
(defvar margin 0)
(defvar size (/ WIDTH 16))
