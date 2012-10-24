local variants = {}

local function reverse(arr, length)
  local result = {}
  for i=1, length do result[i] = arr[length-i+1] end
  return result, length
end

function variants.ancestry(locale)
  local result, length, accum = {},0,nil
  locale:gsub("[^%-]+", function(c)
    length = length + 1
    accum = accum and (accum .. '-' .. c) or c
    result[length] = accum
  end)
  return reverse(result, length)
end

function variants.root(locale)
  return locale:match("[^%-]+")
end

return variants
