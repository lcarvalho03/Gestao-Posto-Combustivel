# Projeto Gestão de Posto de Combustível
## Objetivo:
- Demonstrar meu conhecimento na linguagem de programação Delphi, assim como os conceitos de Orientação a Objetos.
- Projeto desenvolvido utilizando Delphi 11.3, com Banco de Dados SQL Server 2022, para Gestão de Posto de Combustíveis.
- Implementação de Orientação a Objetos;

## Objetivo da Aplicação:
- Controlar os abastecimentos feitos durante cada dia, identificando a bomba utilizada, a quantidade de litros e o valor abastecido.
- Em cada abastecimento incide um imposto de 13% do valor abastecido, e essa informação deve ser registrada.
- Cada bomba está ligada a um tanque. No posto ABC existem dois tanques, um de gasolina e um de óleo diesel. Para cada tanque duas bombas de combustível.
- Emitir relatório em que os abastecimentos fossem agrupados, exibindo o dia, o tanque, a bomba e o valor. E ao final do relatório a soma total do período
** A aplicação não possui tela de login.

Devido à minha falta de tempo, fiz uma análise muito ligeira sobre o projeto e mudanças foram feitas no decorrer do desenvolvimento.

Confesso que, devido ao padrão das telas de cadastros, eu poderia ter utilizado o conceito de Interfaces para a criação da Views e de RTTI para implemetação das classes DAO. 
Lembro de já ter utilizado RTTI, uma vez, onde uma Classe recebia, como parâmetro, uma classe Model e identificava sua classe, seus atributos e persistia no banco de dados. Isso economiza bastante tempo no desenvolvimento. Infelizmente, o tempo não me permitiu demostrar, na prática.

## Script para criação dp Banco de Dados
O Script se encontra na pasta \docs, arquivo "script database sql server.sql".
Um registro é criado na tabela "[dbo].[Imposto]", com o valor de 13.00 %, conforme enunciado do projeto.



## Modelagem do banco de dados
Vale observar que a tabela de Abastecimento não possui relacionamento com as tabelas de Bomba de Combustível, Tanque de Combustível e Tipo de Combustível. Fiz dessa forma para demonstrar que pensei no negócio, onde, caso um registro dessas tabelas seja alterado, afetará no histórico do Abastecimento. Assim, esses campos são do tipo TEXTO.

## Arquitetura do Projeto
A Arquitetura utilizada no projeto foi MVC com DAO.
Poderia não ter implementado a classe DAO. Fiz para mostrar que tenho esse conhecimento, também...

O relatório, desenvolvido com FortesReport, não exibe os dados. Fiz a instalação pelo instalador baixado no Git da Comunidade, onde, após o processo, é preciso compilar e dar build em alguns pacotes.
Mesmo assim, os dados não aparecem.
O relatório foi criado, com os Grupos de "Data de Abastecimento", "Tanque de Combustível" e "Bomba de Combustível". Mas, os dados não aparecem.
De qualquer forma, apresento os registro em um DBGrid, após o usuário definir o período da consulta.

## Testes
Foi implementado um Teste Unitário, onde o projeto de testes se encontra na pasta "Gestao_Posto_Combustivel\testes"
