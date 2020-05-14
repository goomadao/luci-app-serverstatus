require("luci.sys")
require("luci.sys.zoneinfo")
require("luci.tools.webadmin")
require("luci.config")
require("luci.util")
require("luci.cbi.datatypes")
require("luci.http")

local m, s, o

m =
    Map(
    "ServerStatus",
    translate("ServerStatus"),
    translate("A server monitor.")
)
m:chain("luci")

m:section(SimpleSection).template="ServerStatus/ServerStatus_status"

s = m:section(NamedSection, "common", "ServerStatus", translate("Global Settings"))
s.anonymous = true
s.addremove = false

s:tab("base",translate("Basic Settings"))
s:tab("log",translate("Log"))

enable=s:taboption("base", Flag, "enable", translate("Enable"))
enable.rmempty=false
enable.default=0

server = s:taboption("base", Value, "server", translate("server"), translate("The domain or IP address of your server."))
server.rmempty=false

port = s:taboption("base", Value, "port", translate("port"), translate("The port of your server to receive data."))
port.rmempty=false
port.datatype = "port"
port.default=36580

name = s:taboption("base", Value, "name", translate("name", translate("The name of your device.")))
name.rmempty=false

location = s:taboption("base", Value, "location", translate("location"), translate("The location of your device."))
location.rmempty=false

key = s:taboption("base", Value, "key", translate("key"), translate("Password to connect to your server."))
key.password=true
key.rmempty=false

log = s:taboption("log", TextValue, "log")
log.rows=26
log.wrap="off"
log.readonly=true
log.cfgvalue=function (t, t)
    return nixio.fs.readfile("/var/etc/ServerStatus.log") or ""
end

local apply = luci.http.formvalue("cbi.apply")
if apply then
    io.popen("/etc/init.d/ServerStatus restart")
end

return m
