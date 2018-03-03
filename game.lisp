(load "sdl.lisp")
(load "variables.lisp")

(defun game (A) (
	let ()
	;;ici on image la boucle qui check dans le tableau A
	;;et decide de draw ou pas

	;;DEBUG
	(draw 0 5 ALIVE) ;;draw on screen
	(draw 0 0 DEAD) ;;draw on screen
	(draw 0 1 DEAD) ;;draw on screen
	(draw 0 2 DEAD) ;;draw on screen
	(draw 0 3 DEAD) ;;draw on screen
	(draw 10 10 ALIVE) ;;draw on screen
	(draw 15 15 ALIVE) ;;draw on screen
	(draw 1 1 ALIVE) ;;draw on screen
))

;;(defun init (n m) (
	;;return un array (matrix) de taille N*M ??
;;	0
;;)
