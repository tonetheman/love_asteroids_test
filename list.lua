

local Object = require("classic")

local List = Object:extend()
function List:new()
    List.super.new(self)
    self.pos = 1
end
function List:add(val)
    self[self.pos] = val
    self.pos = self.pos + 1
end
function List:get(i)
    return self[i]
end
function List:remove(val)
    for i=1,self.pos do
        if self[i] == val then
            -- remove the item
            table.remove(self,i)
        end
    end
end

return List