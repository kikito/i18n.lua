local i18n = {}
local store

-- private stuff

local function dotSplit(str)
  if type(str) ~= 'string' then return {str}, 1 end
  local fields, length = {},0
  str:gsub("[^%.]+", function(c)
    length = length + 1
    fields[length] = c
  end)
  return fields, length
end

local function addElements(destination, length, elements, eLength)
  for i=1, eLength do
    destination[length + i] = elements[i]
  end
  return length + eLength
end

local function splitArgs(...)
  local args, result, length = {...}, {}, 0
  local fields, fLength
  for _,str in ipairs(args) do
    fields, fLength = dotSplit(str)
    length = addElements(result, length, fields, fLength)
  end
  return result, length
end

local function subArray(source, start, finish)
  local result, length = {}, finish - start + 1
  for i=1,length do
    result[i] = source[start + i - 1]
  end
  return result
end

-- public stuff

function i18n.set(...)
  local node, args, length = store, splitArgs(...)
  for i=1, length-2 do
    key = args[i]
    node[key] = node[key] or {}
    node = node[key]
  end
  local lastKey, value = args[length-1], args[length]
  node[lastKey] = value
end

function i18n.get(...)
  local node, args, length = store, splitArgs(...)
  local i = 1
  while i < length do
    node = node[args[i]]
    if type(node) == 'string' then break end
    if not node then return nil end
    i = i + 1
  end
  if i < length then
    return node:format(unpack(subArray(args, i+1, length)))
  else
    return node[args[length]]
  end
end

function i18n.reset()
  store = {}
end

setmetatable(i18n, {__call = function(_,...) return i18n.get(...) end})

i18n.reset()

return i18n
