-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4 -- insert 4 spaces for a tab
vim.opt.relativenumber = true -- relative line numbers

lvim.keys.normal_mode["<C-t>"] = ":NvimTreeToggle<CR>"

-- https://www.reddit.com/r/neovim/comments/p9wjg3/cloudformation_with_nvim_lsp/
require'lspconfig'.yamlls.setup{
    settings = {
        yaml = {
            format = {
                    enable = true,
            },
            hover = true,
            completion = true,
            customTags = {
            	"!fn",
        	    "!And",
        	    "!If",
        	    "!Not",
        	    "!Equals",
        	    "!Or",
        	    "!FindInMap sequence",
        	    "!Base64",
        	    "!Cidr",
        	    "!Ref",
        	    "!Ref Scalar",
        	    "!Sub",
        	    "!GetAtt",
        	    "!GetAZs",
        	    "!ImportValue",
        	    "!Select",
        	    "!Split",
        	    "!Join sequence",
            },
        },
    },
}

local null_ls = require('null-ls')
local null_helpers = require('null-ls.helpers')

local cfn_lint = {
    method = null_ls.methods.DIAGNOSTICS,
    filetypes = {'yaml'},
    generator = null_helpers.generator_factory({
        command = "cfn-lint",
        to_stdin = true,
        to_stderr = true,
        args = { "--format", "parseable", "-" },
        format = "line",
        check_exit_code = function(code)
        return code == 0 or code == 255
        end,
        on_output = function(line, params)
        local row, col, end_row, end_col, code, message = line:match(":(%d+):(%d+):(%d+):(%d+):(.*):(.*)")
        local severity = null_helpers.diagnostics.severities['error']

        if message == nil then
            return nil
        end

        if vim.startswith(code, "E") then
            severity = null_helpers.diagnostics.severities['error']
        elseif vim.startswith(code, "W") then
            severity = null_helpers.diagnostics.severities['warning']
        else
            severity = null_helpers.diagnostics.severities['information']
        end

        return {
            message = message,
            code = code,
            row = row,
            col = col,
            end_col = end_col,
            end_row = end_row,
            severity = severity,
            source = "cfn-lint",
        }
        end,
    })
}

null_ls.register({
    sources = {
        cfn_lint,
    }
})
