# Ateliers de professionnalisation : BTS SIO 1

Programmes de contrôle `./verifier` des ateliers de professionnalisation (AP) du BTS SIO 1,
Campus Beaupeyrat. Chaque atelier a son dossier (`ap03/`…). Sur ta VM, `./verifier` fait le point
mission par mission : ✓ c'est bon, ✗ c'est à revoir (avec un conseil).

## Récupérer les programmes (une fois, sur ta VM)

```bash
git clone https://github.com/PoweredByDebian/ap-sio1.git
```

## Faire le point

```bash
cd ~/ap-sio1/ap03
sudo ./verifier
```

Le programme a besoin de `sudo` pour lire la configuration des services et interroger la base de
données. Il ne modifie rien sur ta machine. Quand tout est juste, il finit par `exit 0` : appelle
le professeur.

## Mettre à jour

Si le professeur annonce une correction :

```bash
cd ~/ap-sio1 && git pull
```

## À savoir

- Ce dépôt ne contient **aucune réponse** : les codes à trouver y sont vérifiés par empreinte
  (sha256), ils ne sont pas lisibles.
- `./verifier` sert à **te guider**. Ce n'est pas lui qui note l'atelier.

---

Florent `fls` Sautour · Campus Beaupeyrat · code sous licence GPL-3.0-or-later (fichier `LICENSE`).
