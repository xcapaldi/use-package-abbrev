;;; use-package-abbrev.el --- abbrev keyword for use-package  -*- lexical-binding: t; -*-

;; Copyright (C) 2022 Xavier Capaldi

;; Author: Xavier Capaldi <xcapaldi@scribo.biz>
;; Keywords: convenience, tools, extensions
;; URL: https://github.com/xcapaldi/use-package-abbrev
;; Version: 0.1
;; Package-Requires ((use-package "2.1"))
;; Filename: use-package-abbrev.el
;; License: GNU General Public License version 3, or (at your option) any later version
;;

;;; Commentary:
;;
;; The `:abbrev' keyword allows you to pass the path to an abbrev
;; file containing abbrev definitions in a similar manner as the
;; `:load-path` keyword.
;;

;;; Code:

(require 'use-package)
(require 'abbrev)

;;;###autoload
(defun use-package-normalize/:abbrev (_name keyword args)
  (use-package-as-one (symbol-name keyword) args
    #'use-package-normalize-paths))

;;;###autoload
(defun use-package-handler/:abbrev (name _keyword arg rest state)
  (let ((body (use-package-process-keywords name rest state)))
    (use-package-concat
     (mapcar #'(lambda (path)
                 `(eval-and-compile (read-abbrev-file ,path t)))
             arg)
     body)))

(add-to-list 'use-package-keywords :abbrev t)

(provide 'use-package-abbrev)

;;; use-package-abbrev.el ends here
