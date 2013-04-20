local namespace = KEYS[1];
local query     = ARGV[1];
local key       = namespace .. 'match:' .. query;
local matches   = redis.call('zrange', key, 0, 10);

local ret = {};

for index, value in pairs(matches) do
  for val, id in string.gmatch(value, '(.*):([^:]*)') do
    table.insert(ret, { id, val });
  end
end

return ret;
