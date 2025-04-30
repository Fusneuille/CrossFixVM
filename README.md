# CrossFixVM - Outil de gestion pour CrossOver macOS

![Badge macOS](https://img.shields.io/badge/10.15%2B-success?style=flat-square&logo=apple&label=MacOS&labelColor=grey)
![Shell](https://img.shields.io/badge/Bash-green?style=flat-square&label=Shell&labelColor=grey)
![Badge Version](https://img.shields.io/badge/1.1-yellow?style=flat-square&label=Version&labelColor=grey)
![Static Badge](https://img.shields.io/badge/Reset%20Trial-blueviolet?style=flat-square&label=Feature&labelColor=grey)
![License](https://img.shields.io/badge/MIT-blue?style=flat-square&label=License&labelColor=grey)

> **Avertissement Légal**  
> Ce logiciel est fourni à des fins éducatives uniquement. L'auteur décline toute responsabilité concernant :
> - Tout dommage matériel ou logiciel résultant de son utilisation
> - Toute conséquence légale liée à l'utilisation non autorisée de logiciels commerciaux
> - Toute perte de données ou dysfonctionnement système
> 
> L'utilisateur assume l'entière responsabilité de l'emploi de cet outil.

## ⚠️ Clause de Non-Responsabilité

<details>
<summary><strong>▶ Afficher/Masquer les clauses légales</strong></summary>

Conformément à la licence MIT, en utilisant ce logiciel, vous reconnaissez que :

1. **Usage Personnel** : Cet outil est destiné à l'étude des mécanismes de licence logicielle

2. **Compatibilité** : Aucune garantie de fonctionnement n'est fournie, notamment pour :
   - Les versions futures de CrossOver
   - Les environnements macOS modifiés
   - Les systèmes avec configurations particulières

3. **Conformité Juridique** : Il est de votre responsabilité de :
   - Vérifier la conformité avec les CGU de CodeWeavers
   - Disposer d'une licence valide si nécessaire
   - Respecter les lois locales sur la reverse engineering

4. **Sécurité** : Des modifications système sont effectuées, notamment :
   - Édition des registres Windows (bouteilles)
   - Modification des préférences système
   - Suppression de fichiers critiques

</details>

## ✨ Fonctionnalités Principales

| Fonctionnalité               | Description                                                                 | Statut  |
|------------------------------|-----------------------------------------------------------------------------|---------|
| 🔄 Réinitialisation          | Réinitialise le compteur des 14 jours d'essai                               | ✅      |
| 🍾 Gestion des bouteilles    | Nettoie les traces d'essai dans une bouteille spécifique                    | ✅      |
| 🗑️ Désinstallation complète | Supprime tous les fichiers de CrossOver (y compris les fichiers cachés)      | 🟨      |
| 📊 Vérification              | Affiche le temps restant de votre période d'essai                           | ✅      |
| 📈 Statistiques d'utilisation| Affiche l'espace disque utilisé et le nombre de bouteilles                  | ❌      |
| 📝 Journalisation            | Enregistre toutes les actions dans un fichier log                           | ❌      |
| 🖥️ Interface graphique       | Version basique avec Zenity pour une alternative GUI                        | ❌      |
| 🔍 Diagnostic                | Vérifie l'intégrité des bouteilles et détecte les problèmes                 | ❌      |
| 🎨 Interface CLI             | Menu intuitif avec affichage en couleur                                     | ✅      |
| 🔄 Mise à jour auto          | Vérifie les nouvelles versions sur GitHub                                   | ❌      |
| 🌎 Multilangue               | Support anglais/français basé sur la langue système                         | ❌      |



## 🖥 Prérequis

- **OS** : macOS 10.15 (Catalina) ou plus récent
- **Dépendances** : 
  - `plutil` (inclus avec macOS)
  - `sed` (inclus avec macOS)

## 🚀 Installation

1. Ouvrez votre terminal sur macOS.
2. Téléchargez le script avec la commande suivante :

```bash
curl -O https://raw.githubusercontent.com/Fusneuille/CrossFixVM/main/CrossFixVM.sh
```
3. Lancez l’outil :

```bash
sh CrossFixVM.sh
```

## 🧠 Remarques

- Ce projet est open source et à vocation pédagogique.
- Toute contribution ou amélioration est la bienvenue via une Pull Request.

