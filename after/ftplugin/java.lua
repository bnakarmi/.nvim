local nvim_config_path = vim.fn.stdpath "config"
local nvim_data_path = vim.fn.stdpath "data"
local jdtls_path = nvim_data_path .. "/mason/packages/jdtls/"
local path_to_lsp_server = jdtls_path .. "config_win"
local path_to_plugins = jdtls_path .. "plugins/"
-- Check version periodically
--local path_to_jar = vim.fn.glob(path_to_plugins .. "org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar")
local path_to_jar = vim.fn.glob(path_to_plugins .. "org.eclipse.equinox.launcher_*.jar", 1)
-- Add lombok jar to path
local path_to_lombok = jdtls_path .. "lombok.jar"
local path_to_java_dap = nvim_data_path .. "/debug_tools/java-debug/com.microsoft.java.debug.plugin/target/"
local dap_path = vim.fn.glob(path_to_java_dap .. "com.microsoft.java.debug.plugin-*.jar", 1)

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)

if root_dir == "" then
    return
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
-- Update based on OS
local dev_path = "D:/development/"
local dev_tools_path = dev_path .. "tools/"
local workspace_path = dev_path .. "workspace/java/"
local workspace_dir = workspace_path .. project_name

os.execute("mkdir " .. workspace_dir)

local config = {
    cmd = {
        -- Note: Ensure JAVA 17 is set in path or else specify the exact location
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-javaagent:' .. path_to_lombok,
        '-Xms1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', path_to_jar,
        '-configuration', path_to_lsp_server,
        '-data', workspace_dir,
    },
    root_dir = root_dir,
    settings = {
        java = {
            home = dev_tools_path .. "jdk-17.02",
            eclipse = {
                downloadSources = true,
            },
            configuration = {
                updateBuildConfiguration = "interactive",
                runtimes = {
                    {
                        name = "JavaSE-1.8",
                        path = dev_tools_path .. "jdk-1.8"

                    },
                    {
                        name = "JavaSE-11",
                        path = dev_tools_path .. "jdk-11.0.2"

                    },
                    {
                        name = "JavaSE-17",
                        path = dev_tools_path .. "jdk-17.0.2",
                    }
                }
            },
            maven = {
                downloadSources = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            format = {
                enabled = true,
                settings = {
                    url = nvim_data_path .. "/code_styles/java-google-style.xml",
                    profile = "GoogleStyle",
                },
            },

        },
        signatureHelp = { enabled = true },
        completion = {
            favoriteStaticMembers = {
                "org.hamcrest.MatcherAssert.assertThat",
                "org.hamcrest.Matchers.*",
                "org.hamcrest.CoreMatchers.*",
                "org.junit.jupiter.api.Assertions.*",
                "java.util.Objects.requireNonNull",
                "java.util.Objects.requireNonNullElse",
                "org.mockito.Mockito.*",
            },
            importOrder = {
                "java",
                "javax",
                "com",
                "org"
            },
        },
        extendedClientCapabilities = extendedClientCapabilities,
        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
            },
        },
        codeGeneration = {
            toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
            useBlocks = true,
        },
    },
    flags = {
        allow_incremental_sync = true,
    },
    init_options = {
        bundles = {
            vim.fn.glob(path_to_java_dap .. "com.microsoft.java.debug.plugin-*.jar", 1)
        },
    },
}

config['on_attach'] = function(client, bufnr)
    require('core.remap').map_java_lsp_keys(bufnr)
    require('lsp_signature').on_attach({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        floating_window_above_cur_line = false,
        padding = '',
        handler_opts = {
            border = "rounded"
        }
    }, bufnr)
    require("jdtls").setup_dap({ hotcodereplace = "auto" })

    vim.lsp.codelens.refresh()
end

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)
