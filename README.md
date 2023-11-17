# Gestao-Posto-Combustivel
Projeto Delphi 11.3 para Gestão de Posto de Combustíveis

Script para criação do banco de dados se encontra na pasta \docs, arquivo "script database sql server.sql".
Um registro é criado na tabela "[dbo].[Imposto]", com o valor de 13.00 %, conforme enunciado do projeto.

A aplicação não possui tela de login.

Devido à minha falta de tempo, fiz uma análise muito ligeira sobre o projeto e mudanças foram feitas no decorrer do desenvolvimento.
Procurei mostrar que tenho conhecimento de desenvolvimento Orientado a Objetos.
Confesso que, devido ao padrão das telas de cadastros, eu poderia ter utilizado o conceito de Interfaces para a criação da Views e de RTTI para implemetação das classes DAO. Lembro de já ter utilizado RTTI, uma vez, onde uma Classe recebia, como parâmetro, uma classe Model e identificava sua classe, seus atributos e persistia no banco de dados. Isso economiza bastante tempo no desenvolvimento. Infelizmente, o tempo não me permitiu demostrar, na prática.


A Arquitetura utilizada no projeto foi MVC com DAO.
Poderia não ter implementado a classe DAO. Fiz para mostrar que tenho esse conhecimento, também...
