# about shared_ptr
## create
- make_shared_for_overwrite()  // C++ 20
```C++
auto mySimpleSmartPtr { make_shared<Simple>() };
```
## get() reset() like unique_ptr
The only difference is that when calling reset(), the underlying resource is freed only when the last shared_ptr is destroyed or reset.

## use_count()
You can use the use_count() method to retrieve the number of shared_ptr instances that are sharing the same resource.

## custom delete
- [ ] Professional C++ P287

## casting a shared_ptr
- `const_pointer_cast()` like non-smart pointer casting `const_cast()`
- `dynamic_pointer_cast()` like non-smart pointer casting `dynamic_cast()`
- `static_pointer_cast()` ... `static_cast()`
- `reinterpret_pointer_cast()` ... `reinterpret_cast()`

## Aliasing
当你需要返回对象中部分成员的引用时，这会增加Foo的共享引用计数，只有当`foo`与`aliasing`都被回收时，Foo对象实例才会被回收。

但是需要注意引用生命周期的问题。生命周期短的部分不可访问生命周期长的部分
```C++
class Foo
{
    public:
        Foo(int value) : m_data { value } { }
        int m_data;
};
auto foo { make_shared<Foo>(42) };
auto aliasing { shared_ptr<int> { foo, &foo->m_data } };
```
