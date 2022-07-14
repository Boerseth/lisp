(load "headers.lsp")


(chapter 3 "LISTS")


(section 3 1 "Conses")
(setf x (cons 'a nil))
x
(car x)
(cdr x)
(setf y (list 'a 'b 'c))
(cdr y)
(setf z (list 'a (list 'b 'c) 'd))
(car (cdr z))
(consp (list 'a))
(consp nil)

(defun our-listp (x)
 (or (null x) (consp x)))
(our-listp nil)
(listp nil)
(our-listp (list 'a 'b))
(listp (list 'a 'b))
(defun our-atom (x) (not (consp x)))
(our-atom 3)
(atom 3)
(our-atom nil)
(atom nil)


(section 3 2 "Equality")
(eql (cons 'a nil) (cons 'a nil))
(setf x (cons 'a nil))
(eql x x)
(equal x (cons 'a nil))
(defun our-equal (x y)
  (or (eql x y)
      (and (consp x)
           (consp y)
           (our-equal (car x) (car y))
           (our-equal (cdr x) (cdr y)))))


(section 3 3 "Why Lisp Has No Pointers")
(setf x '(a b c))
(setf y x)
(eql x y)
(setf x nil)
y


(section 3 4 "Building Lists")
(setf x '(a b c) y (copy-list x))
(defun our-copy-list (lst)
  (if (atom lst)
      lst
      (cons (car lst) (our-copy-list (cdr lst)))))
(eql x (copy-list x))
(equal x (copy-list x))
(append '(a b) '(c d) '(e))


(section 3 5 "Compression")
(defun compress (x)
  (if (consp x)
      (compr (car x) 1 (cdr x))
      x))

(defun compr (elt n lst)
  (if (null lst)
      (list (n-elts elt n))
      (if (eql (car lst) elt)
          (compr elt (+ n 1) (cdr lst))
          (cons (n-elts elt n)
                (compr (car lst) 1 (cdr lst))))))

(defun n-elts (elt n)
  (if (> n 1)
      (list n elt)
      elt))

(compress '(1 1 1 0 1 0 0 0 0 1))

(defun uncompress (lst)
  (if (null lst)
    nil
    (let ((elmt (car lst))
          (tail (uncompress (cdr lst))))
      (if (consp elmt)
          (append (apply #'list-of elmt) tail)
          (cons elmt tail)))))

(defun list-of (n el)
  (if (zerop n)
      nil
      (cons el (list-of (- n 1) el))))

(uncompress '((3 1) 0 1 (4 0) 1))
(list-of 3 'ho)


(section 3 6 "Access")
(nth 0 '(a b c))
(nthcdr 2 '(a b c d e))
(defun our-nthcdr (n lst)
  (if (< n 1)
    lst
    (our-nthcdr (- n 1) (cdr lst))))
'our-nthcdr
(last '(a b c))
(defun our-last (lst)
  (if (null (cdr lst))
      lst
      (our-last (cdr lst))))
'our-last
(our-last '(a b c))


(section 3 7 "Mapping Functions")
(mapcar #'(lambda (x) (+ x 10)) '(1 2 3))

(mapcar #'list
       '(a b c)
       '(1 2 3 4))
(maplist #'(lambda (x) x) '(a b c))


(section 3 8 "Trees")
(defun our-copy-tree (tr)
  (if (atom tr)
      tr
      (cons (our-copy-tree (car tr))
            (our-copy-tree (cdr tr)))))

(substitute 'y 'x '(and (integerp x) (zerop (mod x 2))))
(subst 'y 'x '(and (integerp x) (zerop (mod x 2))))
(defun our-subst (new old tree)
  (if (eql tree old)
      new
      (if (atom tree)
          tree
          (cons (our-subst new old (car tree))
                (our-subst new old (cdr tree))))))


(section 3 9 "Understanding Recursion")
(defun len (lst)
  (if (null lst)
      0
      (+ 1 (len (cdr lst)))))


(section 3 10 "Sets")
(member 'b '(a b c))
(member '(a) '((a) (z)) :test #'equal)
(member 'a '((a b) (c d)) :key #'car)
(member 2 '((1) (2)) :key #'car :test #'equal)
(member 2 '((1) (2)) :test #'equal :key #'car)
(member-if #'oddp '(2 3 4))
(defun our-member-if (fn lst)
  (and (consp lst)
       (if (funcall fn (car lst))
           lst
           (our-member-if fn (cdr lst)))))
(adjoin 'b '(a b c))
(adjoin 'z '(a b c))
(union '(a b c) '(c b s))
(intersection '(a b c) '(b b c))
(set-difference '(a b c d e) '(b c))


(section 3 11 "Sequences")
(length '(a b c))
(subseq '(a b c d) 1 2)
(subseq '(a b c d) 1)
(reverse '(a b c))
(defun mirrorp (s)
  (let ((len (length s)))
    (if (evenp len)
        (let ((mid (/ len 2)))
          (equal (subseq s 0 mid)
                 (reverse (subseq s mid))))
        (let ((mid (/ (+ len 1) 2)))
          (equal (subseq s 0 mid)
                 (reverse (subseq s (- mid 1))))))))
(mirrorp '(a b b a))
(mirrorp '(a b a))
(mirrorp '(a b c b a))
(mirrorp '(a b c c b a))
(mirrorp '(a b d c b a))
(mirrorp '(a b d a c b a))
(/ 4 2)
(/ 5 2)
(sort '(0 2 1 3 8) #'>)
(sort '(0 2 1 3 8) #'<)
(defun nthmost (n lst)
  (nth (- n 1)
       (sort (copy-list lst) #'>)))
'nthmost
(nthmost 2 '(0 2 1 3 8))
(every #'oddp '(1 3 5))
(some #'evenp '(1 2 3))
(every #'> '(1 3 5) '(0 2 4))


(section 3 12 "Stacks")
(setf x '(b))
(push 'a x)
x
(setf y x)
(pop x)
x
y
(defun our-reverse (lst)
  (let ((acc nil))
    (dolist (elmt lst)
      (push elt acc))
    acc))
  (let ((x '(a b)))
     (pushnew 'c x)
     (pushnew 'a x)
     x)


(section 3 13 "Dotted Lists")
(defun properlistp (x)
  (or (null x)
      (and (consp x)
           (properlistp (cdr x)))))
(setf pair (cons 'a 'b))
'(a . b)
'(a . nil)
'(a . (b . (c . nil)))
(cons 'a (cons 'b (cons 'c 'd)))
'(a . (b . nil))
'(a . (b))
'(a b . nil)
'(a b)


(section 3 14 "Assoc-lists")
(setf trans '((+ . "add") (- . "subtract")))
(assoc '+ trans)
(assoc '* trans)
(defun our-assoc (key alist)
  (and (consp alist)
       (let ((pair (car alist)))
         (if (eql key (car pair))
             pair
             (our-assoc key (cdr alist))))))


(section 3 15 "Example: Shortest Path")
(setf min '((a b c) (b c) (c d)))
(cdr (assoc 'a min))

(defun shortest-path (start end net)
  (bfs end (list (list start)) net))

(defun bfs (end queue net)
  (if (null queue)
      nil
      (let ((path (car queue)))
        (let ((node (car path)))
          (if (eql node end)
              (reverse path)
              (bfs end
                   (append (cdr queue)
                           (new-paths path node net))
                   net))))))

(defun new-paths (path node net)
  (mapcar #'(lambda (n)
              (cons n path))
          (cdr (assoc node net))))

(shortest-path 'a 'd min)
