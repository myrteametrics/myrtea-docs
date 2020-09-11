# Troubleshooting

## Login doesn't work on the web application

* Check in postgres if the user has been properly created
* Check in postgers if the user password is correct with
  * `SELECT count(id) FROM users_v1 WHERE login = '<user_login>' AND (password=crypt('<user_password>', password));`
* Check if the API's have been started with `API_ENABLE_CORS = true`
* Check if both the web application and the backend are using the same API version
