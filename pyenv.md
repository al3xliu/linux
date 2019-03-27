# Pyenv and Virtualenv

## Pyenv

reference: https://amaral.northwestern.edu/resources/guides/pyenv-tutorial

### Usage

- install

```bash
pyenv install 3.7.0
```

- show versions

```bash
pyenv versions
```

- switch global version

```bash
pyenv global 3.4.0
```

- switch local/project version

```bash
cd xxx; pyenv local 3.4.0
```


## Virtualenv

- create

```bash
cd project;pyenv virtualenv 3.4.0 venv
```

- enable

```bash
pyenv activate venv
```

- disable

```bash
pyenv deactivate
```
