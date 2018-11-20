# API Assignment

## Introduction

The objective of this assignment is to evaluate your knowledge of Ruby on Rails, Git, Design Patterns, Testing, APIs and SQL.

## Documentation

### How to run the project

- configure the `database.yml` for your PostgreSQL environment
- bundle install
- rake db:setup
- rails s

### How to use the API

#### Create a DNS Record

```
POST /dns
Content-Type: application/json

{
  "dns": {
    "ip": "1.1.1.1 ",
    "domains": ["lorem.com", "ipsum.com", "dolor.com", "amet.com"]
  }	
}
```

#### Search for a DNS record

```
GET /dns?page=1&include[]=ipsum.com&include[]=dolor.com&exclude[]=sit.com
```

Result example:
```
{
  "records": 1,
  "domains": [
    {
      "id": 4,
      "ip": "1.1.1.1 ",
      "domains": [
        "lorem.com",
        "ipsum.com",
        "dolor.com",
        "amet.com"
      ]
    }
  ]
}
```
