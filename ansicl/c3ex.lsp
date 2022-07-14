(load "headers.lsp")
(section "" "" "Exercises")
(exercise "1." "Show the following lists in box notation:")
(exercise "[a]" "(a b (c d))")
(answer "
->[ | ]->[ | ]->[ | ]-> nil
   |      |      |
   V      V      V
   a      b     [ | ]->[ | ]-> nil
                 |      |
                 V      V
                 c      d
")
(done)

(exercise "[b]" "(a (b (c (d))))")
(answer "
->[ | ]->[ | ]-> nil
   |      |
   V      V
   a     [ | ]->[ | ]-> nil
          |      |
          V      V
          b     [ | ]->[ | ]-> nil
                 |      |
                 V      V
                 c     [ | ]-> nil
                        |
                        V
                        d
")
(done)

(exercise "[c]" "(((a b) c) d)")
(answer "
->[ | ]->[ | ]-> nil
   |      |
   |      V
   |      d
   |
  [ | ]->[ | ]-> nil
   |      |
   |      V
   |      c
   V
  [ | ]->[ | ]-> nil
   |      |
   V      V
   a      b
")
(done)

(exercise "[d]" "(a (b . c) . d)")
(answer "
->[ | ]->[ | ]-> d
   |      |
   V      V
   a     [ | ]-> c
          |
          V
          b
")
(ddone)


(exercise "2." "Write a version of union that preserves the order of the elements in the original lists:
    > (new-union '(a b c) '(b a d))
    (A B C D)
")
(defun new-union-rec (set1 set2)
  (reverse (include set2 (include set1 nil))))
(defun include (elements inclusion)
  (if (null elements)
      inclusion
      (if (member (car elements) inclusion)
          (include (cdr elements) inclusion)
          (include (cdr elements) (cons (car elements) inclusion)))))
""
(defun new-union-iter (set1 set2)
  (let ((new-set nil))
    (dolist (el1 set1)
        (if (not (member el1 new-set))
            (setf new-set (cons el1 new-set))))
    (dolist (el2 set2)
        (if (not (member el2 new-set))
            (setf new-set (cons el2 new-set))))
    (reverse new-set)))
""
(defun new-union (set1 set2) (new-union-rec set1 set2))
(new-union '(a b c) '(b a d))
(ddone)


(exercise "3." "Define a function that takes a list and returns a list indicating the number of times each (eql) element appears, sorted from most common to least common:
    > (occurrences '(a b a d a c d c a))
    ((A . 4) (C . 2) (D . 2) (B . 1))
")
(defun occurrences-iter (history)
  (let ((occs nil))
    (dolist (elmt history)
      (let ((entry (assoc elmt occs)))
        (if (null entry)
            (setf occs (cons (cons elmt 1) occs))
            (setf (cdr entry) (+ 1 (cdr entry))))))
    (sort occs #'(lambda (x y) (> (cdr x) (cdr y))))))

(occurrences-iter '(a b a d a c d c a))

(defun occurences-rec (lst)
  (sort (occurences-lib lst nil) #'> :key #'cdr))

(defun occurences-lib (lst acc)
  (if (null lst)
    acc
    (if (null (assoc (car lst) acc))
        (occurences-lib (cdr lst) (cons (cons (car lst) 1) acc))
        (let ((cur (assoc (car lst) acc))
              (new (cons (car lst) (+ 1 (cdr cur)))))
          (occurences-lib (cdr lst) (substitute new cur acc :test #'equal))))))

;(occurrences-rec '(a b a d a c d c a))
;
;(defun occurrences (history)
;  (let ((occs '(nil)))
;    (dolist (elmt history)
;      (let ((cnt (cdr (assoc elmt occs))))
;        (if (null cnt)
;            (setf occs (append '((elmt . 1)) occs))
;            (setf (cdr (assoc elmt occs)) (+ cnt 1)))))
;    (sort occs #'(lambda (x y) (> (cdr x) (cdr y))))))
;
;(defun occurrences (history)
;  (let ((occs nil))
;    (dolist (elmt history)
;      (let ((cnt (cdr (assoc elmt occs))))
;        (if (null cnt)
;            (setf occs (cons (cons elmt 1) occs))
;            (setf (cdr (assoc elmt occs)) (+ cnt 1)))))
;    (sort occs #'(lambda (x y) (> (cdr x) (cdr y)))))) 
;
(ddone)


(exercise "4." "Why does (member '(a) '((a) (b))) return nil?")
(answer "Because while '(a) and the first element of the list are `equal`, they are not `eql`. The two are differnt conses.")
(ddone)


(exercise "5." "Suppose a function pos+ takes a list and returns a list of each element plus its position:
    > (pos+ '(7 5 1 4))
    (7 6 3 7)
Define this function using (a) recursion, (b) iteration, (c) mapcar.
")
(answer "[a]")
(defun pos+rec (lst)
  (pos+rec-lib lst 0))
(defun pos+rec-lib (lst n)
  (if (not (null lst))
      (cons (+ n (car lst)) (pos+rec-lib (cdr lst) (+ 1 n)))))
(pos+rec '(7 5 1 4))
(done)

(answer "[b]")
(defun pos+iter (lst)
  (let ((n 0)
        (new-lst '()))
    (dolist (elmt lst)
      (push (+ elmt n) new-lst)
      (setf n (+ n 1)))
    (reverse new-lst)))
(pos+iter '(7 5 1 4))
(done)

(answer "[c]")
(defun pos+mapcar (lst)
  (let ((n -1))
    (mapcar 
      #'(lambda (x)
          (setf n (+ n 1)) 
          (+ x n)) 
      lst)))
(pos+mapcar '(7 5 1 4))
(ddone)

(exercise "6." "After years of deliberation, a government commission has decided that lists should be represented by using the cdr to point to the first element and the car to point to the rest of the list. Define the government version of the following functions:")
(exercise "[a]" "cons")
(defun cons-g (car-g cdr-g) 
  (cons cdr-g car-g))
(done)

(exercise "[b]" "list")
(defun list-g (elmt)
  (cons nil elmt))
"I don't know how to make this for arbitrary many elements."
(done)

(exercise "[c]" "length (for lists)")
(defun length-g (lst)
  (if (null (car lst))
    0
    (+ 1 (length-g (car lst)))))
(done)

(exercise "[d]" "member (for lists; no keywords)")
(defun member-g (elmt lst)
  (if (eql elmt (cdr lst))
      lst
      (if (null (car lst))
          nil
          (member-g elmt (car lst)))))
(ddone)


(exercise "7." "Modify the program in figure 3.6 to use fewer cons cells. (Hint: Use dotted lists.)")
(exercise "8." "Define a function that takes a list and prints it in dot notaiton:
    > (showdots '(a b c))
    (A . (B . (C . NIL)))
    NIL
")
(defun showdots (lst)
  (if (consp lst)
    (format nil "(~A . ~A)" (car lst) (showdots (cdr lst)))))
(showdots '(a b c))
(ddone)


(exercise "9." "Write a program to find the _longest_ finite path through a network represented as in Section 3.15. The network may contain cycles.")
(defun longest-path (start end net)
  (bfs end (list (list start)) nil net))
""
(defun bfs (end queue longest net)
  (if (null queue)
      (if (null longest) 
          nil 
          longest)
      (let ((path (car queue)))
        (let ((node (car path)))
          (if (member node (cdr path))
              (bfs end (cdr queue) longest net)
              (if (eql node end)
                  (if (> (length path) (length longest))
                      (bfs end (cdr queue) (reverse path) net)
                      (bfs end (cdr queue) longest net))
                  (bfs end
                       (append (cdr queue)
                               (new-paths path node net))
                       longest
                       net)))))))
""
(defun new-paths (path node net)
  (mapcar #'(lambda (n)
              (cons n path))
          (cdr (assoc node net))))
""
(setf my-net '((a b c) (b c) (c d)))
(longest-path 'a 'd my-net)
