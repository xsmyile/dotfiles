local function color_swatch(ctx)
  if ctx.item.source_name ~= "LSP" then
    return nil
  end
  return require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
end

return {
  "saghen/blink.cmp",
  version = "1.*",
  lazy = true,
  dependencies = { "rafamadriz/friendly-snippets" },
  opts = {
    keymap = {
      preset = "default",
      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    },
    completion = {
      list = { selection = { preselect = false, auto_insert = false } },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 0,
        window = {
          border = "rounded",
          winhighlight = "Normal:NormalFloat,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:NormalFloat",
        },
      },
      menu = {
        border = "rounded",
        winhighlight = "Normal:NormalFloat,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
        draw = {
          components = {
            kind_icon = {
              text = function(ctx)
                local swatch = color_swatch(ctx)
                local icon = ctx.kind_icon
                if swatch and swatch.abbr ~= "" then
                  icon = swatch.abbr
                end
                return icon .. ctx.icon_gap
              end,
              highlight = function(ctx)
                local swatch = color_swatch(ctx)
                if swatch and swatch.abbr_hl_group then
                  return swatch.abbr_hl_group
                end
                return "BlinkCmpKind" .. ctx.kind
              end,
            },
          },
        },
      },
    },
  },
}
