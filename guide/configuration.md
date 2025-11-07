# Configuration du système

Afin d'installer de nouveau paquet sur votre système, il est important de vérifier que celui-ci est toujours à jour avant tout installation. C'est à cela que vont servir les commandes :

```
apt update
apt upgrade
```

Ces commandes seront toujours à utiliser avant n'importe quel installation, il s'agit d'une précaution importante pour que tout fonctionne. (De plus elle ne prenne pas beaucoup de temps s'il n'y a rien à mettre à jour).

## Installation de sudo

Pour répondre aux attentes du sujet, il va nous falloir installer plusieurs outils sur notre machine. C'est le cas de sudo, une commande qui peut être utilisée afin de lancer une commande en tant que [super utilisateur](https://fr.wikipedia.org/wiki/Utilisateur_root). 

Aussi, nous allons pouvoir utiliser les sacro saintes commandes : 
```
apt update
apt upgrade
```
Que nous allons pouvoir compléter par la commande pour installer sudo :
```
apt install sudo
```

Ensuite, il faut ajouter notre utilisateur au groupe sudo, cela lui permettra d'utiliser les commandes en tant que super utilisateur. Pour cela on utilise la commande suivante (-aG pour add Group) :
```
sudo usermod -aG sudo <login>
```

Pour vérifier que l'utilisateur appartient au bon groupe, vous pouvez faire la commande suivante : 
```
groups <login>
```

<p align="center">
  <img width="600" height="400" src="/image/configuration_00.png">
</p>




## Sources

- [Github de yatsuZ](https://github.com/yatsuZ/B2BR/blob/main/Guide/Configuration.md) [Consulté le 06/11/2025]
- [Github de mcombeau](https://github.com/mcombeau/Born2beroot/blob/main/guide/configuration_debian.md) [Consulté le 06/11/2025]
- [Wikipedia.org/sudo](https://fr.wikipedia.org/wiki/Sudo) [Consulté le 07/11/2025]