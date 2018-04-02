local http = require("resty.http")
local responses = require "kong.tools.responses"

local ngx_get_headers = ngx.req.get_headers
local url_encode = ngx.escape_uri

local _M = {}

function _M.execute(conf)
	local headers = ngx_get_headers()
	local token = headers["authorization"]
  if not token then
  	return responses.send(401, "未授权用户，请先登录")
  end 
end

return _M