# General security principles

In myrtea, most of the security is supported by the internet standard [JSON Web Tokens](https://jwt.io/).

## Authentication process

1. A request is sent (commonly from the frontend) to require a security token (a JWT).
    * This request contains the user credentials, and will lead to a BASIC authentication (hence the usage of HTTPS in production !)
2. This authentication request is processed by the engine-API, which will check the user credentials against a standard user table in postgresql.
3. If the user and his password are correct, a new JWT is generated and sent back to the caller.
4. This JWT is subsequently added to every single request sent to the backend to ensure proper authorization.
    * As the standard require it, the token is inserted a the `Authorization` HTTP header with the value : `Bearer <token>`
5. Every request is then checked by the engine-API to ensure that a JWT is present in the headers, and that this JWT is valid (not tampered, not expired, etc.)
