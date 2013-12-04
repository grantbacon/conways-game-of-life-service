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
(check-expect (strings->char-lists ))

;tests for num-live-neighbors

;tests for build-next-generation-cell

;tests for build-next-generation-row

;tests for build-next-generation

;tests for tablecell