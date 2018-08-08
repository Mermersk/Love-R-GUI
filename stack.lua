--A stack implementation
--Stack table is the table contaning stack functions, s is the stack table

stack = {}
stack_mt = {__index = stack} --Metatable to table s, its index points to the stack table
function stack:create() --Functions inside of table stack
  local s = {} --New object/table, is only accesible to 1 instance
  setmetatable(s, stack_mt) --set stack_mt to be metatable of s
  return s
end

function stack:push(object) --The colon here is syntax sugar for the function below:
  table.insert(self, 1, object) --The self here is refering to the current instance of the table s
end

--function stack.push(self, object)
  --table.insert(self, 1, object)
--end

function stack:peek()
  print(self[1]) --The self here is refering to the current instance of the table s
  return self[1]
end


function stack:pop()
  local obj = self[1]
  table.remove(self, 1)
  return obj
end

function stack:size()
  print(#self)
  return #self
end

function stack:toTable()
  return self
end
