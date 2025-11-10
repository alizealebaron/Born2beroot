# Les commandes demandées pour l'évalutation

## Interface graphique

```bash
ls /usr/bin/*session
```

## Check Apparmor

```bash
sudo systemctl status apparmor
```

## Check UFW

```bash
sudo ufw status
```

## Check SSH

```bash
sudo service ssh status
```

## Check version

```bash
uname -a
```

## Check group

```bash
group
```

## Ajouter un utilisateur && Politique de mot de passe

```bash
sudo adduser -m <son_login>
```

## Ajouter un nouveau groupe

```bash
sudo addgroup <nom>
```

## Ajouter à un groupe

```bash
sudo adduser name_user evaluating
```

## Check Hostname

```bash
hostname
```

## Changer l'hostname

```bash
sudo nano /etc/hostname
```
```bash
sudo reboot
```

```bash
hostname
```

## Partitions

```bash
lsblk
```

## Sudo

### Vérifier sudo

```bash
which sudo
```

### Ajouter un sudo

```bash
sudo adduser <login> sudo
```

```bash
getent group sudo
```
### Politique sudo

```bash
nano /etc/sudoers.d/sudo_config
```

### Sudo log

```bash
cd
cd /var/log/sudo
ls
cat sudo.log
```

## Check UFW

```bash
sudo service ufw status
```

```bash
sudo ufw status numbered
```

### Ajouter une nouvelle règle

```bash
sudo ufw allow 8080
```

```bash
sudo ufw status numbered
```

### Supprimer une règle

```bash
sudo ufw delete <num_rule>
```

```bash
sudo ufw status numbered
```

## Check ssh

```bash
which ssh
```

```bash
sudo service ssh status
```

## Crontab

```bash
sudo crontab -u root -e
```


