---
abstract: >-
   Jenkins Helm chart with values and perhaps a few other services.
authors:
   - name: Xander Harris
     email: xandertheharris@gmail.com
date: 2024-08-04
title: Jenkins Helm Chart
---

## Repository Contents

````{sidebar}
```{contents}
```
````

```{toctree}
:caption: contents

tests/index
```

```{toctree}
:caption: meta

changelog
code_of_conduct
contributing
license
readme
upgrading
values.md
```

### Pre-commit hooks

The Jenkinsfile is linted with
[pre-commit-jenkinsfile](https://github.com/tcumby/pre-commit-jenkinsfile).

Some Jenkinsfile-related [nvim](https://github.com/joshzcold/cmp-jenkinsfile)
[plugins](https://github.com/ckipp01/nvim-jenkinsfile-linter) are also
in use.

## Indices and tables

* {ref}`genindex`
* {ref}`modindex`
* {ref}`search`

```{glossary}
argo-cd
   A declarative, GitOps continuous delivery tool for {term}`Kubernetes`.
   More information is available [here](https://github.com/argoproj/argo-cd).

ArtifactHub
   A centralized location for Helm charts and artifacts. More information
   is available [here](https://artifacthub.io/packages/helm/argo/argo-cd).

GitHub
   Most likely the site this repository is hosted on. More information is
   available [here](https://github.com).

Helm
   A tool commonly used to deploy applications to {term}`Kubernetes`. More
   information is available [here](https://helm.sh).

Kubernetes
   An ancient Greek word that means 'sailor' or 'navigator', it is the
   most common container orchestration system currently in use. More
   information is available [here](https://kubernetes.io).
```

## Usage

Typical Helm chart rules.

<!--

### Chart

```{autoyaml} Chart.yaml
```

### Values

```{autoyaml} values.yaml
```
-->

## Changelog

```{toctree}
changelog
```

```{sectionauthor} Xander Harris <xandertheharris@gmail.com>
```
