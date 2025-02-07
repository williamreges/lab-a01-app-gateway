# lab-a01-app-gateway


Projeto de estudo da simula pagamentos com Spring Cloud

---

## 🚀 Começando

Esse projeto é um exemplo de laboratório que simula operações de pagamentos via PIX. É uma API Gateway que cria rotas
para a Api Rest [lab-a01-app-bff-payment ](https://github.com/williamreges/lab-a01-app-bff-payment.git). 
Essa Api nada mais é que uma peça que redireciona PATHs e URL dentro do Eureka Server. 
Do Angular é feito uma requisição para o Api Gateway que por sua vez cria rota para o **BFF** que também por sua vez faz
requisições Rest ao **back-end**[lab-a01-app-repository-payment](https://github.com/williamreges/lab-a01-app-repository-payment.git) 
utilizando [Spring Cloud OpenFeign](https://spring.io/projects/spring-cloud-openfeign) como ferramenta de integração.
E para complementar essa Api Gateway trabalha se registra no [Service Registration and Discovery](https://spring.io/guides/gs/service-registration-and-discovery)
como o Eureka.

### 📋 Pré-requisitos

Instale alugmas ferramentas como

* Java 17
* Maven
* Spring Cloud Gateway
* Spring Cloud Eureka

### 🔧 Instalação

Instale o Java 17. Utilizei o [SDKMAN](https://sdkman.io/) como ferramenta no linux:

```bash
  sudo sdk install java 17.0.13-zulu
```

Instale o Maven. Utilizei o [SDKMAN](https://sdkman.io/) como ferramenta no linux:

```bash
  sudo sdk install maven 3.8.5
```

Clone o projeto

```bash
  git clone https://github.com/williamreges/lab-a01-app-gateway.git
```

Suba um serviço de registro e descoberta Spring Cloud para que a API se registre nela. Se optar por criar um do zero
siga esse tutorial [Service Registration and Discovery](https://spring.io/guides/gs/service-registration-and-discovery).
Porém, se quiser rodar outro projeto complementar a esse projeto clone o seguinte repo e siga o que está no README.md

```bash
  git clone https://github.com/williamreges/lab-a01-infra-service-registry
```

---

## ⚙️ Executando os testes

Entre no Projeto

```bash
  cd lab-a01-app-gateway 
```

Instale as dependencies do projeto

```bash
  mvn clean install
```

Start o serviço

```bash
  mvn spring-boot:run
```

Entre na porta http://localhost:8765/get se retornar algo como o exemplo abaixo  é porque o gateway está rodando com sucesso.

```json
{
  "args": {}, 
  "headers": {
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8", 
    "Accept-Encoding": "gzip, deflate, br, zstd", 
    "Accept-Language": "pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3", 
    "Content-Length": "0", 
    "Forwarded": "proto=http;host=\"localhost:8765\";for=\"127.0.0.1:46272\"", 
    "Hello": "World", 
    "Host": "httpbin.org", 
    "Priority": "u=0, i", 
    "Sec-Fetch-Dest": "document", 
    "Sec-Fetch-Mode": "navigate", 
    "Sec-Fetch-Site": "none", 
    "Sec-Fetch-User": "?1", 
    "Upgrade-Insecure-Requests": "1", 
    "User-Agent": "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0", 
    "X-Amzn-Trace-Id": "Root=1-67a623eb-5766918f6e60e2b41e45d085", 
    "X-Forwarded-Host": "localhost:8765"
  }, 
  "origin": "127.0.0.1, 191.178.195.171", 
  "url": "http://localhost:8765/get"
}

```

Para testar uma requisição de operação de pagamento via PIX através do Gateway execute o curl abaixo e a resposta será 
um UUID.

```bash
  curl --request POST \
  --url http://localhost:8765/transacao-pix \
  --header 'Content-Type: application/json' \
  --header 'User-Agent: insomnia/10.3.0' \
  --data '{
	"codigoPessoa": "fbc5fbc7-9b55-4058-af41-fa94ae092ae8",
	"valorTrancacao": 2500.50,
	"dataTrancacao": "2025-02-03T13:00:00",
	"codigoBeneficiario": "02d807e5-dd29-4a25-9de7-a621209c28b7",
	"mensagemTransacao":" PIX para compra de carro"
}'
```

E com o UUID gerado podemos obter o registro gravado na tabela conforme exemplo abaixo:

```bash
curl --request GET \
--url http://localhost:8765/transacao-pix/8644ae90-9225-41bd-8ff6-0a4b9622bfdc \
--header 'User-Agent: insomnia/10.3.0'
```

E com isso logo será retornado algo parecido com esse body abaixo:

```json
{
  "codigoTrancacao": "8644ae90-9225-41bd-8ff6-0a4b9622bfdc",
  "codigoPessoa": "fbc5fbc7-9b55-4058-af41-fa94ae092ae8",
  "valorTrancacao": 2500.5,
  "dataTrancacao": "2025-02-03T13:00:00",
  "codigoBeneficiario": "02d807e5-dd29-4a25-9de7-a621209c28b7",
  "mensagemTransacao": " PIX para compra de carro"
}
```

## 🔗 Referencias

* [Spring Cloud](https://spring.io/cloud)
* [SDKMAN](https://sdkman.io/)
* [Official Apache Maven documentation](https://maven.apache.org/guides/index.html)
* [Spring Boot Maven Plugin Reference Guide](https://docs.spring.io/spring-boot/3.4.2/maven-plugin)
* [Create an OCI image](https://docs.spring.io/spring-boot/3.4.2/maven-plugin/build-image.html)
* [Spring Configuration Processor](https://docs.spring.io/spring-boot/3.4.2/specification/configuration-metadata/annotation-processor.html)
* [Config Client](https://docs.spring.io/spring-cloud-config/reference/client.html)
* [Gateway](https://docs.spring.io/spring-cloud-gateway/reference/spring-cloud-gateway-server-mvc.html)
* [Eureka Discovery Client](https://docs.spring.io/spring-cloud-netflix/reference/spring-cloud-netflix.html#_service_discovery_eureka_clients)

### Guides
The following guides illustrate how to use some features concretely:

* [Service Registration and Discovery with Eureka and Spring Cloud](https://spring.io/guides/gs/service-registration-and-discovery/)

