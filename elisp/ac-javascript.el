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

(defun ac-javascript-document-prefix()
  "`document' properties "
  (if (re-search-backward "document\\.\\(.*\\)" nil t)
      (match-beginning 1)))

(defun ac-javascript-dict-dir(filename)
  (concat
   (ac-javascript-current-directory)
   "dict/"
   filename))

;;; document.properties
(defvar ac-javascript-document-properties-cache
  (ac-file-dictionary (ac-javascript-dict-dir "document-properties")))

(defvar ac-source-javascript-document-properties
  '((candidates . ac-javascript-document-properties-cache)
    (prefix . ac-javascript-document-prefix)
    (symbol . "document property")))

;;; document.methods
(defvar ac-javascript-document-methods-cache
  (ac-file-dictionary (ac-javascript-dict-dir "document-methods")))

(defvar ac-source-javascript-document-methods
  '((candidates . ac-javascript-document-methods-cache)
    (prefix . ac-javascript-document-prefix)
    (symbol . "document methods")
    (action . ac-javascript-go-into-braces-action)))

(defun ac-javascript-mode-setup()
  (setq ac-sources
	'(
	  ac-source-javascript-document-properties
	  ac-source-javascript-document-methods
	  )
	))

(add-hook 'js3-mode-hook 'ac-javascript-mode-setup)
