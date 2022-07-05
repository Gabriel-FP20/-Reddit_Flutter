# Desafio FPF - Feed Tecnologia

Um projeto Flutter que exibe os posts mais relevantes de um subreddit do [Reddit](https://www.reddit.com/). 

## Instalação

Para instalação do framework Flutter, siga as instruções do link a seguir:

```
https://docs.flutter.dev/get-started/install
```

Após configurar o Flutter, siga os passos:

**Passo 1: Clonando Repositório**

Realize a clonagem do repositório usando o seguinte link:

```
https://github.com/Gabriel-FP20/-desafio_FPF_Gabriel_Fonseca
```

**Passo 2: Baixando Depedências**

Abra a raiz do projeto e execute a seguinte linha no terminal de comando:

```
flutter pub get 
```

**Passo 3: Executando o projeto**

Para rodar o projeto, execute a seguinte linha no terminal de comando:

```
flutter run 
```

## Referências

**Bibliotecas Utilizadas**

As funcionalidades fundamentais utilizaram as seguintes bibliotecas, cuja documentação está disponível no https://pub.dev.

    // Leitura de QRCode
    import 'QRCode.dart' 
    // Reconhecimento de voz
    import 'package:flutter_speech/flutter_speech.dart' 
    // Wrapper para API Reddit
    import 'package:draw/draw.dart';

**Tutorials**

- https://acervolima.com/flutter-qr-code-scanner-e-qr-generator/


## Como Usar

Ao abrir o aplicativo, digite o subreddit desejado na caixa de texto! Você pode utilizar a leitura por QRCode ou Digitação por voz.

Ao clicar no botão "Search", surgirá uma lista com os pots mais relevantes daquele subreddit. 

Ao clicar em um post, você será redirecionado para a tela de postagem e comentários daquele post. 

## Observações

O Reconhecimento de voz está incompleto. Ainda necessita de ajustes no código.
