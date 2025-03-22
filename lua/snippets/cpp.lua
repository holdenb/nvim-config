local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s("getter", {
    t({ "", "public:" }),
    t({ "", "    " }),
    i(1, "Type"),
    t(" get"),
    i(2, "VarName"),
    t("() const { return "),
    i(2, "VarName"),
    t("; }"),
  }),

  s("setter", {
    t({ "", "public:" }),
    t({ "", "    void set" }),
    i(2, "VarName"),
    t("("),
    i(1, "Type"),
    t(" value) { "),
    i(2, "VarName"),
    t(" = value; }"),
  }),
}
