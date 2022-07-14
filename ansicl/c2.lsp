(load "headers.lsp")


(chapter 2 "WELCOME TO LISP")


(section 2 1 "Form")
1
(+ 2 3)
(+ 2 3 4)
(+ 2 3 4 5)
(/ (- 7 1) (- 4 2))


(section 2 2 "Evaluation")
(quote (+ 3 5))
'(+ 3 5)


(section 2 3 "Data")
'Artichoke
'(my 3 "Sons")
'(the list (a b c) has 3 elements)
(list 'my (+ 2 1) "Sons")
(list '(+ 2 1) (+ 2 1))
()
nil


(section 2 4 "List Operations")
(cons 'a '(b c d))
(cons 'a (cons 'b nil))
(list 'a 'b)
(car '(a b c))
(cdr '(a b c))
(car (cdr (cdr '(a b c d))))
(third '(a b c d))


(section 2 5 "Truth")
(listp '(a b c))
(listp 27)
(null nil)
(not nil)
(if (listp '(a b c))
  (+ 1 2)
  (+ 5 6))
(if (listp 27)
  (+ 1 2)
  (+ 5 6))
(if (listp 27)
  (+ 2 3))
(if 27 1 2)
(and t (+ 1 2))


(section 2 6 "Functions")
(defun our-third (x)
  (car (cdr (cdr x))))
(our-third '(a b c d))
(> (+ 1 4) 3)
(defun sum-greater (x y z)
  (> (+ x y) z))
(sum-greater 1 4 3)


(section 2 7 "Recursion")
(defun our-member (obj lst)
  (if (null lst)
    nil
    (if (eql obj (car lst))
      lst
      (our-member obj (cdr lst)))))


(section 2 8 "Reading Lisp")


(section 2 9 "Input and Output")
(format t "~A plus ~A equals ~A,~%" 2 3 (+ 2 3))
(defun askem (string)
  (format t "~A" string)
  (read))
;(askem "How old are you?"))


(section 2 10 "Variables")
(let ((x 1) (y 2))
  (+ x y))
(defun ask-number ()
  (format t "Please enter a number.")
  (let ((val (read)))
    (if (numberp val)
      val
      (ask-number))))
;(ask-number)
(defparameter *glob* 99)
(defconstant limit (+ *glob* 1))
(boundp '*glob*)


(section 2 11 "Assignment")
(setf *glob* 98)
(let ((n 10))
  (setf n 2)
  n)
(setf x (list 'a 'b 'c))
x
(setf (car x) 'n)
x
(setf a 3 v 6 s 42)
a


(defconstant constant 5)
(defparameter *global* 5)
(let ((local 5))
  '(do stuff)
  '(return last))
(setf var 5)
(setf (first (list *global* constant)) 4)
*global* ; 4 ?


(section 2 12 "Functional Programming")
(setf lst '(c a r a t))
(remove 'a lst)
lst
(setf x '(a b c))
(setf x (remove 'a x))
x



(section 2 13 "Iteration")
(defun show-squares (start end)
  (do ((i start (+ i 1)))
    ((> i end) 'done)
    (format t "~A ~A~%" i (* i i))))
(show-squares 1 6)
(defun printall (lst)
  (do ((element (car lst) (setf lst (cdr lst) element (car lst))))
    ((null lst) 'done)
    (format t "~A~%" element)))
(printall '(a b c d e f))
(defun show-squares-rec (i end)
  (if (> i end)
    'done
    (progn
      (format t "~A ~A~%" i (* i i))
      (show-squares-rec (+ i 1) end))))
(show-squares-rec 1 6)
(defun our-length (lst)
  (let ((len 0))
    (dolist (obj lst)
      (setf len (+ len 1)))
    len))
(our-length '(1 2 3 4 5 6))
(defun our-length (lst)
  (if (null lst)
    0
    (+ (our-length (cdr lst)) 1)))


(section 2 14 "Functions as Objects")
(function +)
#'+
(apply #'+ (list 1 2 3))
(apply #'+ 1 2 '(3 4 5))
(funcall #'+ 1 2 3)
(lambda (x y)
  (+ x y))
((lambda (x) (+ x 100)) 1)
(funcall #'(lambda (x) (+ x 100)) 1)


(section 2 15 "Types")
(typep 27 'integer)
(typep 27 't)
(typep "hello" 't)
(typep "hello" 'integer)


(section 2 16 "Looking Forward")
