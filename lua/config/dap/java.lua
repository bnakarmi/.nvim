local M = {}

function M.setup()
    local dap = require("dap")

    dap.configurations["java"] = {
        {
            type = "java",
            request = "attach",
            name = "Attach to the process",
            hostName = "localhost",
            port = "5005",
        },
    }

    dap.continue()
end

return M
