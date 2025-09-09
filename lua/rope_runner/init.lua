require("rope_runner.remap")
require("rope_runner.packer")
require("rope_runner.set")
require("rope_runner.autoimport")
require("rope_runner.marks_manager")

vim.opt.termguicolors = true

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  severity_sort = true,
})

vim.api.nvim_create_user_command("ReplaceInFile", function(opts)
    local args = vim.split(opts.args, " ")

    if #args < 2 then
        print("Usage :ReplaceInFile <target> <replacement>")
        return
    end

    local target, replacement = args[1], args[2]
    vim.cmd(string.format("%%s/%s/%s/g", vim.fn.escape(target, "/"), vim.fn.escape(replacement, "/")))
end, { nargs = "+" })

vim.api.nvim_create_user_command("ReplaceInProject", function(opts)
    local args = vim.split(opts.args, " ")
    if #args < 2 then
        print("Usage: :ReplaceInProject <target> <replacement>")
        return
    end
    local target, replacement = args[1], args[2]

    local sed_inplace = "sed -i"
    if vim.fn.has("mac") == 1 then
        sed_inplace = "sed -i ''"
    end

    local cmd = string.format(
        [[rg --null -l %s | xargs -0 %s 's/%s/%s/g']],
        vim.fn.shellescape(target),
        sed_inplace,
        vim.fn.escape(target, "/"),
        vim.fn.escape(replacement, "/")
    )

    local output = vim.fn.system(cmd)
    if vim.v.shell_error == 0 then
        print("Replaced '" .. target .. "' with '" .. replacement .. "' across project.")
    else
        print("Replace failed: " .. output)
    end
end, { nargs = "+" })

--vim.keymap.set("n", "<leader>m", function() require("rope_runner.marks_manager").open() end, { desc = "Open Marks Manager" })
--vim.api.nvim_create_user_command("Marks", function() require("rope_runner.marks_manager").open() end, {})
