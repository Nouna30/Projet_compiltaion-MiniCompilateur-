# Projet_compiltaion-MiniCompilateur- (avec Flex et Bison)

## Introduction
Ce projet consiste à réaliser un compilateur simple en utilisant **Flex** et **Bison**.
Flex s'occupe de l'analyse lexicale tandis que Bison gère l'analyse syntaxique.

---

## Qu’est-ce que Flex ?
Flex (Fast Lexical Analyzer Generator) est un outil qui permet de générer un analyseur lexical à partir d’un fichier `.l`.
Il sert à reconnaître les mots-clés, identificateurs, nombres et symboles d’un programme.

➡️ Flex découpe le texte d’entrée en unités appelées *tokens*.

---

## Qu’est-ce que Bison ?
Bison est un générateur d’analyseur syntaxique.
À partir d’un fichier `.y` décrivant une grammaire, il vérifie que la suite de tokens produite par Flex respecte les règles syntaxiques.

➡️ Bison vérifie la structure correcte du programme.

---

## Installation de Flex et Bison

### Liens d’installation
Assurez-vous que **Flex**, **Bison** et **GCC** sont bien ajoutés au PATH.

---

## Compilation du projet

Utilisez les commandes suivantes :

```sh
flex Compil.l
bison -d compil.y
gcc lex.yy.c compil.tab.c -o Compil -lfl -ly
```

### Explication
- `flex Compil.l` : génère le fichier `lex.yy.c`
- `bison -d compil.y` : génère `compil.tab.c` et `compil.tab.h`
- `gcc ...` : compile et crée l’exécutable `Compil`

---

## Exécution

```sh
./Compil
```

Ou avec un fichier d’entrée :

```sh
./Compil < test.txt
```

---

## Fichiers du projet a la fin 

```
Compil.l
compil.y
lex.yy.c
compil.tab.c
compil.tab.h
Compil
```

---

## Remarques
- Respecter les noms de fichiers (majuscules / minuscules)
- Vérifier l’installation correcte des outils
