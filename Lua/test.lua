local luasql = require "luasql.odbc"

-- 创建环境对象
local env = assert(luasql.odbc())

-- 连接字符串
local connection_string =
"Driver={SQL Server};Server=YourServerName;Database=YourDatabaseName;Uid=YourUsername;Pwd=YourPassword;"

-- 连接到数据库
local conn = assert(env:connect(connection_string))

-- 执行SQL查询
local cur = assert(conn:execute("SELECT * FROM YourTable"))

-- 获取结果
local row = cur:fetch({}, "a")
while row do
    print(string.format("ID: %s, Name: %s", row.ID, row.Name))
    row = cur:fetch(row, "a")
end

-- 关闭连接
cur:close()
conn:close()
env:close()
