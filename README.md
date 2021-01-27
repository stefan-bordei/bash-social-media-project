# Social media client-server system


## Usage

**`server.sh`** needs to be run in one terminal and users can send request using **`client.sh`**. Multiple users can access the server simultaneously.

## Create user

**`./create.sh userName`**

Creates a new user with the `userName` name.

## Add friend

**`./add.sh userName1 userName2`**

Adds `userName1` to `userName2`'s friends list.

## Post message

**`./post.sh userName1 userName2 "msg"`**

`userName2` posts `msg` to `userName1`'s wall. 

## Display wall

**`./show.sh userName`**

Displays all the messages posted on `userName1`'s wall.

## Server

**`./server.sh`**

Starts the server.

## Client

**`./client.sh clientId1 [help|create|add|post|show|shutdown] args`**

Users can "connect" to the server with a `clientId` and can send create, add, post, show requests. 
