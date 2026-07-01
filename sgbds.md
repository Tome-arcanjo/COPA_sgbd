# Proposta de Seminário – Projeto de Banco de Dados

## Título

# Utilização de Sistemas Gerenciadores de Banco de Dados (SGBDs) na Copa do Mundo FIFA

---

## Equipe

- Tomé Arcanjo
- Nathan Lopes
- Diêgo Axel


---

# SGBDs Abordados

O seminário apresentará como diferentes Sistemas Gerenciadores de Banco de Dados (SGBDs) podem ser utilizados em aplicações relacionadas à Copa do Mundo FIFA, destacando suas características, vantagens e aplicações em cenários reais de armazenamento, processamento e análise de dados esportivos.

Serão abordados os seguintes SGBDs:

- **Oracle Database**
  - Utilizado em ambientes corporativos que exigem alta disponibilidade, segurança e desempenho.
  - Possui recursos avançados para grandes volumes de dados, replicação, particionamento e processamento analítico.

- **MySQL**
  - SGBD relacional de código aberto amplamente utilizado em aplicações web.
  - Destaca-se pela facilidade de uso, desempenho e grande comunidade de suporte.

- **Microsoft SQL Server**
  - Plataforma desenvolvida pela Microsoft com forte integração ao ecossistema Azure e ferramentas de Business Intelligence.
  - Indicado para aplicações corporativas que necessitam de análises, relatórios e integração com outras soluções Microsoft.

- **PostgreSQL**
  - Banco de dados relacional open source reconhecido pela conformidade com padrões SQL, extensibilidade e suporte a recursos avançados.
  - Muito utilizado em aplicações que demandam consistência, escalabilidade e processamento geoespacial.

---

# Proposta Prática

Será desenvolvido um banco de dados inspirado na plataforma **Football Data Platform** da FIFA, utilizando como base informações públicas sobre a Copa do Mundo.

O projeto terá como objetivo demonstrar como diferentes SGBDs podem armazenar e manipular grandes volumes de dados esportivos.

Serão implementadas funcionalidades como:

- modelagem do banco de dados;
- criação das tabelas e relacionamentos;
- inserção de dados referentes às seleções, jogadores, partidas, estádios e estatísticas;
- consultas SQL envolvendo filtros, ordenações e agrupamentos;
- utilização de *joins* para recuperação de informações relacionadas;
- criação de índices para otimização de consultas;
- demonstração de procedimentos, funções ou recursos específicos disponíveis em cada SGBD, quando aplicável;
- comparação das características dos SGBDs considerando desempenho, facilidade de administração, recursos oferecidos e possíveis aplicações no contexto esportivo.

Como base de dados, serão utilizadas informações públicas disponibilizadas pela FIFA e conjuntos de dados abertos relacionados à Copa do Mundo.

O objetivo da apresentação é demonstrar como um mesmo modelo relacional pode ser implementado em diferentes SGBDs, evidenciando suas particularidades e os cenários em que cada tecnologia apresenta vantagens.

---

# Objetivos

## Objetivo Geral

Apresentar a utilização de diferentes Sistemas Gerenciadores de Banco de Dados em aplicações relacionadas à Copa do Mundo FIFA, demonstrando suas principais características por meio de um projeto prático.

## Objetivos Específicos

- compreender as características dos principais SGBDs relacionais;
- desenvolver um banco de dados baseado em informações da Copa do Mundo;
- implementar consultas SQL para extração de informações relevantes;
- comparar os recursos oferecidos por Oracle, MySQL, Microsoft SQL Server e PostgreSQL;
- demonstrar a importância dos bancos de dados na gestão de grandes volumes de informações esportivas.

---

# Referências

FIFA. **Football Data Platform**. Disponível em: <https://inside.fifa.com/innovation/football-data/football-data-platform>. Acesso em: jun. 2026.

FIFA. **Football Data Ecosystem**. Disponível em: <https://support.tickets.fifa.com/innovation/world-cup-2022/football-data-ecosystem>. Acesso em: jun. 2026.

FIFA. **Football Data Solutions**. Disponível em: <https://inside.fifa.com/innovation/football-data/football-data-solutions>. Acesso em: jun. 2026.

FIFA. **Innovation**. Disponível em: <https://inside.fifa.com/innovation>. Acesso em: jun. 2026.

FJELSTUL, Joshua C. **The Fjelstul World Cup Database**. GitHub, 2023. Disponível em: <https://github.com/jfjelstul/world_cup_db>. Acesso em: jun. 2026.
