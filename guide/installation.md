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

## Création de la VirtualBox
Une fois l'image récupérée, vous n'avez qu'à lancer VirtualBox.

1. Pour commencer l'installation cliquez sur la bouton `new`.
2. Sélectionnez l'image iso téléchargée dans le champ `iso image`. Pour le nom de la VM, je vous laisse trouver le votre.

<p align="center">
  <img width="600" height="300" src="/image/installation_01.png">
</p>

3. Choississez la mémoire que vous souhaitez lui allouer (1024 MB devrait suffire).
4. Créez un disque dur virtuel (Vous pouvez allouer entre 10GB et 15GB, cela devrait être large pour le sujet et les bonus).
5. Vous venez de créer votre première machine virtuelle, reste encore à la paramétrer !



