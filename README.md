# ranklist

Description
-----------

该解决方案潜在问题:

- 数据规模较大时, 可考虑换一种存储结构 (ex: bitmap);
- 数据规模较大时, `print` 可能存在瓶颈; 可考虑分段并行处理, 聚合时, 还需要考虑不同分段的段头段尾的区间聚合处理;

Testing
-------

``` ruby
bundle exec rake test
```