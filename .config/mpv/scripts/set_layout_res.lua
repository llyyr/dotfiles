local mp = require 'mp'

local group_tags = { "SubsPlease", "Erai-raws" }

local function is_cr()
    local filename = mp.get_property_native("filename")
    if not filename then return false end
    local cur_tag = filename:match("^%[(.-)%]")
    for i=1, #group_tags do
        if cur_tag == group_tags[i] then
            return true
        end
    end
    return false
end

local function update_layout_res()
    if not is_cr() then return end
    local extradata = mp.get_property_native("sub-ass-extradata")
    if not extradata then return end
    local playres_x = extradata:match("PlayResX:%s*(%d+)")
    local playres_y = extradata:match("PlayResY:%s*(%d+)")

    if playres_x and playres_y then
        local override = string.format("LayoutResX=%s,LayoutResY=%s", playres_x, playres_y)
        mp.set_property("sub-ass-style-overrides", override)
        mp.msg.verbose(string.format("Setting %s", override))
    end
end

mp.register_event("file-loaded", update_layout_res)
