(in-package "ACL2")
;testing code
(include-book "Conway")
(include-book "doublecheck" :dir :teachpacks)
(include-book "list-utilities" :dir :teachpacks)
(include-book "testing" :dir :teachpacks)

;tests for get-avl-key
(check-expect (get-avl-key 1 1 3) 4)
(check-expect (get-avl-key 0 0 5) 0)
(check-expect (get-avl-key 5 5 5) 30)
(check-expect (get-avl-key 3 2 20) 43)

;tests for input-lines->avl-tree
(check-expect (input-lines->avl-tree 0 0 1 (list (coerce "x" 'list)) (empty-tree)) 
              (list 1 0 0 nil nil))
(check-expect (input-lines->avl-tree 0 0 2 (list (coerce " x" 'list) (coerce "x " 'list)) (empty-tree))
              (list 2 1 0 nil (list 1 2 0 nil nil)))
(check-expect (input-lines->avl-tree 0 0 2 (list (coerce "x " 'list) (coerce " x" 'list)) (empty-tree))
              (list 2 0 0 nil (list 1 3 0 nil nil)))
(check-expect (input-lines->avl-tree 0 0 2 (list (coerce "xx" 'list) (coerce "x " 'list)) (empty-tree))
              (list 2 1 0 (list 1 0 0 nil nil) (list 1 2 0 nil nil)))

;tests for strings->char-lists
(check-expect (strings->char-lists nil) nil)
(check-expect (strings->char-lists (list "hello")) (list (list #\h #\e #\l #\l #\o)))
(check-expect (strings->char-lists (list "x x" "  x" "x  ")) (list (list #\x #\Space #\x) (list #\Space #\Space #\x) (list #\x #\Space #\Space)))
(check-expect (strings->char-lists (list "xxx" "xxx")) (list (list #\x #\x #\x) (list #\x #\x #\x)))

;tests for num-live-neighbors
(check-expect (num-live-neighbors 0 1 1 0 0 (empty-tree)) 0)
(check-expect (num-live-neighbors 9 4 4 1 1 
                    (input-lines->avl-tree 0 0 4 (list (coerce "x xx" 'list)
                                                       (coerce "xxxx" 'list)
                                                       (coerce "x  x" 'list)
                                                       (coerce "   x" 'list))
                                           (empty-tree)))
               5)
(check-expect (num-live-neighbors 9 3 3 1 1 
                    (input-lines->avl-tree 0 0 3 (list (coerce "xxx" 'list)
                                                       (coerce "xxx" 'list)
                                                       (coerce "x x" 'list)
                                                       )
                                           (empty-tree))) 
              7)
(check-expect (num-live-neighbors 9 3 3 2 3 
                    (input-lines->avl-tree 0 0 3 (list (coerce "xxx" 'list)
                                                       (coerce "xxx" 'list)
                                                       (coerce "x x" 'list)
                                                       )
                                           (empty-tree))) 
              7)

;tests for build-next-generation-cell
(check-expect (build-next-generation-cell 1 1 0 0 (empty-tree) (empty-tree)) nil)
(check-expect (build-next-generation-row 4 4 1 1 (input-lines->avl-tree 0 0 4 (list (coerce "x xx" 'list)
                                                                                                          (coerce "xxxx" 'list)
                                                                                                          (coerce "x  x" 'list)
                                                                                                          (coerce "   x" 'list))
                                                                                              (empty-tree))
                                                               (empty-tree))
               nil)
(check-expect (build-next-generation-cell 1 1 0 0 (empty-tree) (empty-tree)) nil)
(check-expect (build-next-generation-cell 1 1 0 0 (empty-tree) (empty-tree)) nil)

;tests for build-next-generation-row
(check-expect (build-next-generation-row 1 1 0 0 (empty-tree) (empty-tree)) nil)
(check-expect (build-next-generation-row 1 1 0 0 (empty-tree) (empty-tree)) nil)
(check-expect (build-next-generation-row 1 1 0 0 (empty-tree) (empty-tree)) nil)
(check-expect (build-next-generation-row 1 1 0 0 (empty-tree) (empty-tree)) nil)

;tests for build-next-generation
(check-expect (build-next-generation 1 1 0 (empty-tree) (empty-tree)) nil)
(check-expect (build-next-generation 1 1 0 (empty-tree) (empty-tree)) nil)
(check-expect (build-next-generation 1 1 0 (empty-tree) (empty-tree)) nil)
(check-expect (build-next-generation 1 1 0 (empty-tree) (empty-tree)) nil)


;tests for tablecell
(check-expect (tablecell nil) (string-append "<td>&nbsp;</td>" nil))
(check-expect (tablecell t) (string-append "<td class='live'>&nbsp;</td>" nil))

;Properties

;get-avl-key property tests
(defproperty get-avl-key-prop 
   (width :value (random-between 1 1000) 
    x :value (random-between 0 width)
    y :value (random-between 0 width))
   (implies (and (natp x) (natp y) (natp width)) 
            (equal (get-avl-key x y width) (+ x (* y width)))
            )
  )