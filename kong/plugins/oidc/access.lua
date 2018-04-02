local http = require("resty.http")

local ngx_get_headers = ngx.req.get_headers

local _M = {}

local function authenticate(conf)
	local client = http.new()
	
end

function _M.execute(conf)
	local headers = ngx_get_headers()
	local token = headers["authorization"]
  if not token then
  	authenticate(conf)
  end 
end

return _M