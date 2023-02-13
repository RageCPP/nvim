# Class

## Class Members
- member function (which in turn is a method, constructor, or destructor)
- member variable (also called a data member)
- member enumerations
- type aliases
- nested classes
### member function
- declare member function that do not change object as `const`
    ```C++
    double getValue() const;
    ```

## Access Control
access specifiers:
- `private`
- `public`
- `protected`

`class` default access specifiers is `private`.   
`struct` default access specifiers is `public`.

```C++
class Man {
    public:
        void setAge(unsigned short value);
        unsigned short getAge() const;
    private:
        unsigned short age;
}
```

## In-Class Member Initializers
```C++
export class SpreadsheetCell {
    // Remainder of the class definition omitted for brevity
    private:
        double m_value { 0 };
};
```

## Using Object

### Object on the stack
```C++
SpreadsheetCell myCell, anotherCell;
myCell.setValue(6);
anotherCell.setString("3.2");
cout << "cell 1: " << myCell.getValue() << endl;
cout << "cell 2: " << anotherCell.getValue() << endl;
```

### Object on the Free Store
```C++
SpreadsheetCell* myCellp { new SpreadsheetCell { } };
myCellp->setValue(3.7);
cout << "cell 1: " << myCellp->getValue() << " " << myCellp->getString() << endl;
delete myCellp;
myCellp = nullptr; // 非必要但有助于后期调试

// 对于分配在堆上的对象优先考虑使用智能指针管理内存 而非原始的手动管理内存

auto myCellp { make_unique<SpreadsheetCell>() }; // Equivalent to: unique_ptr<SpreadsheetCell> myCellp { new SpreadsheetCell { } };
myCellp->setValue(3.7);
cout << "cell 1: " << myCellp->getValue() << " " << myCellp->getString() << endl;
```

## Object Life Cycles

### Object Creation

#### Constructor
C++ programmers sometimes call a constructor a ctor (pronounced “see-tor”).

```C++
export class SpreadsheetCell {
    public:
        SpreadsheetCell(double initialValue); // constructor never has a return type and may or may not have parameters
};

// implementations
SpreadsheetCell::SpreadsheetCell(double initialValue) {
    setValue(initialValue);
}
```
##### Multiple Constructor
different constructors must take a different number of arguments or different argument types. --- `overloading`
```C++
export class SpreadsheetCell {
    public:
        SpreadsheetCell(double initialValue);
        SpreadsheetCell(std::string_view initialValue);
};

// use
SpreadsheetCell aThirdCell { "test" }; // Uses string-arg ctor
SpreadsheetCell aFourthCell { 4.4 }; // Uses double-arg ctor
```
When you have multiple constructors, it is tempting to try to implement one constructor in terms of another.
```C++
SpreadsheetCell::SpreadsheetCell(string_view initialValue) {
    SpreadsheetCell(stringToDouble(initialValue));
}
```

##### Default Constructor (zero-argument constructor)
A constructor that can be called without any arguments is called a `default constructor`. This can be a constructor that does not have any parameters, or a constructor for which all parameters have default values.
```C++
// definition with a default constructor
export class SpreadsheetCell {
    public:
        SpreadsheetCell();
};

// implementation of the default constructor
SpreadsheetCell::SpreadsheetCell() {
    m_value = 0; // If you use an in-class member initializer for m_value, then the single statement in this default constructor can be left out.
}

// use default constructor on the stack
SpreadsheetCell myCell; // or SpreadsheetCell myCell { }; don't use SpreadsheetCell myCell(); 原因见 Professional C++ P309
myCell.setValue(6);
cout << "cell 1: " << myCell.getValue() << endl;

// use default constructor on the store-based
auto smartCellp { make_unique<SpreadsheetCell>() };
// Or with a raw pointer (not recommended)
SpreadsheetCell* myCellp { new SpreadsheetCell { } };
// Or
// SpreadsheetCell* myCellp { new SpreadsheetCell };
// Or
// SpreadsheetCell* myCellp{ new SpreadsheetCell() };
// ... use myCellp
delete myCellp; myCellp = nullptr;
```

###### Compiler-generated Constructor
If you haven’t defined your own constructors, the compiler automatically creates a default constructor for you. 

###### Explicitly Defaulted and Deleted default constructors
To avoid having to write empty default constructors manually, C++ supports the concept of `explicitly defaulted default constructors` by using `default` keyword.
```C++
export class SpreadsheetCell {
    public:
        SpreadsheetCell() = default; // Note that you are free to put the = default either directly in the class definition or in the implementation file.
        SpreadsheetCell(double initialValue);
        SpreadsheetCell(std::string_view initialValue);
        // Remainder of the class definition omitted for brevity
};
```
The opposite of explicitly defaulted default constructors is also possible and is called `explicitly deleted default constructors` by using `delete` keyword. tell the compiler don't generate the default constructor.
```C++
export class MyClass {
    public:
    MyClass() = delete;
};
```

##### Delegating Constructors
`Delegating constructors` allow constructors to call another constructor from the same class. However, this call cannot be placed in the constructor body; it must be in the `ctor-initializer`, and it must be the only `member-initializer` in the list.
```C++
SpreadsheetCell::SpreadsheetCell(string_view initialValue)
 : SpreadsheetCell { stringToDouble(initialValue) } {
}
// use
class MyClass {
    MyClass(char c) : MyClass { 1.2 } { }
    MyClass(double d) : MyClass { 'm' } { }
};
```
The first constructor delegates to the second constructor, which delegates back to the first one. The behavior of such code is undefined by the standard and depends on your compiler.

##### Copy Constructors
```C++
// declaration
export class SpreadsheetCell {
    public:
        SpreadsheetCell(const SpreadsheetCell& src);
};
// implementation
SpreadsheetCell::SpreadsheetCell(const SpreadsheetCell& src)
 : m_value { src.m_value } {
}
```
If you don’t write a copy constructor yourself, C++ generates one for you that initializes each data member in the new object from its equivalent data member in the source object. Therefore, in most circumstances, there is no need for you to specify a copy constructor!

[The default semantics for passing arguments to functions in C++ is pass-by-value. That means that the function or method receives a copy of the value or object.Thus, whenever you pass an object to a function or method, the compiler calls the copy constructor of the new object to initialize it.](#)

[When returning objects by value from a function, the copy constructor might also get called. This is discussed in the section “Objects as Return Values” later in this chapter](#)

###### Explicitly Defaulted and Deleted Copy Constructors
```C++
SpreadsheetCell(const SpreadsheetCell& src) = default;
// or
SpreadsheetCell(const SpreadsheetCell& src) = delete;
```
[Note](#): If a class has data members that have a deleted copy constructor, then the copy constructor for the class is automatically deleted as well.

#### Use Constructor
You can use constructors with both stack-based and free store-based allocation.

##### Constructors for Objects on the stack
```C++
SpreadsheetCell myCell { 5 }, anotherCell { 4 };
cout << "cell 1: " << myCell.getValue() << endl;
cout << "cell 2: " << anotherCell.getValue() << endl;
```
##### Constructors for Objects on the Free Store
```C++
auto smartCellp { make_unique<SpreadsheetCell>(4) }; // ... do something with the cell, no need to delete the smart pointer

// Or with raw pointers, without smart pointers (not recommended)

SpreadsheetCell* myCellp { new SpreadsheetCell { 5 } }; // Or: SpreadsheetCell* myCellp{ new SpreadsheetCell(5) };

SpreadsheetCell* anotherCellp { nullptr };
anotherCellp = new SpreadsheetCell { 4 };

// ... do something with the cells

delete myCellp; myCellp = nullptr;
delete anotherCellp; anotherCellp = nullptr;
```
##### Constructor Initializers (or ctor-initializer or  member initializer list)
The list starts with a colon and is separated by commas.
```C++
SpreadsheetCell::SpreadsheetCell(double initialValue)
    : m_value { initialValue }
{
}
```
When C++ creates an object, it must create all the data members of the object before calling the constructor. As part of creating these data members, it must call a constructor on any of them that are themselves objects. [By the time you assign a value to an object inside your constructor body, you are not actually constructing that object. You are only modifying its value.](#) A `ctor-initializer` allows you to provide `initial values` for data members as they are created, which is more efficient than assigning values to them later.  

if your class has as a data member an object of a class without a default constructor, you have to use the `ctor-initializer` to properly construct that object.

several data types must be initialized in a ctor-initializer or with an in-class initializer. The following table summarizes them:
- const data members
    You cannot legally assign a value to a const variable after it is created. Any value must be supplied at the time of creation.
- Reference data members
    References cannot exist without referring to something, and once created, a reference cannot be changed to refer to something else.
- Object data members for which there is no default constructor
    C++ attempts to initialize member objects using a default constructor. If no default constructor exists, it cannot initialize the object, and you have to tell it explicitly which constructor to call.
- Base classes without default constructors

There is one important caveat with ctor-initializers: they initialize data members in the order that they appear in the class definition, not their order in the ctor-initializer. [Professional C++ P314](#) 很重要切记, 为了避免这种错误尽量不要将成员对象构造函数所需的变量依赖于对象中其他成员
```C++
class Foo {
    public:
        Foo(double value);
    private:
        double m_value { 0 };
};
Foo::Foo(double value) : m_value { value } {
    cout << "Foo::m_value = " << m_value << endl;
}
// SUCCESS
class MyClass {
    public:
        MyClass(double value);
    private:
        double m_value { 0 };
        Foo m_foo;
};
MyClass::MyClass(double value) : m_value { value }, m_foo { m_value } {
    cout << "MyClass::m_value = " << m_value << endl;
}

// ERROR
class MyClass {
    public:
        MyClass(double value);
    private:
        Foo m_foo;
        double m_value { 0 };
};
MyClass::MyClass(double value) : m_value { value }, m_foo { m_value } {
    cout << "MyClass::m_value = " << m_value << endl;
}
// ERROR FIX
MyClass::MyClass(double value) : m_value { value }, m_foo { value } {
    cout << "MyClass::m_value = " << m_value << endl;
}
```

##### Inintializer-List Constructors(Professional C++ P317)
An initializer-list constructor is a constructor with an `std::initializer_list<T>` as the first parameter, and without any additional parameters or with additional parameters having default values.

##### Converting Constructors and Explicit Constructors 
```C++
export class SpreadsheetCell
{
    public:
        SpreadsheetCell() = default;
        SpreadsheetCell(double initialValue);
        SpreadsheetCell(std::string_view initialValue);
        SpreadsheetCell(const SpreadsheetCell& src);
        // Remainder omitted for brevity
};
// no use explicit
SpreadsheetCell myCell { 4 };
myCell = 5;
myCell = "6"sv;


// use explicit
export class SpreadsheetCell
{
    public:
        SpreadsheetCell() = default;
        SpreadsheetCell(double initialValue);
        explicit SpreadsheetCell(std::string_view initialValue);
        SpreadsheetCell(const SpreadsheetCell& src);
        // Remainder omitted for brevity
};
myCell = 5;
myCell = "6"sv; // compiles faild
SpreadsheetCell myCell { "6"sv }; // compiles SUCCESS

void process(const SpreadsheetCell& c) {... ...}
process(1);
process({1});
process("6"sv); // faild
process(SpreadsheetCell {"6"sv}); // success
```
`explicit(true) MyClass(int);` C++20

## Passing Object by Reference
When you are only using `pass-by-reference` for efficiency, you should preclude this possibility by declaring the object `const` as well.

## Object Destruction

### destructor method
Objects on the `stack` are destroyed when they go out of scope, which means whenever the current function, method, or other execution block ends.
```C++
class SpreadsheetCell {
    public:
        ~SpreadsheetCell();
};

SpreadsheetCell::~SpreadsheetCell() {
    cout << "Destructor called." << endl;
}
```
Objects on the `stack` are destroyed in the reverse order of their declaration (and construction).
[note:](#) Recall that data members are initialized in the order of their declaration in the class not the order of their in construct. 
```C++
{
    SpreadsheetCell myCell2 { 4 };
    SpreadsheetCell anotherCell2 { 5 }; // myCell2 constructed before anotherCell2
} // anotherCell2 destroyed before myCell2
```
Objects allocated on the free store without the help of smart pointers are not destroyed automatically. You must call `delete` on the object pointer to call its destructor and free its memory. The following program shows this behavior:
```C++
int main() {
    SpreadsheetCell* cellPtr1 { new SpreadsheetCell { 5 } };
    SpreadsheetCell* cellPtr2 { new SpreadsheetCell { 6 } };
    cout << "cellPtr1: " << cellPtr1->getValue() << endl;
    delete cellPtr1; // Destroys cellPtr1
    cellPtr1 = nullptr;
} // cellPtr2 is NOT destroyed because delete was not called on it.
```
[warning:](#)Do not write programs like the preceding example where cellPtr2 is not deleted. Make sure you always free dynamically allocated memory by calling delete or delete[] depending on whether the memory was allocated using new or new[]. Or better yet, use smart pointers as discussed earlier!

## Assigning to objects
[Professional C++ P323 -- P326](#)

