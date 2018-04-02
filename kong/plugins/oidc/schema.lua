return {
  fields = {
    auth_url = { required = true, type = "url", default = "http://localhost:9000/oauth2/auth" },
    token_url = { required = true, type = "url", defalt = "http://ory-hydra-example--hydra:4444/oauth2/token" },
    client_id = { required = true, type = "string", default = "gateway"},
    client_secret = { required = true, type = "string", default = "gateway_secret" },
    scopes = { required = false, type = "array" },
    accept_http_if_already_terminated = { required = false, type = "boolean", default = false },
    auth_header_name = {required = false, type = "string", default = "authorization"}
  }
}