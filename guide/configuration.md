# Configuration du système

Afin d'installer de nouveau paquet sur votre système, il est important de vérifier que celui-ci est toujours à jour avant tout installation. C'est à cela que vont servir les commandes :

```bash
apt update
apt upgrade
```

Ces commandes seront toujours à utiliser avant n'importe quel installation, il s'agit d'une précaution importante pour que tout fonctionne. (De plus elle ne prenne pas beaucoup de temps s'il n'y a rien à mettre à jour).

## Installation de sudo

Pour répondre aux attentes du sujet, il va nous falloir installer plusieurs outils sur notre machine. C'est le cas de sudo, une commande qui peut être utilisée afin de lancer une commande en tant que [super utilisateur](https://fr.wikipedia.org/wiki/Utilisateur_root). 

Aussi, nous allons pouvoir utiliser les sacro saintes commandes : 
```bash
apt update
apt upgrade
```
Que nous allons pouvoir compléter par la commande pour installer sudo :
```bash
apt install sudo
```

Ensuite, il faut ajouter notre utilisateur au groupe sudo, cela lui permettra d'utiliser les commandes en tant que super utilisateur. Pour cela on utilise la commande suivante (-aG pour add Group) :
```bash
sudo usermod -aG sudo <login>
```

Pour vérifier que l'utilisateur appartient au bon groupe, vous pouvez faire la commande suivante : 
```bash
groups <login>
```

<p align="center">
  <img width="600" height="400" src="/image/configuration_00.png">
</p>

Pour modifier le fichier de configuration qui se trouve dans le dossier `/etc/sudoers` nous pouvons directement utiliser la commande suivante :

```bash
sudo visudo
```
(Ou vous pouvez tout aussi bien vous déplacer dans le dossier et faire un `sudo nano sudoers`).

Pour les modifications, voici celles que j'ai ajoutées dans mon fichier :
```bash
Defaults	passwd_tries=3 # Nombres d'essais pour le mot de passe.
Defaults	badpass_message="Mauvais mot de passe." # Phrase d'erreur de mot de passe
Defaults	log_input	# Récupéré les logs des commandes données avec sudo
Defaults	logfile="/var/log/sudo/sudo.log" # Chemin du fichier de log
Defaults	log_output # Récupéré les réponses des commandes exécutées avec sudo
Defaults	iolog_dir="/var/log/sudo" # L'endroit où seront stockés les logs d'output
Defaults	requiretty # Active le mode tty comme demandé
```

Pour vérifier que les logs fonctionnent vous pouvez vous rendre dans le dossier `/var/log/sudo/`. Vous trouverez le fichier `sudo.log` qui répertorie toutes les commandes mais aussi un fichier `00/00` dans lequel se trouvera un dossier par commande faites avec sudo. Ce sont les texts d'output que l'on a demandé.

Nous devrions en avoir fini avec la configuration de sudo.

## Configurer UFW sur notre système

Avant de commencer à installer UFW sur notre machine, petit point sur ce que paquet permet de faire. Déjà, UFW signifie **Uncomplicated Firewall** ou comme j'aime l'appellé maintenant "Pare-feu pas compliqué". Ainsi, UFW est un paquet qui va nous permettre de configurer un [pare-feu](https://fr.wikipedia.org/wiki/Pare-feu_(informatique)) local pour gérer les flux entrants et sortants.

Commençons par les commandes de bases :
```
apt update
apt upgrade
apt install ufw
```

Ensuite, il va nous falloir activer le service à l'aide de la commande :
```
sudo ufw enable
```

Vous pouvez ensuite vérifier le fonctionnement du service ufw avec la commande `sudo systemctl status ufw`.
<p align="center">
  <img width="800" height="400" src="/image/configuration_01.png">
</p>



## Sources

- [Github de yatsuZ](https://github.com/yatsuZ/B2BR/blob/main/Guide/Configuration.md) [Consulté le 06/11/2025]
- [Github de mcombeau](https://github.com/mcombeau/Born2beroot/blob/main/guide/configuration_debian.md) [Consulté le 06/11/2025]
- [Wikipedia.org/sudo](https://fr.wikipedia.org/wiki/Sudo) [Consulté le 07/11/2025]
- [it-connect.fr/sudoers](https://www.it-connect.fr/commande-sudo-comment-configurer-sudoers-sous-linux/#B_Editer_la_configuration_de_sudoers_avec_visudo) [Consulté le 07/11/2025]
- [malekal.com](https://www.malekal.com/quest-ce-que-tty-comment-utiliser-commande-tty-sur-linux/) [Consulté le 07/11/2025]
- [tverma.hashnode.dev](https://tverma.hashnode.dev/custom-sudo-logs-file-linux) [Consulté le 07/11/2025]
- [it-connect.fr/UFW](https://www.it-connect.fr/configurer-un-pare-feu-local-sous-debian-11-avec-ufw/) [Consulté le 07/11/2025]
