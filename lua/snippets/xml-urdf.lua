local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s("urdf", {
    t('<robot name="'),
    i(1, "my_robot"),
    t({ '">' }),
    t({ "", "  " }),
    i(0),
    t({ "", "</robot>" }),
  }),

  s("link", {
    t('<link name="'),
    i(1, "link_name"),
    t({ '">' }),
    t({ "", "  " }),
    i(0),
    t({ "", "</link>" }),
  }),

  s("joint", {
    t('<joint name="'),
    i(1, "joint_name"),
    t({ '" type="' }),
    i(2, "revolute"),
    t({ '">' }),
    t({ "", "  " }),
    i(0),
    t({ "", "</joint>" }),
  }),

  s("visual", {
    t({ "<visual>", "  <geometry>", '    <box size="' }),
    i(1, "1 1 1"),
    t({ '"/>', "  </geometry>", "</visual>" }),
  }),
}
