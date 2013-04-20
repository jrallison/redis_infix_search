local namespace = KEYS[1];
local id        = ARGV[1];
local value     = ARGV[2];
local infixes   = {};

local previous = redis.call('hget', namespace .. 'indexed', id);

if previous then
  for len = 3, #previous do
    for index = 1, #previous - len + 1 do
      local infix = string.sub(previous, index, index + len - 1);
      local key   = namespace .. 'match:' .. infix;

      redis.call('zrem', key, previous .. ':' .. id);
    end
  end
end

redis.call('hset', namespace .. 'indexed', id, value);

for len = 3, #value do
  for index = 1, #value - len + 1 do
    local infix = string.sub(value, index, index + len - 1);
    local key   = namespace .. 'match:' .. infix;
    local score;

    table.insert(infixes, infix);

    if value == infix then
      score = 1;
    elseif string.sub(value, 1, #infix) == infix then
      score = 2;
    else
      score = 3;
    end

    redis.call('zadd', key, score, value .. ':' .. id);
  end
end

return infixes;
