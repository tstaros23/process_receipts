# Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

What things you need to install the software and how to install them:

- [Docker](https://docs.docker.com/)
### Installing

#### 1. Clone the repository

```
git clone git@github.com:tstaros23/process_receipts.git && cd process_receipts
```
#### 2. Build the project

```
docker-compose build
```
#### 3. Start the server

```
docker-compose up
```

## Running the tests

You can run all the specs using the following command:

```
docker exec -it process_receipts rspec
```
If you want to run a single spec, use the following pattern:

```
docker exec -it process_receipts rspec spec/requests/receipt_request_spec.rb
```
## Checking the logs

You can check the development logs using the following command:

```
docker exec -it process_receipts tail -f log/development.log
```

If you want to check the test logs, you'll need to use the following command:

```
docker exec -it process_receipts tail -f log/test.log
