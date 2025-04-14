
# Projeto de Banco de Dados - E-commerce Refinado

## Descrição

Este projeto tem como objetivo representar o modelo lógico e implementação de um banco de dados para um sistema de **e-commerce**. Ele é baseado em um modelo conceitual refinado com as seguintes particularidades:

- Clientes podem ser pessoas físicas (PF) ou jurídicas (PJ), mas nunca ambos ao mesmo tempo.
- Pagamento pode ter múltiplas formas cadastradas.
- Entrega possui código de rastreio e status.
- Um produto pertence a um único fornecedor e pode ser vendido por diferentes vendedores.
- Um ou mais produtos compõem um pedido.
- Endereço do cliente influencia o frete.
- Cliente pode fazer múltiplos pedidos.
- Pedidos podem ser cancelados.
- Cada pedido possui status de entrega e código de rastreio.

## Modelo Lógico

As entidades principais são:

- **Clientes, ClientesPF, ClientesPJ**
- **Pedido**
- **Produto, Fornecedor, Estoque**
- **Produto_has_Estoque**
- **ThirdParty_Seller, ThirdParty_Produtos**
- **Disponibilidade_do_Produto**
- **Pagamento**
- **Entrega**
- **Vendedor**
- **Relação de Produto/Pedido**

## Estrutura do Projeto

- Criação do esquema relacional com todas as tabelas.
- Inserção de dados para testes.
- Consultas SQL complexas com cláusulas `WHERE`, `ORDER BY`, `HAVING`, `JOIN` e atributos derivados.

## Perguntas respondidas pelas consultas SQL

1. **Quantos pedidos foram feitos por cada cliente?**
2. **Algum vendedor também é fornecedor?**
3. **Relação de produtos, fornecedores e estoques**
4. **Relação de nomes dos fornecedores e nomes dos produtos**
5. **Quais pedidos foram entregues com sucesso?**

## Queries SQL Demonstrativas

Consultas no script SQL demonstram:

- Recuperações simples com `SELECT`
- Filtros com `WHERE`
- Atributos derivados com expressões
- Ordenações com `ORDER BY`
- Agrupamentos com `GROUP BY` e filtros com `HAVING`
- Junções entre múltiplas tabelas (`JOIN`)
