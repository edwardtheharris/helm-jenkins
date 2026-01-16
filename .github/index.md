---
abstract: Continuous Integration, Delivery, and Deployment.
authors:
    - name: Xander Harris
      email: xandertheharris@gamil.com
date: 2024-08-04
title: CI/CD usage guide
---

Or something like it.

## GitHub Action Workflows

The following workflows are in use by this repository.

### CodeQL Workflow

[![CodeQL](https://github.com/edwardtheharris/helm-template/actions/workflows/codeql.yml/badge.svg)](https://github.com/edwardtheharris/helm-template/actions/workflows/codeql.yml)

```{autoyaml} .github/workflows/codeql.yml
```

### Documentation Workflow

[![Documentation](https://github.com/edwardtheharris/helm-template/actions/workflows/documentation.yml/badge.svg)](https://github.com/edwardtheharris/helm-template/actions/workflows/documentation.yml)

```{autoyaml} .github/workflows/documentation.yml
```

### Helm Workflow

[![Test Helm Chart](https://github.com/edwardtheharris/helm-template/actions/workflows/helm.yml/badge.svg)](https://github.com/edwardtheharris/helm-template/actions/workflows/helm.yml)

```{autoyaml} .github/workflows/helm.yml
```

### OSSAR Workflow

[![OSSAR](https://github.com/edwardtheharris/helm-template/actions/workflows/ossar.yml/badge.svg)](https://github.com/edwardtheharris/helm-template/actions/workflows/ossar.yml)

```{autoyaml} .github/workflows/ossar.yml
```

## Dependabot Settings

[![Dependabot Updates](https://github.com/edwardtheharris/helm-template/actions/workflows/dependabot/dependabot-updates/badge.svg)](https://github.com/edwardtheharris/helm-template/actions/workflows/dependabot/dependabot-updates)

```{autoyaml} .github/dependabot.yml
```
