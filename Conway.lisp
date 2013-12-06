(in-package "ACL2")
(include-book "avl-rational-keys" :dir :teachpacks)
(include-book "io-utilities" :dir :teachpacks)
(include-book "io-utilities-ex" :dir :teachpacks)
(set-state-ok t)



(defun stdin->string (state)
   (mv-let (chli error state)
           (let ((channel *standard-ci*))
              (if (null channel)
                  (mv nil
                      "Error while opening stdin for input"
                      state)
                  (mv-let (chlist chnl state)
                          (read-n-chars 4000000000 '() channel state)
                     (let ((state (close-input-channel chnl state)))
                       (mv chlist nil state)))))
      (mv (reverse (chrs->str chli)) error state)))

(defun string-list->stdout (strli state)
  (let ((channel *standard-co*))
     (if (null channel)
         (mv "Error while opening stdout"
             state)
         (mv-let (channel state)
                 (write-all-strings strli channel state)
            (let ((state (close-output-channel channel state)))
              (mv nil state))))))

(defun stdin->lines (state)
  (mv-let (chnl state) 
		 (mv *standard-ci* state)
     (if (null chnl)
         (mv "Error opening standard input" state)
         (mv-let (c1 state)                       ; get one char ahead
                 (read-char$ chnl state)
            (mv-let (rv-lines state)      ; get line, record backwards
                    (rd-lines 4000000000 c1 nil chnl state)
               (let* ((state (close-input-channel chnl state)))
                     (mv (reverse rv-lines) state))))))); rev, deliver

;added width input
(defun get-avl-key (x y width)
   (+ (* width y) x))

;added x y width input
(defun input-lines->avl-tree (x y width input-lines last-gen)
   (if (and (integerp x)
            (integerp y)
            (integerp width)
            (tree? last-gen)                 
            (consp input-lines))
       (if (endp (car input-lines))
           (input-lines->avl-tree 0 (1+ y) width (cdr input-lines) last-gen)
           (input-lines->avl-tree (1+ x) y width (cons (cdar input-lines) (cdr input-lines))
                                  (if (equal (car (car input-lines)) #\x)
                                      (avl-insert last-gen (get-avl-key x y width) 0)
                                      last-gen)))
       last-gen))

(defun strings->char-lists (lst)
   (if (endp lst)
       nil
       (cons (coerce (car lst) 'list) (strings->char-lists (cdr lst)))))

(defun stdin->avl-tree (state)
   (mv-let (input-lines state)
           (stdin->lines state)
      (let* ((height (len input-lines))
             (width (length (car input-lines))))
            (mv (list (input-lines->avl-tree 0 0 width (strings->char-lists input-lines) (empty-tree)) width height) state))))
            ;(mv (input-lines->avl-tree 0 0 width (strings->char-lists input-lines) (empty-tree)) width height state))))


;added n counter
(defun num-live-neighbors (n width height x y last-gen)
   (if (or (= n 0) (not (natp n))) ; this should be just (if (= n 0)), but this way makes ACL2 happy
       0
       (if (= n 5)
           (+ 0 (num-live-neighbors (1- n) width height x y last-gen))
           (let* ((i (mod (+ (1- x) (floor (1- n) 3)) width))
                  (j (mod (+ (1- y) (mod (1- n) 3)) height))
                  (key (get-avl-key i j width))
                  (live (if (null (avl-retrieve last-gen key)) 0 1)))
                 (+ live (num-live-neighbors (1- n) width height x y last-gen))))))

(defun build-next-generation-cell (width height x y last-gen next-gen)
   (let* ((n (num-live-neighbors 9 width height x y last-gen))
          (result (if (null (avl-retrieve last-gen (get-avl-key x y width)))
                      (if (= n 3) "x" nil)
                      (if (or (< n 2) (> n 3)) nil "x"))))
         (if result
             (avl-insert next-gen (get-avl-key x y width) result)
             next-gen)))
                
; added curx counter
(defun build-next-generation-row (width height curx y last-gen next-gen)
   (let* ((new-tree (build-next-generation-cell width height curx y last-gen next-gen))
          (next-x (1- curx)))
         (if (or (= curx 0) (not (natp curx))) ; should just be (if (= curx 0), but this way makes ACL2 admit the function
             new-tree
             (build-next-generation-row width height next-x y last-gen new-tree))))

(defun build-next-generation (width height cury last-gen next-gen)
   (let* ((new-tree (build-next-generation-row width height (- width 1) cury last-gen next-gen))
          (next-y (1- cury)))
         (if (or (= cury 0) (not (natp cury)))
             new-tree
             (build-next-generation width height next-y last-gen new-tree))))

#| This function only exists because Proof Pad is buggy and completely breaks
   if we use any string with a semicolon in it.  So we have to hack around 
   the Proof Pad bug in ACL2 using this function. |#
(defun tablecell (live)
   (let* ((semicolon (coerce (list (code-char 59)) 'string))
          (cell-part2 (string-append (string-append "&nbsp" semicolon) "</td>")))
         (if live
             (string-append "<td class='live'>" cell-part2)
             (string-append "<td>" cell-part2))
          ))


(defun avl-tree->output-line (width curx y next-gen)
   (if (and (> curx 0) (integerp curx))
       ;(string-append (if (avl-retrieve next-gen (get-avl-key (- width curx) y width)) "<td class='live'>&nbsp;</td>" "<td>&nbsp;</td>")
       (string-append (tablecell (avl-retrieve next-gen (get-avl-key (- width curx) y width))) ;"<td class='live'>&nbsp;</td>" "<td>&nbsp;</td>")
             (avl-tree->output-line width (1- curx) y next-gen))
       nil))


(defun avl-tree->output-lines (width height cury next-gen)
   (if (and (> cury 0) (integerp cury))
       (cons (string-append "<tr>" (string-append (avl-tree->output-line width width (- height cury) next-gen) "</tr>"))
             (avl-tree->output-lines width height (1- cury) next-gen))
       nil))

;test input
#|(num-live-neighbors 0 4 4 1 1 
                    (input-lines->avl-tree 0 0 4 (list (coerce "x xx" 'list)
                                                       (coerce "xxxx" 'list)
                                                       (coerce "x  x" 'list)
                                                       (coerce "   x" 'list))
                                           (empty-tree)))

; test input 2
(build-next-generation-row 4 4 0 0 (input-lines->avl-tree 0 0 4 (list (coerce "x xx" 'list)
                                                                                                          (coerce "xxxx" 'list)
                                                                                                          (coerce "x  x" 'list)
                                                                                                          (coerce "   x" 'list))
                                                                                              (empty-tree))
                                                               (empty-tree))

; test input 3
(avl-tree->output-line 4 0 0 (build-next-generation-row 4 4 0 0 (input-lines->avl-tree 0 0 4 (list (coerce "x xx" 'list)
                                                                                                          (coerce "xxxx" 'list)
                                                                                                          (coerce "x  x" 'list)
                                                                                                          (coerce "   x" 'list))
                                                                                              (empty-tree))
                                                               (empty-tree)))

; test input 4
(avl-tree->output-lines 4 4 0 (build-next-generation 4 4 3 (input-lines->avl-tree 0 0 4 (list (coerce "x xx" 'list)
                                                                                              (coerce "xxxx" 'list)
                                                                                              (coerce "x  x" 'list)
                                                                                              (coerce "   x" 'list))
                                                                                              (empty-tree))
                                                               (empty-tree)))

; test input 5
(avl-tree->output-lines 4 4 0 (build-next-generation 4 4 0 (input-lines->avl-tree 0 0 4 (list (coerce " x  " 'list)
                                                                                              (coerce "xx  " 'list)
                                                                                              (coerce "    " 'list)
                                                                                              (coerce "    " 'list))
                                                                                              (empty-tree))
                                                               (empty-tree)))
|#

(defun main (state)
   (mv-let (things state)
           (stdin->avl-tree state)
      (let ((avl-tree (car things))
            (width (cadr things))
            (height (caddr things)))
           (string-list->stdout (avl-tree->output-lines width height height (build-next-generation width height (- height 1) avl-tree
		                                                           (empty-tree))) state))))