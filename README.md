# FJOB Helm repo

- [FJOB Helm repo](#fjob-helm-repo)
  - [Usage](#usage)
    - [Add helm repository](#add-helm-repository)
  - [Create new chart](#create-new-chart)

## Usage    

### Add helm repository

```
helm repo add zetajsc https://raw.githubusercontent.com/zetajsc/charts/master
```


## Create new chart

Create new chart

```
helm create NAME [flags]
```

Packages a chart into a versioned chart archive file

```
helm package [CHART_PATH] [...] [flags]

# Example 
helm package ./webpress-server -d releases
```

Read the current directory and generate an index file based on the charts found.

```
helm repo index [DIR] [flags]

# Example
helm repo index ./
```