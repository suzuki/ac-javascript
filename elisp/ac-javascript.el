;; ac-javascript
(require 'auto-complete)

(defsubst ac-javascript-current-directory()
  (file-name-directory
   (expand-file-name
    (or (buffer-file-name)
        default-directory))))

(defun ac-javascript-go-into-braces-action ()
  (save-restriction
    (narrow-to-region (point) (- (point) 2))
    (if (re-search-backward "()" nil t)
        (forward-char))))

;; (defun ac-javascript-document-prefix()
;;   "`document' properties "
;;   (if (re-search-backward "document\\.\\(.*\\)" nil t)
;;       (match-beginning 1)))

(defun ac-javascript-common-prefix()
  "`document' properties "
  (if (re-search-backward "\\w+\\.\\(.*\\)" nil t)
      (match-beginning 1)))

(defun ac-javascript-dict-dir(filename)
  (concat (ac-javascript-current-directory) "dict/" filename))

;;; document properties
(defface ac-javascript-document-properties-face
  '((t (:background "#797979" :foreground "#eeeeee")))
  "Face for document properties"
  :group 'auto-complete)

(defvar ac-javascript-document-properties-cache
  (ac-file-dictionary (ac-javascript-dict-dir "document-properties")))

(defvar ac-source-javascript-document-properties
  '((candidates . ac-javascript-document-properties-cache)
    (candidate-face . ac-javascript-document-properties-face)
    (prefix . ac-javascript-common-prefix)
    (symbol . "document property")))

;;; document methods
(defface ac-javascript-document-methods-face
  '((t (:background "#5f5f5f" :foreground "#eeeeee")))
  "Face for document properties"
  :group 'auto-complete)

(defvar ac-javascript-document-methods-cache
  (ac-file-dictionary (ac-javascript-dict-dir "document-methods")))

(defvar ac-source-javascript-document-methods
  '((candidates . ac-javascript-document-methods-cache)
    (candidate-face . ac-javascript-document-methods-face)
    (prefix . ac-javascript-common-prefix)
    (action . ac-javascript-go-into-braces-action)
    (symbol . "document methods")))

;;; Node properties
(defface ac-javascript-node-properties-face
  '((t (:background "#797979" :foreground "#eeeeee")))
  "Face for Node properties"
  :group 'auto-complete)

(defvar ac-javascript-node-properties-cache
  (ac-file-dictionary (ac-javascript-dict-dir "node-properties")))

(defvar ac-source-javascript-node-properties
  '((candidates . ac-javascript-node-properties-cache)
    (candidate-face . ac-javascript-node-properties-face)
    (prefix . ac-javascript-common-prefix)
    (symbol . "Node methods")))

;;; Node methods
(defface ac-javascript-node-methods-face
  '((t (:background "#5f5f5f" :foreground "#eeeeee")))
  "Face for Node methods"
  :group 'auto-complete)

(defvar ac-javascript-node-methods-cache
  (ac-file-dictionary (ac-javascript-dict-dir "node-methods")))

(defvar ac-source-javascript-node-methods
  '((candidates . ac-javascript-node-methods-cache)
    (candidate-face . ac-javascript-node-methods-face)
    (prefix . ac-javascript-common-prefix)
    (action . ac-javascript-go-into-braces-action)
    (symbol . "Node methods")))


(defun ac-javascript-mode-setup()
  (setq ac-sources
	'(
	  ac-source-javascript-document-properties
	  ac-source-javascript-document-methods
	  ac-source-javascript-node-properties
	  ac-source-javascript-node-methods
	  )
	))

(add-hook 'js3-mode-hook 'ac-javascript-mode-setup)
