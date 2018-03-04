(load "variables.lisp")

(defun gamePause () (
	let ()
	(setq PAUSE (not PAUSE))
))

(defun time-now () (
    get-internal-real-time
))

(defun is-elapsed (prev elapse) (
    if (>= (- (time-now) prev) elapse)
        1
        nil
))

(defun check_time () (
	let ((play nil))
	(if (and (not PAUSE) (is-elapsed Ntime wait))
	(setq play t))
	play
))