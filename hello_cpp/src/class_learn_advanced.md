# ADVANCED CLASS

## Friends
```C++
class Foo {
    friend class Bar;
}
```
Now all the methods of `Bar` can access the `private` and `protected` data members and methods of `Foo`;

```C++
class Foo {
    friend void Bar::processFoo(const Foo&);
}
```
make a specific method of `Bar` be a friend of `Foo`;

```C++
class Foo {
    friend void printFoo(const Foo&);
}

// printFoo function definition outside the Foo class
void printFoo(const Foo& foo) {
    ... ...
}
```
Stand-alone functions can also be friends of classes.

## DYNAMIC MEMORY ALLOCATION IN OBJECTS

