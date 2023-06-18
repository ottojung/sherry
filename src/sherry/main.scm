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
  :use-module ((euphrates raisu) :select (raisu))
  :use-module ((sherry infer-file-license) :select (infer-file-license))
  )

(define (main)
  (with-cli
   (MAIN
    MAIN : --help
    /      infer file license DASH? <filepath>
    DASH : --
    )

   (when --help
     (define-cli:show-help)
     (exit 0))

   (cond
    ((and infer file license)
     (infer-file-license <filepath>))
    (else
     (raisu 'unrecognized-cli-args
            "What are these CLI options?!")))))

(main)
