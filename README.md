# To Note and Share / Para Anotar e Compartilhar
<p>Quarto desenvolvimento de um app em Flutter/Dart.</p>
<p><b>Vídeo: <a href="">Clique aqui!</a></b></p>

## Visão Geral
<p align="justify">Uma extensão do app prévio <a href="https://github.com/ludmilateixeira/app_sharedpreferences/">"To Buy and Share / Para Comprar e Compartilhar"</a>, este app possui as mesmas funcionalidades de seu anterior, porém possui novas atualizações: 
<br/>
O app agora salva automaticamente (persiste) todo o conteúdo da lista de compras em um arquivo json, que é lido durante a inicialização do app. Ou seja, os itens da lista não são perdidos depois que o app é fechado.</p>
<p align="justify">Possui a opção de escolha entre os temas Light e Dark para o app.</p>
<p align="justify">Em quesito técnico, o app passou a ser organizado através do gerenciamento dos dados usando SQLite (através do package Floor), e gerenciamento dos estados do app (através do package MobX). </p>
<p align="justify">O app também é organizado seguindo o padrão Model–view–controller (MVC). Com isso, o APP foi divido nas seguintes camadas:</p>
<ul>
<li><b>Model</b>: Contendo a classe Item com seus atributos: nome, preço e quem é o responsável, funções que transformam a instância da classe em um objeto json e vice-versa;</li>
<li><b>View</b>: Contendo a classe View onde estão todos os métodos de layout e design do app;</li>
<li><b>Controller</b>: Contendo a classe Controlle, que controla o fluxo dos dados, possuindo as funções de insert, update e delete (CRUD);</li>
<li><b>Repository</b>: Contendo a classe Repository, onde ficam os métodos que envolvem o acesso direto ao banco de dados / armazenamento de dados (json na programação atual).</li>
</ul> 
<br/>
O app possibilita a adição do item, com possibilidade de inserção do valor, da pessoa responsável pelo item e agora a quantidade, contudo, os campos não são obrigatórios, trazendo assim mais praticidade.
<br/>
Até mais!
