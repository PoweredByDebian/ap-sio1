# SPDX-License-Identifier: GPL-3.0-or-later
# Copyright (C) 2026 Florent « fls » Sautour, Campus Beaupeyrat
#
# lib/verifier.sh : fonctions communes aux programmes ./verifier des ateliers.
# A charger depuis apXX/verifier :  . "$(dirname "$0")/../lib/verifier.sh"
#
#   need_root                    exige sudo (lecture de la conf, requetes MariaDB)
#   title "Nom de l'atelier"     bandeau de debut
#   mission "Mission 1 : SSH"    debut d'une mission
#   check "libelle" commande...  lance la commande : ✓ si elle reussit (1 point), ✗ sinon
#   hint "conseil"               conseil affiche sous le dernier ✗
#   answer "valeur" <sha256>     vrai si la valeur (sans espaces, en minuscules) a cette empreinte
#   finish "message final"       affiche le score ; exit 0 si tout est juste, exit 1 sinon

if [ -t 1 ]; then
  _G=$'\e[32m'; _R=$'\e[31m'; _Y=$'\e[33m'; _B=$'\e[1m'; _D=$'\e[2m'; _N=$'\e[0m'
else
  _G=; _R=; _Y=; _B=; _D=; _N=
fi
_score=0
_total=0
_last=0

need_root() {
  if [ "$(id -u)" -ne 0 ]; then
    echo "${_Y}Ce programme a besoin des droits d'administration : relance-le avec sudo ./verifier${_N}"
    exit 2
  fi
}

title()   { echo; echo "${_B}[ $1 ]${_N}"; }
mission() { echo; echo "${_B}$1${_N}"; }

check() {
  local label="$1"; shift
  _total=$((_total + 1))
  if "$@" >/dev/null 2>&1; then
    echo "  ${_G}✓${_N} $label"; _score=$((_score + 1)); _last=0
  else
    echo "  ${_R}✗${_N} $label"; _last=1
  fi
}

hint() { [ "$_last" -eq 1 ] && echo "    ${_D}→ $1${_N}"; return 0; }

answer() {
  local v
  v="$(printf '%s' "$1" | tr -d '[:space:]' | tr '[:upper:]' '[:lower:]')"
  [ -n "$v" ] && [ "$(printf '%s' "$v" | sha256sum | cut -d' ' -f1)" = "$2" ]
}

finish() {
  echo
  echo "  ${_B}Bilan $_score/$_total${_N}"
  if [ "$_score" -eq "$_total" ]; then
    echo; echo "${_G}$1${_N}"; exit 0
  fi
  echo "  Corrige les ✗ puis relance sudo ./verifier."
  exit 1
}
