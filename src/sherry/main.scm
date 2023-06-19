;;;; Copyright (C) 2023  Otto Jung
;;;;
;;;; This program is free software: you can redistribute it and/or modify
;;;; it under the terms of the GNU General Public License as published by
;;;; the Free Software Foundation; version 3 of the License.
;;;;
;;;; This program is distributed in the hope that it will be useful,
;;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;; GNU General Public License for more details.
;;;;
;;;; You should have received a copy of the GNU General Public License
;;;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-module (sherry main)
  :use-module ((euphrates define-cli) :select (define-cli:show-help with-cli))
  :use-module ((euphrates file-or-directory-exists-q) :select (file-or-directory-exists?))
  :use-module ((euphrates properties) :select (with-properties))
  :use-module ((euphrates raisu) :select (raisu))
  :use-module ((sherry get-file-modification-years) :select (get-file-modification-years/print))
  :use-module ((sherry infer-file-license) :select (infer-file-license/print))
  :use-module ((sherry update-file-license) :select (update-file-license/overwrite))
  )


(define (main)
  (with-cli
   (MAIN
    MAIN : --help
    /      infer-license DASH? <filepath>
    /      update-license UPDATEOPT* DASH? <filepath>
    /      get-modification-years DASH? <filepath>
    DASH : --
    UPDATEOPT : --if-exists
    /           --all-years
    /           --just-current-year
    )

   :default (--just-current-year #t)
   :exclusive (--just-current-year --all-years)

   (when --help
     (define-cli:show-help)
     (exit 0))

   (when <filepath>
     (unless (file-or-directory-exists? <filepath>)
       (raisu 'target-file-does-not-exist)))

   (with-properties
    :for-everything
    (cond
     (infer-license
      (infer-file-license/print <filepath>))
     (update-license
      (update-file-license/overwrite --if-exists --all-years <filepath>))
     (get-modification-years
      (get-file-modification-years/print <filepath>))
     (else
      (raisu 'unrecognized-cli-args
             "What are these CLI options?!"))))))


(main)
