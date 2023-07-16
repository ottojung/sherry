;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(current-program-path/p "sherry")

(with-cli
 (OPT* COMMAND
       COMMAND : --help
       /      infer license DASH? <filepath>
       /      update license UPDATEOPT* DASH? <filepath>
       /      minify license MINIFYOPT* DASH? <filepath>
       /      get modification years DASH? <filepath>
       /      get dependencies DASH? <filepath>
       /      get exports DASH? <filepath>
       /      get source type DASH? <filepath>
       /      create file DASH? <export-name>
       /      install program INSTALLOPT*
       /      --version
       DASH : --
       MINIFYOPT : --print
       UPDATEOPT : --if-exists
       /           --all-years
       /           --just-current-year
       INSTALLOPT : --main <filepath-of-main...> --binary-name <binary-name...>
       /            --project-name <project-name>
       /            --src <dirpath-of-src>
       /            --prefix-share <prefix-share>
       /            --prefix-bin <prefix-bin>
       OPT  : --quiet
       )

 :synonym (--version -v version)

 :default (--just-current-year #t)
 :exclusive (--just-current-year --all-years)

 :help (create-file (stringf "Create a new file that exports ~s." (quote <export-name>)))
 :help (--quiet "Only print fatal errors.")

 (when --help
   (define-cli:show-help)
   (exit 0))

 (when --version
   (display "0.1") (newline)
   (exit 0))

 (when <filepath>
   (unless (file-or-directory-exists? <filepath>)
     (raisu 'target-file-does-not-exist)))

 (log-level/p (if --quiet 'quiet 'normal))

 (with-properties
  :for-everything
  (cond
   ((and infer license)
    (infer-file-license/print <filepath>))
   ((and update license)
    (update-file-license/overwrite --if-exists --all-years <filepath>))
   ((and minify license)
    (minify-license/overwrite --print <filepath>))
   ((and get modification years)
    (get-file-modification-years/print <filepath>))
   ((and get dependencies)
    (get-file-dependencies/print <filepath>))
   ((and get exports)
    (get-file-exports/print <filepath>))
   ((and get source type)
    (get-file-source-type/print <filepath>))
   ((and create file)
    (create-file-by-name/print <export-name>))
   ((and install program)
    (install-guile-program
     (map cons (or <binary-name...> '()) (or <filepath-of-main...> '()))
     <project-name>
     <dirpath-of-src>
     <prefix-share>
     <prefix-bin>))
   (else
    (raisu 'unrecognized-cli-args
           "What are these CLI options?!")))))
