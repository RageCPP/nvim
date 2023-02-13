# about weak_ptr
A weak_ptr can contain a reference to a resource managed by a shared_ptr. The weak_ptr does not own the resource, so the shared_ptr is not prevented from deallocating the resource. A weak_ptr does not destroy the pointed-to resource when the weak_ptr is destroyed. however, it can be used to determine whether the resource has been freed by the associated shared_ptr or not. The constructor of a weak_ptr requires a shared_ptr or another weak_ptr as argument. To get access to the pointer stored in a weak_ptr, you need to convert it to a shared_ptr. There are two ways to do this:
    - Use the lock() method on a weak_ptr instance, which returns a shared_ptr. The returned shared_ptr is nullptr if the shared_ptr associated with the weak       _ptr has been deallocated in the meantime.
    - Create a new shared_ptr instance and give a weak_ptr as argument to the shared_ptr constructor. This throws an std::bad_weak_ptr exception if the share       d_ptr associated with the weak_ptr has been deallocated.
```C++
void useResource(weak_ptr<Simple>& weakSimple)
{
    auto resource { weakSimple.lock() };
    if (resource) {
        cout << "Resource still alive." << endl;
    } else {
        cout << "Resource has been freed!" << endl;
    }
}
int main()
{
    auto sharedSimple { make_shared<Simple>() };
    weak_ptr<Simple> weakSimple { sharedSimple };
    // Try to use the weak_ptr.
    useResource(weakSimple);
    // Reset the shared_ptr.
    // Since there is only 1 shared_ptr to the Simple resource, this will
    // free the resource, even though there is still a weak_ptr alive.
    sharedSimple.reset();
    // Try to use the weak_ptr a second time.
    useResource(weakSimple);
}
```
