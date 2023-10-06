# incrementer_date
Fonctions elisp permettant d'incrémenter la date écrite en français au point dans un buffet emacs.  



## Exemple:


Soit le texte suivant dans un buffer markdown:
```
!!! done "séance 1 (4h jeudi 7/09/23):"
    - TP d'introduction à la POO
    ??? note "Devoirs"
        - Finir le TP et le déposer sur Capytale
```

Pour changer la date:
- Se placer sur 7/09/23. 
- `M-up` (soit option flèche du haut) permet de changer la date en vendredi 8/9/2023

Remarque: Si l'année est au format aa elle est convertie au format aaaa.  
