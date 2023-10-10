(defun incrementer_date (jour-jj-mm-aa)
  "Incrémente la date au format 'jour-semaine jj/mm/aaaa' en français."
  (let* ((jours-de-semaine '("lundi" "mardi" "mercredi" "jeudi" "vendredi" "samedi" "dimanche"))
         (date-splitted-space (split-string jour-jj-mm-aa " "))
         (jour-semaine (car date-splitted-space))                                      ; ancien
         (date-splitted (split-string (cadr date-splitted-space) "/"))
         (jour (string-to-number (car date-splitted)))                                 ; ancien
         (mois (string-to-number (cadr date-splitted)))                                ; ancien
         (annee (string-to-number (caddr date-splitted)))                              ; ancien
         ;; Avancer d'un jour dans la semaine
         (index-jour (position (downcase jour-semaine) jours-de-semaine :test 'equal)) ; ancien
         (index-jour (mod (1+ index-jour) 7))                                          ; nouveau
         (jour-semaine (nth index-jour jours-de-semaine)))                             ; nouveau

    ;; Adapter l'année si elle est représentée sur deux chiffres
    (setq annee (if (< annee 100) (+ 2000 annee) annee))                               ; ancienne

    ;; Avancer d'un jour dans la semaine
    (setq jour (1+ jour))
    ;; Si le jour dépasse la fin du mois, réinitialiser à 1 et incrémenter le mois
    (if (> jour (calendar-last-day-of-month mois annee))
        (progn
          (setq jour 1)
          (setq mois (1+ mois))
          ;; Si le mois dépasse décembre, réinitialiser à janvier et incrémenter l'année
          (if (> mois 12)
              (progn
                (setq mois 1)
                (setq annee (1+ annee))))))

    ;; La nouvelle Date est renvoyée par la fonction (renvoie systématique de la dernière évaluation)
    (concat jour-semaine " "  (number-to-string jour) "/" (number-to-string mois) "/" (number-to-string annee))))


(defun incrementer_date_au_point ()
  "Incrémente la date actuelle au point dans le buffer elle est au format jour_semaine jj/mm/[aa]aa et que le point se trouve sur jj/mm/[aa]aa."
  (interactive)
  (save-excursion
    (let ((position (point))
          (debut (re-search-backward   "\\b\\(lundi\\|mardi\\|mercredi\\|jeudi\\|vendredi\\|samedi\\|dimanche\\)"   nil t))
          (fin (re-search-forward "\\(lundi\\|mardi\\|mercredi\\|jeudi\\|vendredi\\|samedi\\|dimanche\\) *[0-9]+/[0-9]+/[0-9]+" nil t)))
      (if (and debut fin (< debut position)(> fin position))
          (progn
            (let ((jour-jj-mm-aa (buffer-substring-no-properties debut fin)))
              (delete-region debut fin)
              (insert (incrementer_date jour-jj-mm-aa))
            ))
        (message "Aucune date au format 'jour_semaine jour/mois/année' trouvée à ce point"))))
  (forward-word))

(global-set-key (kbd "M-<up>") 'incrementer_date_actuelle)
