(defvar WIDTH 720)
(defvar HEIGHT 720)
(defvar current_grid) ; The grid used as input on loop t + 0
(defvar next_grid) ; The grid used as input on loop t + 1

(defvar N 16) ; y
(defvar M 16) ; x

(defvar N_size (/ WIDTH N))
(defvar M_size (/ HEIGHT M))

(defvar COLOR_ALIVE (sdl:color :r 255 :g 255 :b 255)) ;;white

(defvar ZOOM 1.0)

;;debug
(defvar X 0)
