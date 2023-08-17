config = function()
      require("trouble").setup({
          icons = true,
           signs = {
     --    icons / text used for a diagnostic
        error = "",
        warning = "",
        hint = "",
        information = "",
        other = "",
      },
       use_diagnostic_signs = true
      })
end

