# Ambiente Robot Framework

Projeto configurado para usar Python pelo `asdf`.

## Como ativar

```bash
asdf install
source .venv/bin/activate
export PATH="$PWD/.drivers/bin:$PATH"
```

## Como instalar dependencias

```bash
python -m pip install -r requirements.txt
```

## Como verificar

```bash
robot --version
chromedriver --version
geckodriver --version
```

## Como rodar os testes

```bash
robot --outputdir results casosdeteste.robot
```

Os arquivos gerados pela execução ficam em `results/`.

Os webdrivers locais ficam em `.drivers/bin` e foram baixados dos sites oficiais:

- ChromeDriver: Chrome for Testing
- GeckoDriver: Mozilla/geckodriver
