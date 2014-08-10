Esporty App Server Side
=============

Este é o server side (lado servidor) do código exemplo apresentado na [Trilha iOS do TDC SP 2014](http://www.thedevelopersconference.com.br/tdc/2014/saopaulo/trilha-ios), Melhorando a experiência do usuário usando Background Fetching, por [George Villasboas](https://twitter.com/ghvillasboas).

**A keynote da talk, em PDF, pode ser [baixada aqui](https://drive.google.com/file/d/0B0KwdWz7zxc2a0QwNjRmb2ZYQzg/edit?usp=sharing)**

Ele serve para simular um serviço remoto usado para alimentar o aplicativo Esporty (App fictício de compartilhamento de fotos de esportes radicais) e enviar Remote Notifications para mostrar o funcionamento de background fetches.

## Como instalar

1. Faça a instalação do ambiente Ruby/Rails em sua maquina local. Se você é novo em Ruby/Rails, sugiro seguir este tutorial passo-a-passo: http://www.createdbypete.com/articles/ruby-on-rails-development-setup-for-mac-osx/ (em inglês e para OSX).

2. Clone este repositório.

3. Crie os seus certificados de push notification no Apple Developer Portal. Instruções de como gerar o arquivo .pem, você pode encontrar aqui: https://github.com/jpoz/APNS (em inglês).

4. Mova o arquivo *certs.pem* para a pasta /config/apple_apns/ do repositório clonado. Caso decida colocar outro nome no seu arquivo .pem, lembre-se de atualizar o arquivo /app/controlers/posts_controller.rb ([linha 111](https://github.com/ghvillasboas/EsportyAppServerSide/blob/master/app/controllers/posts_controller.rb#L111)).

4. Via terminal acesse o diretório do repositório clonado

5. Execute os comandos:
```
    $ rake db:migrate
    $ rails server
```

6. No seu browser acesse o endereço: http://localhost:3000. Sua tela deve ser semelhante à exibida abaixo:

![Acesso backend Esporty App](https://raw.github.com/ghvillasboas/EsportyAppServerSide/master/app/assets/images/esporty1.png)

7. Não existe passo 7. :)

## Como enviar um Remote Notification

1. Execute o código do repositório [Esporty App](https://github.com/ghvillasboas/EsportyApp) em seu dispositivo iOS (detalhes sobre o app você encontra no readme do repositório).

2. Acesse *http://localhost:3000*

3. Clique em *NEW*

4. Copie e cole o token de push notification do seu device no campo Token. Para obter o token, observe o console do seu Xcode, ele aparece como no exemplo abaixo:

```
    2014-08-09 11:49:20.409 Esporty[84530:607] Token APNS: <TOKEN>
```

5. Informe um comentário qualquer e clique em "Create post", como na imagem abaixo:

![Criando um post para o Esporty App](https://raw.github.com/ghvillasboas/EsportyAppServerSide/master/app/assets/images/esporty2.png)

6. Observe o console do Xcode pelo recebimento do Remote Notification.

```
    2014-08-09 11:49:20.409 Esporty[84530:607] Posts atualizados: X
```

## Dicas

- Caso o remote notification não chegue, verifique se os certificados foram gerados corretamente.
- Teste o serviço de push, usando um Push Notification comum, comentando a [linha 114](https://github.com/ghvillasboas/EsportyAppServerSide/blob/master/app/controllers/posts_controller.rb#L114) do arquivo /app/controlers/posts_controller.rb e descomentando a [linha 117](https://github.com/ghvillasboas/EsportyAppServerSide/blob/master/app/controllers/posts_controller.rb#L117). Crie um novo post. Isto fará com que o serviço envie um push comum ao invés de um push silencioso. Descomente/comente novamente as linhas para usar o push remoto.

## Configuração testada

- OSX 10.9+
- Ruby 2.1.2p95
- Rails 4.1.2
- Gem APNS 1.1.0

## Perguntas?

Só abrir um issue.

## Colaborações?

Dê um pull request.

Enjoy!
