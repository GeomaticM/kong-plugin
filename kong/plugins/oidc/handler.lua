local BasePlugin = require "kong.plugins.base_plugin"
local access = require "kong.plugins.oidc.access"

local OIDCHandler = BasePlugin:extend()

OIDCHandler.PRIORITY = 1006
OIDCHandler.VERSION = "0.1.0"

function OIDCHandler:new()
  OIDCHandler.super.new(self, "oidc")
end

function OIDCHandler:access(conf)
  OIDCHandler.super.access(self)
  access.execute(conf)
end

return OIDCHandler
