# Listes des commandes utiles

Vous trouvezrez dans ce fichier une liste des commandes qui me semblaient assez utiles pour être notées à côté. Certaines seront peut-être utile pendant l'évaluation.

## Sommaire

- [Commandes basiques](#commandes-basiques)
- [Hostname](#hostname)
- [Gestion Utilisateur](#gestion-utilisateur)
- [Gestion Groupes](#gestion-groupes)
- [Rappel sur les Regex](#regex)

## Commandes Basiques

- `cat [fichier]` : Permet d'écrire le contenu d'un fichier dans le terminal.
- `nano [fichier]` : Ouvre l'éditeur de texte sur le fichier demandé (même si inexistant)
- `touch [nom_ficher]` : Créer un nouveau fichier
- `mkdir [nom_fichier]` : Créer un nouveau dossier
- `rm [nom_fichier]` : Supprime un fichier
- `grep "chaine cherchée"` : Permet de chercher une chaîne dans une réponse (souvent utilisé avec |)
	- `-o` → Affiche uniquement la partie qui correspond à la chaîne
- `wc` : Affiche le nombre de caractère d'un fichier ou autre
	- `-l` → Affiche le nombre de ligne
	- `-w` → Affiche le nombre de mots
- `tr` : Permet de supprimer les caractère d'une chaîne
	- `-s` → Remplacer les caractères répétés une seule fois

## Hostname

Pour changer l'hostname d'une machine :
- Soit temporairement : `sudo hostname <nom>`
- Soit définitivement : `sudo nano /etc/hostname` suivit d'un redémarrage de la machine.

## Gestion Utilisateur

- `useradd` : Ajout d'un nouvel utilisateur
- `usermod` : Modifier un utilisateur
	- `-l` → nom d'utilisateur
	- `-c` → nom complet
- `userdel` : Supprimer un utilisateur
	- `r` → Supprimer tous les fichiers associés
- `id -u` → Afficher l'ID d'un utilisateur
- `users` → Afficher la liste des utilisateurs connectés.

## Gestion Groupes

- `groupadd` : Créer un nouveau groupe
- `groupdel` : Supprimer un groupe
- `gpasswd -a` : Ajouter un utilisateur à un groupe.
- `gpasswd -d` : Supprimer un utilisateur d'un groupe.
- `cat /etc/groups` : Afficher la liste des groupes.
- `groups` : Affiche la liste des groupes de l'utilisateur connecté.
- `getent group` : Liste des utilisateurs d'un groupe.

## Regex

Les ✨[regex](https://fr.wikipedia.org/wiki/Expression_r%C3%A9guli%C3%A8re)✨ sont un outils magnifique en informatique. Cependant c'est aussi (selon moi) l'un des outils les plus compliqué à maîtriser correctement. Voici les notions que j'ai prise en note :

Pour la commande **grep** :

- `.` – matches any single character.
- `*` – represents zero or more of the preceding character.
- `+` – signifies one or more of the preceding characters.
- `?` – indicates zero or one of the preceding characters.
- `^` – indicates the start of a regex pattern.
- `$` – represents the end of a regex pattern.
- `()`  – groups patterns.
- `\` - Indique qu’un caractère doit être pris littéralement.


## Sources

- [Github de yatsuZ](https://github.com/yatsuZ/B2BR/blob/main/Guide/Configuration.md) [Consulté le 06/11/2025]
- [Github de mcombeau](https://github.com/mcombeau/Born2beroot/blob/main/guide/configuration_debian.md) [Consulté le 06/11/2025]
- [malekal.com/changer-hostname](https://www.malekal.com/comment-changer-le-nom-de-la-machine-hostname-debian-ubuntu/#Comment_changer_le_nom_de_la_machine_hostname_sur_Debian_ou_Ubuntu) [Consulté le 07/11/2025]
- [malekal.com/groups](https://www.malekal.com/lister-groupes-linux/) [Consulté le 07/11/2025]
- [hostinger.com/grep](https://www.hostinger.com/tutorials/grep-command-in-linux?utm_campaign=Generic-Tutorials-DSA-t1|NT:Se|Lang:EN|LO:FR&utm_medium=ppc&gad_source=1&gad_campaignid=20586398874&gbraid=0AAAAADMy-hZE-mOzPtAIpO3gphAs3J4AH&gclid=CjwKCAiA8bvIBhBJEiwAu5ayrKiAH41M6yU8MndGIZ51Ng_nG7cwbcej1epm4sAFpOACPtbYIP0reBoC5JIQAvD_BwE) [Consulté le 08/11/2025]
