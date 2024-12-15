# FIAP Tech Challenge 8SOAT - Grupo 04 - Fase 3 - Terraform infraestrutura de banco de dados

## AWS RDS / Elastic Cache with Terraform

### Objetivo do Projeto

Este repositório contém todo o mapeamento utilizando a ferramenta terraform para a criação de todos os recursos de banco de dados, VPC e network e security group na cloud AWS para a execução da aplicação de sistema de controle de pedidos para uma lanchonete em expansão

### Principais funcionalidades:

- Criação e configuração do recurso VPC da AWS: Permite que o terraform realize a criação e configuração do recurso VPC para manter os recursos criados dentro de uma rede privada;
- Criação e configuração do recurso Subnets da AWS: Permite que o terraform realize a criação e configuração do recurso de subnets privadas e públicas para manter os recursos em determinada Network com habilitação do Internet Gateway para comunicação com a internet.
- Criação e configuração do recurso S3 da AWS: Permite que o terraform realize a criação e configuração do recurso S3 para armazenar o arquivo de estado do terraform;
- Criação e configuração do recurso RDS Postgres da AWS: Permite que o terraform realize a criação e configuração do recurso RDS Postgres para armazenamento dos dados gerados pela aplicação.
- Criação e configuração do recurso Elastic Cache Redis da AWS: Permite que o terraform realize a criação e configuração do recurso Elastic Cache para armazenamento de dados em memória para otimizar a performance das consultas de dados do Cliente ao utilizar a aplicação.
- Criação e configuração do recurso Secret Manager Service da AWS: Permite que o terraform realize a criação e configuração do recurso para armazenamento dos valores para acesso aos bancos de dados criados nos passos anteriores.

### **Justificativa para utilização dos Bancos de Dados**

#### PostgreSQL - Relacional

O PostgreSQL é reconhecido como um dos bancos de dados relacionais mais robustos e confiáveis, tornando-o ideal para aplicações que exigem consistência, integridade e flexibilidade no gerenciamento de dados estruturados. Os benefícios incluem:

- Suporte a _ACID_: Garantia de Atomicidade, Consistência, Isolamento e Durabilidade, essencial para a confiabilidade dos dados em um sistema de pedidos onde consistência é crítica.
- Modelagem de Dados Relacional: Ideal para estruturas complexas e relações entre tabelas de registros.
- Escalabilidade: Capaz de lidar com grandes volumes de dados e operações simultâneas, mantendo boa performance.
- Segurança: Tem uma forte política de segurança e oferece recursos avançados de criptografia, autenticação e controle de acesso.
- Comunidade Ativa: Atualizações frequentes e grande comunidade de suporte.

#### Redis - Em Memória para Caching

O Redis foi escolhido como um banco de dados em memória para caching das consultas à tabela de _Customer_ (clientes), devido à sua velocidade excepcional e capacidade de reduzir a carga no banco principal. Os benefícios incluem:

- Alta Performance: O Redis armazena os dados na memória _RAM_, oferecendo tempos de resposta na casa de microssegundos, essencial para acelerar consultas frequentes.
- Redução da Latência: As consultas repetitivas à tabela _Customer_, como validações ou verificações, são atendidas rapidamente sem sobrecarregar o PostgreSQL.
- Escalabilidade Horizontal: Possibilidade de escalonar com facilidade para lidar com grandes volumes de dados em memória e aumentar a capacidade de leitura.
- Simplicidade e Flexibilidade: Suporte a estruturas de dados como listas, conjuntos e hashes, facilitando o armazenamento de informações de clientes e o acesso rápido por chaves específicas.
- Compatibilidade com Microservices: Redis é amplamente utilizado em arquiteturas modernas para comunicação entre serviços e gerenciamento de cache distribuído.

Essa combinação se faz eficaz pois, enquanto o PostgreSQL garante persistência e consistência dos dados, o Redis aumenta a escalabilidade e velocidade, reduzindo a carga do banco relacional para consultas que não exigem transações complexas.

### **Pré Requisitos**

- [AWS CLI](https://aws.amazon.com/cli/)
- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Execução

Para a execução de toda a criação e provisionamento da infraestrutura na Cloud AWS, existem duas formas que podem ser utilizadas, local e via pipelines no GitHub. Abaixo estão os links com a descrição dos passos necessários para cada forma. Para realizar a execução respeite a ordem de execução descrita na documentação, pois existem dependências de recursos presentes nesse repositórios, caso o contrário, a execução não será feita com sucesso e poderá apresentar erros.

- Para realizar a execução local para o provisionamento da infraestrutura na cloud AWS, siga a seguinte [documentação](docs/LOCAL_EXECUTION.md), que possui todos os passos necessários.

- Para realizar a execução via pipeline no GitHub para o provisionamento da infraestrutura na cloud AWS, siga a seguinte [documentação](docs/PIPELINE_EXECUTION.md), que possui todos os passos necessários.

### Participantes do Projeto

- Amanda Maschio - RM 357734
- Jackson Antunes - RM 357311
- Lucas Accurcio - RM 357142
- Vanessa Freitas - RM 357999
- Winderson Santos - RM 357315
