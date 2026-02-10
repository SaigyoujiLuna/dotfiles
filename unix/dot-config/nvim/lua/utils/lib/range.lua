---@class yukivim.utils.lib.Range
---@field private range Range4 0-based inclusive
local Range = {}
Range.__index = Range

function Range.visual()
  -- get current position
  local _, srow, scol, _ = unpack(vim.fn.getpos("."))
  -- get visual mode end position or current position if not in visual mode
  local _, erow, ecol, _ = unpack(vim.fn.getpos("v"))

  -- 0 based inclusive
  srow = srow - 1
  scol = scol - 1
  erow = erow - 1
  ecol = ecol - 1

  -- range fix
  if srow < erow or (srow == erow and scol <= ecol) then
    return Range.new({ srow, scol, erow, scol })
  else
    return Range.new({ erow, ecol, srow, scol })
  end
end

---@private
---@param range Range4 0-based inclusive
---@return yukivim.utils.lib.Range
function Range.new(range)
  local self = setmetatable({}, Range)
  self.range = range
  return self
end

---@param other yukivim.utils.lib.Range
---@return boolean
function Range:same(other)
  return vim.deep_equal(self.range, other.range)
end

---@return Range4 0-based exclusive
function Range:ts()
  return { self.range[1], self.range[2], self.range[3], self.range[4] + 1 }
end

---@param buf integer
---@param node TSNode
---@return yukivim.utils.lib.Range
function Range.node(buf, node)
  local srow, scol, erow, ecol = node:range()
  -- returned end position is exclusive, so we need to convert it to inclusive
  -- 如果结束位置在下一行的第0列, 则需要将结束行减1，并将结束列设置为该行的最后一个字符的位置
  if ecol == 0 then
    erow = erow - 1
    local line = vim.api.nvim_buf_get_lines(buf, erow, erow + 1, false)[1]
    ecol = math.max(#line, 1)
  end
  -- 0 based
  ecol = ecol - 1
  return Range.new({ srow, scol, erow, ecol })
end

---@return integer[]
function Range:cursor_start()
  -- (0,0)-indexed -> (1,0)-indexed
  ---@type integer[]
  return { self.range[1] + 1, self.range[2] }
end

---@return integer[]
function Range:cursor_end()
  -- (0,0)-indexed -> (1,0)-indexed
  ---@type integer[]
  return { self.range[3] + 1, self.range[4] }
end
return Range
