(load "sdl.lisp")
(load "variables.lisp")

(defun check_life (y x) (
	(defvar i 0)
	(defvar live 0)
	(loop
		(defvar j 0)
		(setq i (+ i 1))
			(loop
				(setq j (+ j 1))
				(if (and (not (and (= i y) (= j x)))
					(and (/= (ignore-errors (aref current_grid i j)) NIL)
						(= (ignore-errors (aref current_grid i j)) 1)))
						(setq live (+ live 1)))
	)))
	(return live)
)
(defun game (A) (
	let ()
	(defvar x)
	(defvar y)
	(setq y 0)
	(loop
		(setq x 0)
		(setq y (+ y 1))
		(loop
			(setq x (+ x 1))
			(write )
			(terpri)
			(when (> x N) (return x))
		)
		(when (> y M) (return y))
	)
	;;ici on image la boucle qui check dans le tableau A
	;;et decide de draw ou pas

	;;DEBUG
	(draw X 0) ;;draw on screen
	(setq X (+ X 1))
))

;;(defun init (n m) (
	;;return un array (matrix) de taille N*M ??
;;	0
;;)
