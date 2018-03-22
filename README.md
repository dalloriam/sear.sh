# Sear.sh

## Description
Sear.sh is a distributed NoSQL database (because it's 2018) written in bash (for performance, maintainability, and readability) distributed via docker (because _containers_).

## Installation
### Docker
```shell
$ docker pull dalloriam/sear.sh
$ docker run --rm -it -p 1500:1500 dalloriam/sear.sh
```
### Standalone
```shell
$ ./sear.sh
```

## Quickstart
### Insert a document
#### Request
```
GET localhost:1500/put/<DocumentBody>
```
#### Response
```
<ItemID>
```

### Retrieve a document
#### Request
```
GET localhost:1500/get/<ItemID>
```
#### Response
```
<DocumentBody>
```

### Search
#### Request
```
GET localhost:1500/sch/<Query>
```

#### Response
```
==> <DocumentID1> <==
<DocumentBody1>

==> <DocumentID2> <==
<DocumentBody2>
``` 

## Distributed Configuration
Simply mount the same volume on the `/data` directory of your `Sear.sh` containers. Nothing bad could ever come from that, right?.
