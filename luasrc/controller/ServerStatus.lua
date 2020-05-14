module("luci.controller.ServerStatus", package.seeall)

function index()
    entry({"admin","services","ServerStatus"},cbi("ServerStatus"),_("ServerStatus"),90).dependent=true
    entry({"admin","services","ServerStatus","status"},call("status")).leaf=true
end

function status()
    local e={}
    e.running=luci.sys.call("pidof serverstatus > /dev/null")==0
    luci.http.prepare_content("application/json")
    luci.http.write_json(e)
end