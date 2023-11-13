# dbt Multi-Project

This project aims to demonstrate a dbt environment with multiple projects. It consists of a base project, which serves as a contract and should not be modified, and child projects that function as data marts.

The base project contains all the sales data, which is considered contractual and remains unchanged. The child projects, named "marketplace_others" and "marketplace_sp", focus on sales data from all states in Brazil except São Paulo and sales data specifically from São Paulo, respectively.

By showcasing this project structure, we highlight the flexibility and scalability of dbt in managing different aspects of an analytics or data engineering workflow. The separation into base and data mart projects allows for modularity, easy maintenance, and the ability to analyze specific subsets of data without affecting the core contract data.

## High-level architecture


### Contracts with outside world (parent):

**Path:** `transform/base/models/`

**Details:**

- We cannot run children’s models.
- It'll be clean without stage models.

### Stages with models & analyses (children):

**Path:**
- `transform/marketplace_others/models/`
- `transform/marketplace_others/analyses/`
- `transform/marketplace_sp/models/`
- `transform/marketplace_sp/analyses/`

**Details:**
- It'll be clean without mart (contract) and other stage models.
- There will be no risks of accidentally running `marketplace_others` models from the `marketplace_sp` project and vice-versa.
- There will be no name conflicts between stages.
- There will be name conflicts with the `base` (contract) project.
- Each stage is organized in a separate folder, avoiding mass and allowing e ergonomic work.

## Getting Started

Follow the steps below to get the project up and running on your local machine.

### Prerequisites

- Python 3.11
- Docker version 20.10.24 or higher
- Poetry version 1.4.2 or higher

### Installation and Setup

1. Clone the repository:
   ```shell
   git clone https://github.com/GabrielBossardi/dbt-multi-project.git
   ```

2. Navigate to the project directory:
   ```shell
   cd dbt-multi-project
   ```

3. Install the project dependencies using Poetry (inside of a virtual environment):
   ```shell
   poetry install
   ```

4. Start the PostgreSQL container using Docker Compose:
   ```shell
   docker-compose up -d
   ```

5. Set environment variables
   ```shell
   source .env
   ```

### dbt Set Up and Exploration

To explore and analyze the data using dbt, follow these steps:

1. Install parent (base) into child (marketplace_others):
   ```shell
   cd transform/marketplace_others
   dbt deps
   ```

2. Install parent (base) into child (marketplace_sp):
   ```shell
   cd ../marketplace_sp
   dbt deps
   ```

3. Seed the database with initial data in the base project:
   ```shell
   cd ../base
   dbt seed --profiles-dir ../
   ```
Note that, for didactic reasons, the seed tables will be considered as sources and not as models. Therefore, these tables will be referenced with the `source` macro and not with `ref`.

4. Execute all models of "base":
   ```shell
   dbt run --profiles-dir ../
   ```

5. Execute only the models from the "marketplace_others" project:
   ```shell
   cd ../marketplace_others/
   dbt run -s tag:marketplace_others --profiles-dir ../
   ```

6. Execute only the models from the "marketplace_sp" project:
   ```shell
   cd ../marketplace_sp/
   dbt run -s tag:marketplace_sp --profiles-dir ../
   ```

7. Execute all models of "base":
   ```shell
   cd ../base
   dbt test --profiles-dir ../
   ```

8. Generate project documentation:
   ```shell
   dbt docs generate --profiles-dir ../
   ```

9. Generate child project documentation:
   ```shell
   cd ../marketplace_others/
   dbt docs generate --profiles-dir ../
   ```

10. Serve project documentation:
   ```shell
   dbt docs serve 8081 --profiles-dir ../
   ```

11. Explore the projects
Feel free to explore the project and experiment with its features.

## License
This project is licensed under the MIT License. See the LICENSE file for more information.
