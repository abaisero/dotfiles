return {
  'nvim-neorg/neorg',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-neorg/neorg-telescope',
  },
  ft = 'norg',
  build = ':Neorg sync-parsers',
  opts = {
    load = {
      ['core.defaults'] = {},
      ['core.concealer'] = {},
      ["core.integrations.telescope"] = {}, -- Enable the telescope module
      ['core.dirman'] = {
        config = {
          workspaces = {
            main = '~/neorg',
          },
        },
      ["core.completion"] = {
          config = {
              engine = "nvim-cmp"
          }
        },
      },
    },
  },
}

-- require('neorg').setup {
--     -- Tell Neorg what modules to load
--     load = {
--         ["core.defaults"] = {}, -- Load all the default modules
--         -- ["core.gtd.base"] = {
--         --     config = {
--         --         displayers = {
--         --             projects = {
--         --                 show_completed_projects = true,
--         --                 show_projects_without_tasks = false,
--         --                 },
--         --             },
--         --         workspace = "home"
--         --         },
--         --     }, -- Load `getting things done` module
--         -- ["core.norg.concealer"] = {}, -- Allows for use of icons
--         ["core.concealer"] = {}, -- Allows for use of icons
--         ["core.integrations.telescope"] = {}, -- Enable the telescope module
--         ["core.dirman"] = { -- Manage your directories with Neorg
--         -- ["core.norg.dirman"] = { -- Manage your directories with Neorg
--         config = {
--             workspaces = {
--                 home = "~/neorg",
--                 }
--             }
--         },
--     -- ["core.norg.completion"] = {
--     ["core.completion"] = {
--         config = {
--             engine = "nvim-cmp"
--         }
--     },
--   },
-- }
