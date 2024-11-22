# Tech Challenge Group 4 - Fase 3

## AWS RDS with Terraform

### **Pré Requisitos**
- [AWS CLI](https://aws.amazon.com/cli/)
- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### **Iniciar AWS Academy**
- Fazer login no [AWS Academy](https://awsacademy.instructure.com/), com a conta
fornecida pela curso.
- No menu lateral, selecionar "Courses" e selecionar a opção disponível.
	Ex: AWS Academy Learner Lab [123456]
- Selecione "Módulos" para iniciar o curso.
- Na opção "Laboratório de aprendizagem da AWS Academy" clique em:
	"Iniciar os laboratórios de aprendizagem da AWS Academy"
- Após carregar a página clicar em "Start Lab" e aguardar a inicialização do Laboratório
- Quando o status do laboratório alterar para "verde", clicar em "AWS Details" e em AWS CLI em seguida, ali estará contida as chaves e token para utilização via CLI e Github Actions.

### C**onfiguração de novo perfil AWS para conta do AWS Academy**
- No console onde foi instalado o AWS CLI em seu computador, alterar o arquivo ~/.aws/credentials para adicionar o novo perfil, é possível fazer a alteração utilizando o "nano", o "vim" ou o próprio VSCode com o comando "code ~/.aws/credentials"
- Abaixo do perfil `[default]` adicionar os dados copiado em "AWS Details" do AWS Academy:
```
[lab-academy]
aws_access_key_id=seu-id
aws_secret_access_key=sua-chave
aws_session_token=seu-token
```

### **Rodando o projeto**
- Fazer um **Fork** desse projeto criando um repositório novo em sua conta do Github.
- O **Fork** se faz necessário, apenas por conta da pipeline, onde é necessário adicionar
as variáveis de ambiente em sua conta do Github, para que ela funcione corretamente.
- Após clonar o projeto para sua máquina, acessar a pasta tech-challenge-database/iac
- Criar um novo arquivo chamado `terraform.tfvars` dentro do diretório "iac", com base no arquivo `terraform-example.tfvars`
contendo as seguintes variáveis:
```
db_postgres_username = "postgres"
db_postgres_password = "Senha!123456"
db_postgres_database = "TechChallengeDatabase"
```

- Acessar o diretório `cd iac` e digitar o comando `terraform init`

- Caso ocorra um problema com o backend nessa etapa, isso ocorre porque ainda não
temos um recurso AWS S3 provisionado para armazenamento no nosso terraform.state
no momento, portanto, devemos acessar o arquivo `./iac/providers.tf` e comentar as
seguintes linhas de **08** a **13**:
```javascript
  backend "s3" {
    bucket  = "tech-challenge-database-bucket-state-tf"
    region  = "us-east-1"
    key     = "terraform.tfstate"
    encrypt = true
  }
```

- Dentro do diretório `iac`
- Digitar novamente o comando `terraform init`
- Digitar o comando `terraform plan`
- Digitar o comando `terraform apply -auto-approve`

- O processo de criação do serviços leva de 8 a 10 minutos

- Após criação dos recursos, descomentar o código das linhas **08** a **13** 
e rodar os comando novamente:
- Digitar o comando `terraform init`
- Digitar o comando `terraform plan`
- Digitar o comando `terraform apply -auto-approve`

- Isso fará com que o estado do terraform seja gravado dentro do bucket do S3 e 
não mais em sua máquina local.


### **Destruindo recursos**
- **1ª. Opção**: Destruindo todos os recursos, com exceção do estado do terraform:
```sh
terraform destroy \          
  -target=module.rds \
  -target=module.secrets \
  -auto-approve
```

- **2ª. Opção**: Destruindo todos os recursos, inclusive o estado do terraform:
- No arquivo ./iac/providers.tf na linha **25**, alterar para `false` a propriedade `prevent_destroy`
- Rodar os comandos abaixo para efetuar a alteração de prevenção de exclusão:
```sh
terraform init`
```
```sh
terraform plan
```
```sh
terraform apply -auto-approve
```

- E o comando abaixo para excluir todos os recursos:

	Para ver os recursos que serão destruídos:
```sh
terraform plan -destroy
```
Para destruir todo os recursos:
```sh
terraform apply -destroy
``` 
ou  
```sh
terraform destroy
```

### **Variáveis de ambiente e Pipeline**
- No repositório do projeto do Github, ir em `Settings` -> `Environments`
- Criar um novo ambiente `New environment`, chamado `development`
- Adicionar as seguintes variáveis de ambiente e segredo.

**Environment secrets**: `DB_PASSWORD`, senha do banco de dados, conforme arquivo `terraform.tfvars`

**Environment variables**:
```sh
AWS_ACCESS_KEY_ID: valor disponível na conta da AWS Academy
AWS_SECRET_ACCESS_KEY: valor disponível na conta da AWS Academy
AWS_SESSION_TOKEN: valor disponível na conta da AWS Academy
DB_NAME: TechChallengeDatabase
DB_USER: postgres
```

Adicionar a branch em que as variáveis de ambiente estarão disponíves:
**Deployment branches and tags**: Selected branches and tags
- Adicionar a branch: 'main'

### Executando a pipeline
- Criar uma nova branch, subir um novo commit com alguma alteração e criar um novo
Pull Request, mergeando junto a branch `main`.
- Isso deverá acionar um trigger que irá inicar a pipeline.
- Certifique que o ambiente do AWS Academy esteja funcionando e os dados
de acesso estejam atualizado nas variáveis de ambiente do repositório.