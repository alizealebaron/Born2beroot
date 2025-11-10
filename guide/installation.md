# Installation

Avant de commencer l'installation de votre première machine virtuelle, je vous invite fortement à vous renseigner sur ce qu'est une machine virtuelle. 
Vous trouverez dans ce guide la façon dont j'ai procédé pour créer ma propre machine et les erreurs que j'ai pu commettre ou rencontrer. J'espère que cela vous sera utile.

## Récupération de debian

La première étape pour créer votre machine virutelle sera de trouver le bon debian pour l'installer.

> [!NOTE]  
> Pour trouver la bonne configuration à télécharger, il faudra voir avec ce dont vous disposer comme ordinateur. Certaines versions ne fonctionnent pas sur tous les ordinateurs.

<p align="center">
  <img width="600" height="300" src="/image/installation_00.jpg">
</p>
<p align="center">
  <sub><sup>Erreur obtenue lors d'un mauvais choix d'image ISO</sup></sub>
</p>

Vous pouvez récupérer la dernière version stable de debian en allant sur leur [site internet](https://www.debian.org/index.fr.html). (Ne faites pas comme moi à aller chercher l'image dans des recoins de debian.org alors que la réponse est simple).

## Création de la Machine Virtuelle
Une fois l'image récupérée, vous n'avez qu'à lancer VirtualBox.

1. Pour commencer l'installation cliquez sur la bouton `new`.
2. Sélectionnez l'image iso téléchargée dans le champ `iso image`. Pour le nom de la VM, je vous laisse trouver le votre.

<p align="center">
  <img width="600" height="300" src="/image/installation_01.png">
</p>

3. Choississez la mémoire que vous souhaitez lui allouer (1024 MB devrait suffire).
4. Créez un disque dur virtuel (Vous pouvez allouer entre 10GB et 15GB, cela devrait être large pour le sujet et les bonus).
5. Vous venez de créer votre première machine virtuelle, reste encore à la paramétrer !

## Installation de Debian

L'installation commençera par vous demander la façon dont vous souhaitez l'installer. Étant donné que nous souhaitons installer un serveur, un interface graphique n'est pas nécessaire.

1. Choississez le langage d'installation.
> [!TIP]  
> Par défaut, je dirais d'utiliser l'anglais, notamment car beaucoup de ressources que vous trouverez pendant vos recherches seront en anglais. Mais rien ne vous empêche de choisir une autre langue !
2. Choississez le pays et la disposition de clavier qui vous conviennent.
3. Pour ce qui est de l'hostname il vous faudra mettre `login42` (conformément à ce qui est demandé).
<p align="center">
  <img width="600" height="400" src="/image/installation_03.png">
</p>
4. Pour le nom de domaine, inutile d'en ajouter un, vous pouvez passer cette étape.
5. Choississez un mot de passe fort (selon les critères donnés dans le sujet).
6. Pour le nom d'utilisateur, mettez votre login. (Pour moi : `alebaron`).
7. Choississez de nouveau un mot de passe, il ne doit pas contenir votre login !

## Partionner les disques

> [!TIP]  
> Cette partie-là est demandée pour les bonus. Si vous hésitez encore à les faire je recommande tout de même de la réaliser. Sinon, si vous changez d'avis en cours de route, vous risquez de devoir tout refaire pour avoir les bonnes partitions. 

Puisque nous cherchons à avoir un partionnage de disque précis (en tout cas concernant les bonus), nous allons opter pour une installation **manuelle**.

> [!NOTE]  
> Partionner un disque dur consiste à diviser celui-ci en différentes parties distinctes (partitions). L'espace de stockage disponible est alors divisé entre les différentes partitions. Les informations sur les partitions sont stockées dans la table des partitions.

1. Sélectionnez le disque dur `SCSI (0,0,0) (sda) ...` (Il s'agit de notre seul disque dur dont la taille a été définie un peu plus tôt).

> [!NOTE]  
> L'objectif suivant est de pouvoir créer deux partitions, dont une [cryptée](https://fr.wikipedia.org/wiki/Chiffrement_de_disque). La première partition nous servira pour démarrer notre machine, elle ne sera donc pas cryptée. La deuxième comportera divers autres éléments et se devra d'être cryptée quand à elle.

2. Pour créer la première partition cliquez sur : `pri/log xxGB FREE SPACE` → `Create a new partition` → `500 MB` → `Primary` → `Beginning` → `Mount point` → `/boot` → `Done`.

<p align="center">
  <img width="600" height="400" src="/image/installation_04.png">
</p>

3. Pour la deuxième partition, cliquez sur : `pri/log xxGB FREE SPACE` → `Create a new partition` → `max` → `Logical` → `Mount point` → `Do not mount it` → `Done`.

<p align="center">
  <img width="600" height="400" src="/image/installation_05.png">
</p>

## Crypter les données d'une partition

Dans cette partie nous allons nous occuper d'encrypter uniquement la partition qui nous intéresse (la deuxième).

1. `Configure encrypted volumes` → `Yes`
2. `Create encrypted volumes`
3. Sélectionner **uniquement** la partition `sda5`

> [!WARNING]  
> Si par hasard vous veniez à encrypter la première partition, votre machine ne sera plus en mesure de pouvoir [boot (démarrer)](https://fr.wikipedia.org/wiki/D%C3%A9marrage_d%27un_ordinateur). Et je pense que le mieux serait de refaire toute la manipulation depuis le début.

4. Terminez la manipulation en cliquant sur `Done` → `Finish` → `Yes`
5. Après un (long) temps d'attente, choississez un mot de passe (selon les critères du sujet) et notez celui-ci quelque part.

## Configurer le gestionnaire de volumes logiques

> [!NOTE]  
> Si vous ne savez pas ce qu'est un LVM (Logical Volume Manager), je vous invite à consulter le site suivant : [doc.ubuntu.org](https://doc.ubuntu-fr.org/lvm).

1. `Configure the Logical Volume Manager` → `Yes`
2. `Create a Volume Group` → `LVMGroup` (Voir sujet) → `/dev/mapper/sda5_crypt`

<p align="center">
  <img width="600" height="400" src="/image/installation_06.png">
</p>

Créer tous les volumes dont vous avez besoin :

`Create Logical Volume` → `LVMGroup` → `{nom}` → `{Taille}`

(Adaptez la taille des volumes selon vos besoins).

<p align="center">
  <img width="600" height="400" src="/image/installation_07.png">
</p>

Vous pouvez revérifier les informations dans le menu `LVM configuration` en caas d'erreur, vous pouvez toujours les supprimer et réitéré le processus.

Vous n'aurez qu'à définir les systèmes de fichiers et les points de montage pour chacun des volumes logique.

Par exemple pour **HOME** : `Sélectionner la ligne en dessous` → `Use as` → `Ext 4 journaling file system` → `Mount Point` → `/home` → `Done`.

Pour **Swap**, la procédure sera légèrement différente : `Sélectionner la ligne en dessous` → `Use as` → `swap area` → `Done`.

Et pour **var-log** : `Sélectionner la ligne en dessous` → `Use as` → `Ext 4 journaling file system` → `Mount Point` → `Enter manually` → `/var/log` → `Done`.

<p align="center">
  <img width="600" height="400" src="/image/installation_08.png">
</p>

Plus qu'à relire, finir et confirmer !

## Finaliser l'installation

1. Vous pouvez refuser le scan.
2. Choississez le `pays` et le `miroir`.
3. Laissez vide le champ de `proxy`.
4. Cliquez sur `non`.
5. Décochez toutes les cases.
6. Installez grub dans le dossier `/dev/sda`.
7. Appuyez sur continuer et, félicitations, vous avez terminé l'installation de votre système debian !

## Sources :

- [debian.org](https://www.debian.org/releases/stable/armhf/apcs04.fr.html) [Consulté le 06/11/2025]
- [Github de yatsuZ](https://github.com/yatsuZ/B2BR/blob/main/Guide/Installation.md) [Consulté le 06/11/2025]
- [Github de mcombeau](https://github.com/mcombeau/Born2beroot/blob/main/guide/installation_debian.md) [Consulté le 06/11/2025]
- [Data-labcenter](https://www.data-labcenter.fr/) [Consulté le 06/11/2025]
- [doc.ubuntu.org/lvm](https://doc.ubuntu-fr.org/lvm) [Consulté le 06/11/2025]
- [Wikipedia.org/ext4](https://fr.wikipedia.org/wiki/Ext4) [Consulté le 06/11/2025]