# API Assignment

## Introduction

The objective of this assignment is to evaluate your knowledge of Ruby on Rails, Git, Design Patterns, Testing, APIs and SQL.

You will build an API for storing DNS records (IP addresses) belonging to a hostname.
Rules and Requirements
- You have to build a new Rails application from scratch
- Your project should be versioned with Git and published in a public repository
- Your first commit should be the Rails scaffold (rails new <project_name>)
- You must use a relational database
- You should write automated tests
- Please spend no more than 4 hours on this assignment. You can spend more time if you like but we value your time. You can share what you have once you hit that limit.

## Project Specification
Your assignment is to build an API with two endpoints. The first endpoint will be used to create DNS records and their associated hostnames. The second endpoint will be used to retrieve these records. You are free to design the API’s structure. The naming of the endpoints and their parameters are not specified, you are free to choose them.

### Endpoint #1
Endpoint #1 creates a DNS record and it’s associated hostnames. This endpoint should accept an IPv4 IP address and a list of hostnames. The response should return the ID of the DNS record created.

### Endpoint #2
Endpoint #2 returns DNS records and their hostnames. This endpoint should accept:
- A list of hostnames the results should include (optional parameter)
- A list of hostnames the results should exclude (optional parameter)
- A page number (required)

The result should contain all DNS records associated with the hostnames to be included, but no DNS records associated with the hostnames to be excluded.

The response body should have:
- The total number of matching DNS records
- An array of matching DNS records
- The ID of the matching DNS record
- The IP address of the matching DNS record
- An array of hostnames associated with the matching DNS records, excluding any hostnames specified in the query
The hostname
- The number of DNS records associated with the hostname

### Example
Assume the following DNS records and hostnames are stored in the database

#####DNS Record 1
- IP: 1.1.1.1
- Hostnames: lorem.com, ipsum.com, dolor.com, amet.com
#####DNS Record 2
- IP: 2.2.2.2
- Hostnames: ipsum.com
#####DNS Record 3
- 3.3.3.3
- Hostnames: ipsum.com, dolor.com, amet.com
#####DNS Record 4
- 4.4.4.4
- Hostnames: ipsum.com, dolor.com, sit.com, amet.com
#####DNS Record 5
- 5.5.5.5
- Hostnames: dolor.com, sit.com

When the API endpoint #2 receives the following query:
- List of hostnames to be included: ipsum.com, dolor.com
- List of hostnames to be excluded: sit.com
- Page: 1

Then the response should have:
- The total number of DNS records: 2
- An array of matching DNS records:
	ID: 1, IP: 1.1.1.1
	ID: 3, IP: 3.3.3.3
- An array of hostnames returned by the search (lorem.com, ipsum.com, dolor.com, amet.com), excluding any hostnames specified in the query (ipsum.com, dolor.com, sit.com)
- Hostname: lorem.com, Number of matching DNS records: 1
- Hostname: amet.com, Number of matching DNS records: 2

# Documentation

## How to run the project

- configure the `database.yml` for your PostgreSQL environment
- bundle install
- rake db:setup
- rails s

## How to use the API

### Create a DNS Record

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

### Search for a DNS record

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
