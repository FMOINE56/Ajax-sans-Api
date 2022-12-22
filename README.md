# Exemple de communication Ajax sans API Rest

## Intro

On reprend les tâches mais sans API.

Tout est minimaliste / basique dans le code, pour voir, comprendre le fonctionnement.

Le code (JS comme PHP) peut être un peu optimisé.

## Lancer l'appli

Pour lancer le serveur :

```bash
php -S 127.0.0.1:8000 server.php
```

Pour lancer le client :

- lancer le fichier `index.html` dans le navigateur
- ou (même chose en ligne de commandes) :  `xdg-open index.html`

## Paramétrage

L'accès à la base de données est en dur dans `server.php`.

Si besoin de modifier les accès à la BDD, regarder dans la fonction `getPDO()` pour mettre le bon utilisateur et le bon mot de passe.

## Fonctionnement

- la liste des tâche est retournée par le serveur sous forme de HTML ;
- la suppression et l'ajout d'une tâche fonctionnent par la méthode `POST` ;
- l'ajout d'une tâche retourne le `LI` de la tâche.

Ici on n'est donc pas du tout dans un fonctionnement type API Rest.

## Questionnement / aller plus loin

C'est clairement des techniques que l'on utilisait dans les années 2005-2010.

**Mais finalement, est-ce vraiement plus simple que de passer par une API Rest ?**

On se rend compte que ça devient vite complexe.

Si vraiment vous voulez faire de l'Ajax sans API Rest, vous pouvez :

- côté serveur : retourner quand même du JSON (c'est finalement plus pratique de retourner du HTML) ;
- côté JS : mettre à jour le DOM à partir du JSON ;
- récupérer les données / listes... avec du `GET` ;
- faire la création, mise à jour, suppression avec du `POST` et un paramètre comme `action` dans la démo.

L'important c'est de :

- bien structurer l'ensemble ;
- documenter le fonctionnement.

