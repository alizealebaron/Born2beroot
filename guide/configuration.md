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
```bash
sudo apt update
sudo apt upgrade
sudo apt install ufw
```

Ensuite, il va nous falloir activer le service à l'aide de la commande :
```bash
sudo ufw enable
```

Vous pouvez ensuite vérifier le fonctionnement du service ufw avec la commande `sudo systemctl status ufw`.

<p align="center">
  <img width="800" height="400" src="/image/configuration_01.png">
</p>

Pour activer un [port](https://fr.wikipedia.org/wiki/Port_(logiciel)) vous n'aurez plus qu'à utiliser la commande suivante :
```bash
sudo ufw allow <n°port>
```

Et pour le désactiver ensuite, vous pouvez toujours utiliser la commande `sudo ufw deny <n°port>`.

Pour vérifier que vous avez activer les ports nécessaire, vous pouvez utiliser la commande :
```bash
sudo ufw status
```

Pour ma part, cela me renvoit ce résultat à la fin de cette étape :

<p align="center">
  <img width="800" height="400" src="/image/configuration_02.png">
</p>

## Configuration du service SSH

Comme toujours, avant de commencer à installer, un petit point sur ce qu'est le protocole SSH. Le protocole SSH (Secure SHell) une méthode pour envoyer des commandes à un ordinateur en toute sécurité. Ce protocole est aussi souvent utiliser pour contrôler des serveurs à distances , permettant de gérer les infrastrucutures et de transféré plus facilement des fichiers.
Si vous voulez en savoir un peu plus, je vous invite à consulter ce [lien](https://www.cloudflare.com/fr-fr/learning/access-management/what-is-ssh/) d'où je tire ma définition.

Commençons par le commencement, l'installation (vous devriez commencer à savoir).
```bash
sudo apt update
sudo apt upgrade
sudo apt install openssh-server
```

Comme pour ufw, on peut verifier le status de SSH avec la commande `sudo systemctl status ssh`.

<p align="center">
  <img width="800" height="400" src="/image/configuration_03.png">
</p>

Ensuite, nous allons voir pour changer le port d'écoute du protocole SSH. Par défaut, le port ssh est en écoute sur le port 22. Nous allons pouvoir changer cela en modifiant le fichier de configuration dans `/etc/ssh/sshd_config`.

```bash
sudo nano /etc/ssh/sshd_config
```

Il ne vous reste plus qu'à trouver la ligne commentée `#Port 22` et la replacer par `Port 4242`.

> [!WARNING]  
> N'oubliez pas de redémarrer le service ssh avec la commande `sudo systemctl restart ssh` ou les changements ne seront pas actualisés.

Une fois SSH redémarré, vous pouvez utiliser la commande `sudo systemctl status ssh` pour vérifier que le port d'écoute à bien changé.

<p align="center">
  <img width="800" height="400" src="/image/configuration_04.png">
</p>

Maintenant que nous avons paramétrer notre machine virtuelle pour le ssh, il faut paramétrer VirtualBox afin que nous puissions y avoir accès depuis le terminal de notre ordinateur. 

Dans VirtualBox cliquez sur `Settings` → `Network` → `Adapter 1` → `Advanced` → `Port Forwarding`

<p align="center">
  <img width="800" height="400" src="/image/configuration_05.gif">
</p>

> [!NOTE]  
> Le port 4242 est parfois déjà utilisé (surtout à 42). Pour éviter les erreurs ssh et pour pouvoir rendre un projet fonctionnel, j'ai personnellement fait le choix d'utiliser le port 4243 pour l'host.

Vous n'avez plus qu'à ajouter une nouvelle règle pour le port 4242 (ou 4243 dans mon cas) Host et 4242 guest !

<p align="center">
  <img width="800" height="400" src="/image/configuration_06.gif">
</p>

> [!WARNING]  
> Pensez à bien redémarrer le service ssh après la modification avec la commande `sudo systemctl restart ssh`.

Une fois les modifications effectuées, vous n'aurez plus qu'à tenter de vous connecter à la machine virtuelle depuis le terminal de votre ordinateur avec la commande suivante :

```bash
ssh <login>@localhost -p 4243
```

Si vous arrivez à vous connecter, bien joué ! Vous pouvez vous connecter en utilisant `exit`. Sinon, en cas d'erreurs, revérifiez peut-être les configurations `ufw`, `ssh` ou les `paramètres de VirtualBox`.

## Changer la politique de mot de passe

Maintenant, nous allons modifier la façon dont sont gérer les mots de passe. Certains paramètres peuvent dores et déjà être gérer avec debian mais nous aurons besoin d'installer un autre paquet pour correspondre à toutes les exigeances du sujet.

Commençons par les modifications qu'il est possible de faire dores et déjà.

```bash
sudo nano /etc/login.defs # Ouvre le fichier de controle de mot de passe
```

Trouvez et modifiez les lignes suivantes afin qu'elles correspondent au sujet. Dans mon cas :

<p align="center">
  <img width="800" height="400" src="/image/configuration_07.png">
</p>

La politique de mot de passe a changé pour tout nouvel utilisateur, mais elle n'est pas encore appliquée pour root et pour votre login (qui sont des comptes antérieurs à la modification).

Pour changer cela, on peut utiliser la commande `chage`, si vous ne savez pas comment elle fonctionne, je vous invite à lire ce [guide](https://www.it-connect.fr/linux-forcer-le-changement-de-mot-de-passe-des-comptes/).

```bash
sudo chage -M 30 <login/root>
sudo chage -m  2 <login/root>
sudo chage -W  7 <login/root>
```

<p align="center">
  <img width="800" height="400" src="/image/configuration_08.png">
</p>

Maintenant, nous allons pouvoir installer le paquet qui vérifiera que les utilisateurs ont bien un mot de passe conforme à ce qui est demandé dans le sujet.

```bash
sudo apt update
sudo apt upgrade
sudo apt install libpam-pwquality
```

Et pour pouvoir configurer le tout, on va modifier le dossier suivant : `/etc/security/pwquality.conf`.

Pour ma part, voici à quoi ressemble les changements que j'ai fait :
```bash
difok = 7
minlen = 10
dcredit = -1
ucredit = -1
lcredit = -1
...
maxrepeat = 3
...
usercheck = 1
...
enforce_for_root
```

Les commentaires dans le fichiers sont assez parlant pour pouvoir trouver les modifications à faire par soi-même.

Plus qu'à changer les mots de passe de nos deux utilisateurs `root` et `login`.

```bash
sudo passwd <login/root>
```

## Script & Monitoring

Pour le script monitoring, je me suis principalement aidée des commandes suivantes. Pour chacune d'entre elle, vous pouvez apprendre leur fonctionnement en faisant `commande --help`. 

- `uname` : Permet d'avoir les informations de notre architecture
- `free` : Information sur la mémoire (RAM)
- `df` : Affiche les informations du disque dur
- `who` : Permet d'afficher les informations sur les utilisateurs
- `hostname` : Permet de récupérer l'adresse IP (et l'hostname aussi)
- `ip addr` : Affiche l'adresse MAC (ainsi que d'autres informations)

Je me suis aussi aidée des commandes suivantes pour formater les retours des fonctions selon ce dont j'avais besoin :

- `grep`
- `tr`
- `cut`
- `cat`🐈

Je vous laisse vous renseigner sur leur fonctionnement ou regarder dans les [commandes utiles](/Born2beroot/guide/commandes_utiles.md).

Vous trouverez mon fichier monitoring.sh [ici](/Born2beroot/code/monitoring.sh).

Étant donné que j'ai dans un premier temps fait mon script .sh sur mon ordinateur avant de le passer sur la VM, voici la commande que j'ai utilisé pour le transférer.




## Sources

- [Github de yatsuZ](https://github.com/yatsuZ/B2BR/blob/main/Guide/Configuration.md) [Consulté le 06/11/2025]
- [Github de mcombeau](https://github.com/mcombeau/Born2beroot/blob/main/guide/configuration_debian.md) [Consulté le 06/11/2025]
- [Wikipedia.org/sudo](https://fr.wikipedia.org/wiki/Sudo) [Consulté le 07/11/2025]
- [it-connect.fr/sudoers](https://www.it-connect.fr/commande-sudo-comment-configurer-sudoers-sous-linux/#B_Editer_la_configuration_de_sudoers_avec_visudo) [Consulté le 07/11/2025]
- [malekal.com](https://www.malekal.com/quest-ce-que-tty-comment-utiliser-commande-tty-sur-linux/) [Consulté le 07/11/2025]
- [tverma.hashnode.dev](https://tverma.hashnode.dev/custom-sudo-logs-file-linux) [Consulté le 07/11/2025]
- [it-connect.fr/UFW](https://www.it-connect.fr/configurer-un-pare-feu-local-sous-debian-11-avec-ufw/) [Consulté le 07/11/2025]
- [cloudflare.com/what-is-ssh](https://www.cloudflare.com/fr-fr/learning/access-management/what-is-ssh/) [Consulté le 07/11/2025]
- [it-connect.fr/ssh](https://www.it-connect.fr/chapitres/installation-dun-serveur-ssh-et-premiere-connexion/) [Consulté le 07/11/2025]
- [hostinger.com/secure-password-policy](https://www.hostinger.com/tutorials/how-to-change-password-in-linux?utm_campaign=Generic-Tutorials-DSA-t3|NT:Se|Lang:EN|LO:FR&utm_medium=ppc&gad_source=1&gad_campaignid=22523766166&gbraid=0AAAAADMy-hZGSzJRPF2GG55SIMAhMD4Gi&gclid=CjwKCAiAzrbIBhA3EiwAUBaUdRIJBq1cTqKE1XlZUb8cwYWKIS8cxDoUMDKDb2h5jOkHkd-HfrooqhoCqfsQAvD_BwE#Set_up_a_secure_password_policy) [Consulté le 07/11/2025]
- [it-connect.fr/forcer-changement-mdp](https://www.it-connect.fr/linux-forcer-le-changement-de-mot-de-passe-des-comptes/) [Consulté le 07/11/2025]
- [ionos.fr/cpu-vs-vcpu](https://www.ionos.fr/digitalguide/serveur/know-how/cpu-vs-vcpu/#:~:text=Dans%20la%20comparaison%20CPU%20vs,de%20performances%20et%20d'applications.) [Consulté le 08/11/2025]
- [kinsoft.id/display-vcpu](https://kinsoft.id/blog/general-1/post/how-to-display-the-number-of-processors-vcpu-on-linux-vps-13) [Consulté le 08/11/2025]
- [it-connect.fr/transferer-un-fichier-ssh](https://www.it-connect.fr/chapitres/transfert-de-fichier-via-ssh/) [Consulté le 08/11/2025]
- [hostinger.com/awk](https://www.hostinger.com/tutorials/awk-command?utm_campaign=Generic-Tutorials-DSA-t3|NT:Se|Lang:EN|LO:FR&utm_medium=ppc&gad_source=1&gad_campaignid=22523766166&gbraid=0AAAAADMy-haZlQ9OVAYiF2qgn8zlcVN-R&gclid=CjwKCAiA8bvIBhBJEiwAu5ayrGagT7Arr2sdeuC6XdziG4xFEBTDb2YpC2ObPUnzFCJyIiCczeK9LBoCiMcQAvD_BwE) [Consulté le 08/11/2025]