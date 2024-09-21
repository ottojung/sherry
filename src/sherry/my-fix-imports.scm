;;;; Copyright (C) 2023, 2024  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (my-fix-imports:main <root> <files...>* initialize-stdlib-exports --import-everything <filepath>)
  (when initialize-stdlib-exports
    (do-initialize-stdlib-exports <root> (or <files...>* '()))
    (exit 0))

  (fix-imports/generic --import-everything <filepath>))

(parameterize ((current-program-path/p "my-fix-imports"))
  (with-cli
   (MAIN
    MAIN : --help
    /      initialize-stdlib-exports <root> <files...>*
    /      OPT* DELIM? <filepath>
    OPT  : --import-everything
    DELIM : --
    )

   (when --help
     (define-cli:show-help)
     (exit 0))

   (my-fix-imports:main
    initialize-stdlib-exports
    <root> <files...>*
    --import-everything
    <filepath>)))
