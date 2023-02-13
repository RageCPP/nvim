# about unique_ptr
## create
- make_unique()
- make_unique_for_overwrite() // C++ 20 performance better
```C++
auto mySimpleSmartPtr { make_unique<Simple>() };
```

## use
```C++
mySimpleSmartPtr->go();
// or 
(*mySimpleSmartPtr).go();
```

## underlying pointer from unique_ptr
### get
```C++
mySimpleSmartPtr.get();

void processData(Simple* simple) { /* Use the simple pointer... */ }
processData(mySimpleSmartPtr.get());
```
### free
```C++
mySimpleSmartPtr.reset(); // Free resource and set to nullptr
```
### change
```C++
mySimpleSmartPtr.reset(new Simple{}); // Free resource and set to a new Simple instance
```
### disconnect
You can disconnect the underlying pointer from a unique_ptr with release() which returns the underlying pointer to the resource and then sets the smart pointer to nullptr. Effectively, the smart pointer loses ownership of the resource, and as such, you become responsible for freeing the resource when you are done with it! Here’s an example:
```C++
Simple* simple { mySimpleSmartPtr.release() }; // Release ownership
// Use the simple pointer...
delete simple;
simple = nullptr;
```

## move
Because a unique_ptr represents unique ownership, it cannot be copied! But, spoiler alert, it is possible to move one unique_ptr to another one using move semantics
```C++
class Foo
{
    public:
        Foo(unique_ptr<int> data) : m_data { move(data) } { }
    private:
        unique_ptr<int> m_data;
};
auto myIntSmartPtr { make_unique<int>(42) };
Foo f { move(myIntSmartPtr) };
```

## unique_ptr and C-Style Arrays
- [ ] Professional C++ P285

## Custom Deleters
- [ ] Professional C++ P286

