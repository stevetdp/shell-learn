### 使用golang 访问数据库的实践建议

1. struct中的字段类型最好是sql中的Null类型，比如：sql.NullString， 避免DB中的已有数据是null，在进行转化时出现错误。
2. 如果是自定义的类型，需要实现Scaner接口。 如果执行Exec，自定义类型必须实现Value接口类型。
3. 自定义类型，如果在生成JSON上有特殊要求，建议实现MarshalJSON和UnmarshalJSON接口

### 参考：

1. https://golang.org/pkg/database/sql/#Rows.Scan
