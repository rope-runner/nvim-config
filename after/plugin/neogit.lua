local neogit = require('neogit')

neogit.setup({
    disable_hint = false,
    disable_context_highlighting = false,
    disable_signs = false,
    disable_insert_on_commit = "auto",
    filewatcher = {
        interval = 1000,
        enabled = true,
    },
    graph_style = "ascii",
    git_services = {
        ["github.com"] = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
        ["bitbucket.org"] = "https://bitbucket.org/${owner}/${repository}/pull-requests/new?source=${branch_name}&t=1",
        ["gitlab.com"] = "https://gitlab.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}",
    },
    telescope_sorter = function()
        return require("telescope").extensions.fzf.native_fzf_sorter()
    end,
    remember_settings = true,
    use_per_project_settings = true,
    ignored_settings = {
        "NeogitPushPopup--force-with-lease",
        "NeogitPushPopup--force",
        "NeogitPullPopup--rebase",
        "NeogitCommitPopup--allow-empty",
        "NeogitRevertPopup--no-edit",
    },
    highlight = {
        italic = true,
        bold = true,
        underline = true
    },
    use_default_keymaps = true,
    auto_refresh = true,
    sort_branches = "-committerdate",
    kind = "tab",
    disable_line_numbers = true,
    console_timeout = 2000,
    auto_show_console = true,
    status = {
        show_head_commit_hash = true,
        recent_commit_count = 10,
        HEAD_padding = 10,
        mode_padding = 3,
        mode_text = {
            M = "modified",
            N = "new file",
            A = "added",
            D = "deleted",
            C = "copied",
            U = "updated",
            R = "renamed",
            DD = "unmerged",
            AU = "unmerged",
            UD = "unmerged",
            UA = "unmerged",
            DU = "unmerged",
            AA = "unmerged",
            UU = "unmerged",
            ["?"] = "",
        },
    },
    commit_editor = {
        kind = "auto",
        show_staged_diff = true,
        staged_diff_split_kind = "split"
    },
    commit_select_view = {
        kind = "tab",
    },
    commit_view = {
        kind = "vsplit",
        verify_commit = vim.fn.executable("gpg") == 1,
    },
    log_view = {
        kind = "tab",
    },
    rebase_editor = {
        kind = "auto",
    },
    reflog_view = {
        kind = "tab",
    },
    merge_editor = {
        kind = "auto",
    },
    tag_editor = {
        kind = "auto",
    },
    preview_buffer = {
        kind = "split",
    },
    popup = {
        kind = "split",
    },
    signs = {
        hunk = { "", "" },
        item = { ">", "v" },
        section = { ">", "v" },
    },
    integrations = {
        telescope = true,
        diffview = true,
        fzf_lua = nil,
    },
    sections = {
        sequencer = {
            folded = false,
            hidden = false,
        },
        untracked = {
            folded = false,
            hidden = false,
        },
        unstaged = {
            folded = false,
            hidden = false,
        },
        staged = {
            folded = false,
            hidden = false,
        },
        stashes = {
            folded = true,
            hidden = false,
        },
        unpulled_upstream = {
            folded = true,
            hidden = false,
        },
        unmerged_upstream = {
            folded = false,
            hidden = false,
        },
        unpulled_pushRemote = {
            folded = true,
            hidden = false,
        },
        unmerged_pushRemote = {
            folded = false,
            hidden = false,
        },
        recent = {
            folded = true,
            hidden = false,
        },
        rebase = {
            folded = true,
            hidden = false,
        },
    },
    disable_builtin_notifications = true,
})
