;;const

(defconstant WIDTH 720)
(defconstant HEIGHT 720)

(defvar current_grid) ; The grid used as input on loop t + 0
(defvar next_grid) ; The grid used as input on loop t + 1

(defvar *usage-string* "Usage: sbcl --script main.lisp height width

With:		height, non-zero positiv integer <= 150, the height of the grid
	width, non-zero positiv integer <= 150, the width of the grid

Note: Integers are `one-indexed`")

(defconstant DEAD 0)
(defconstant ALIVE 1)

(defvar N 16) ; y
(defvar M 16) ; x

(defvar COLOR_ALIVE (sdl:color :r 255 :g 0 :b 0)) ;;red
(defvar COLOR_DEAD (sdl:color :r 0 :g 0 :b 0)) ;;black
(defvar COLOR_BACKGROUND (sdl:color :r 0 :g 0 :b 255)) ;;white

(defvar PAUSE t)

(defvar offX 0)
(defvar offY 0)
(defvar zoom 0)
(defvar margin 0)
(defvar size (/ WIDTH 16))
(defvar drag nil) ; Boolean: Are we currently dragging ?
(defvar dragBuff nil) ; List:Bufferise mouse movement {y;x} form
(defvar prevDrag 0)
(defvar prevDragX 0)
(defvar prevDragY 0)


(defvar prev 0)
(defvar time-to-wait 1000)


;; Utility

(defun greater (a b) (if (> a b) a b))
