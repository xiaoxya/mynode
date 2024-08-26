-- 加载 LuaSQL 模块
local mysql = require "luasql.mysql"

-- 数据库连接信息
local db_config = {
    host = "localhost",
    user = "用户名",
    password = "密码",
    database = "数据库名"
}

-- 连接到数据库
local env = assert(mysql.mysql())
local conn = assert(env:connect(db_config.database, db_config.user, db_config.password, db_config.host))

-- 要插入的数据
local data = {
    name = "张三",
    age = 25,
    city = "北京"
}

-- 构造 SQL 插入语句
local sql = string.format("INSERT INTO users (name, age, city) VALUES ('%s', %d, '%s')",
    conn:escape(data.name), data.age, conn:escape(data.city))

-- 执行 SQL 语句
local cursor, err = conn:execute(sql)

-- 检查是否出错
if not cursor then
    print("插入数据出错: ", err)
else
    print("数据插入成功！")
    cursor:close()
end

-- 关闭数据库连接
conn:close()
env:close()
