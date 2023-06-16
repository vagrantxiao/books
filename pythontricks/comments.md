# Python Tricks The Book

Author: Dan Bader

## Chapter 1

[dbader.org/python-tricks-toolkit](https://www.dbader.org/python-tricks-toolkit)


## Chapter 2: Patterns for Cleaner Python

1. Use Asster for better dubugging.

2. User commas. Use multi-lines for to ```git diff``` better.

```Python
names = [
    'Alice',
    'Bob',
    'Dilbert',
    'Jane',  # If you add items latter, you won't add more commas
]
```

3. Context Managers and the ```with``` Statement

```Python
with open('hello.txt', 'w', encoding="utf-8") as f:
    f.write('Hello, world!')
```

4. "_var": local internal variable

5. "var_": avoid naming conflicts with key words

6. "__var": will be translated to some other variable automatically!!!

7. "\_\_var\_\_": dunder default function, special methods defined by Python
language.

8. "_": temperal variable

```Python
car = ('red', 'auto', 12, 3812.4)
color, _, _, mileage = car
```

9. Old style string format.

```Python
name = "Bob"
num  = 456
print('Hello, %s' % name)
print('Hello, %s is No. %x' % (name, num))
```

10. New style string format.

```Python
name = "Bob"
num  = 456
print('Hello, {}'.format(name))
print('Hello, {n} is No. {b:x}'.format(n=name, b=num))
```


11. Literal string Interpolation (Python 3.6+).

```Python
name = "Bob"
num  = 456
print(f'Hello, {name} is No. {num}')
```

12. Template Strings

```Python
from string import Template
name="Bob"
errno=32
t = Template('Hey, $name!')
t.substitute(name=name)
templ_string = 'Hey $name, there is a $error error!'
Template(templ_string).substitute(name=name, error=hex(errno))
```



## Chapter 3: Effective Functions 
1. Function Can be Nested

```Python
def speak(text):
    def whisper(t):
        return t.lower() + '...'
    return whisper(text)
```

2. Objects can behave like functions.

```Python
class Adder:
    def __init__(self, n):
        self.n = n
    def __call__(self, x):
        return self.n + x
plus_3 = Adder(3)
print(plus_3(4))
```

3. Lambdas are Single-Expression Functions.

```Python
add = lambda x, y: x + y
print(add(5,4))
```

4. Lambdas You Can Use.

```Python
tuples = [(1, 'd'), (2, 'b'), (4, 'a'), (3, 'c')]
sorted(tuples, key=lambda x: x[1])
```
5. Return a configurable function.

```Python
def make_adder(n):
    return lambda x: x + n
plus_3 = make_adder(3)
plus_5 = make_adder(5)
print(plus_3(4))
print(plus_5(4))
```

6. Bad and Good.

```Python
# Harmful
list(filter(lambda x: x % 2 == 0, range(16)))

# Better
[x for x in range(16) if x % 2 == 0]
```


7. Simple Decorators.

```Python
def uppercase(func):
    def wrapper():
        original_result = func()
        modified_result = original_result.upper()
        return modified_result
    return wrapper

@uppercase
def greet():
    return "Hello"

greet()
```

8. Fun with \*args and \*\*kwargs.

```Python
def foo(required, *args, **kwargs):
    print(required)
    if args:
        print(args)
    if kwargs:
        print(kwargs)

foo('hello', 1, 2, 3, key1='value', key2=999)
foo.__name__
```

9. Decorating Functions That Accept Arguments

```Python
def proxy(func):
    def wrapper(*args, **kwargs):
        return func(*args, **kwargs)
    return wrapper

def trace(func):
    def wrapper(*args, **kwargs):
        print(f'TRACE: calling {func.__name__}() '
              f'with {args}, {kwargs}')
        original_result = func(*args, **kwargs)
        print(f'TRACE: {func.__name__}() '
              f'returned {original_result!r}')
        return original_result
    return wrapper

@trace
def say(name, line):
    return f'{name}: {line}'

print(say('Jane', 'Hello, World'))
```


10. Debugging features.

```Python
def trace(f):
    @functools.wraps(f)
    def decorated_function(*args, **kwargs):
        print(f, args, kwargs)
        result = f(*args, **kwargs)
        print(result)
    return decorated_function

@trace
def greet(greeting, name):
    return '{}, {}!'.format(greeting, name)

print(greet('Hello', 'Bob'))
```


11. Function Argument Unpacking

```Python
def print_vector(x, y, z):
    print('<%s, %s, %s>' % (x, y, z))
tuple_vec = (1, 0, 1)
list_vec = [1, 0, 1]
dict_vec = {'y': 0, 'z': 1, 'x': 1}
print_vector(*tuple_vec)
print_vector(*list_vec)
print_vector(**dict_vec)
```

## Chapter 4: Classes \& OOP

1. An ```is``` expression evaluates to True if two variables point to the 
same (identical) object.

2. An ```==``` expression evaluates to True if the objects referred to by
the variables are equal (have the same contents).

3. String Conversion.

```Python
class Car:
    def __init__(self, color, mileage):
        self.color = color
        self.mileage = mileage

    def __repr__(self):
        return (f'{self.__class__.__name__}('
                f'{self.color!r}, {self.mileage!r})')

    def __str__(self):
        return f'a {self.color} car'

car = Car('blue', 5134)
print(car)
```

4. Deep copy.

```Python
import copy
xs = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
zs = copy.deepcopy(xs)
```

5. Force inheritant classes to define moethods.

```Python
from abc import ABCMeta, abstractmethod
class Base(metaclass=ABCMeta):
    @abstractmethod
    def foo(self):
        pass

    @abstractmethod
    def bar(self):
        pass

class Concrete(Base):
    def foo(self):
        pass
# Will get errors since we did not define bar
```

6. Namedtuples to the Rescue. Make sure the local variables cannot be modified
after the first initiation.

```Python
from collections import namedtuple
Car = namedtuple('Car' , 'color mileage')
my_car = Car('red', 3812.4)
print(my_car.color)
print(my_car.mileage)
``` 

7. SubNametuples

```Python
class MyCarWithMethods(Car):
    def hexcolor(self):
        if self.color == 'red':
            return '#ff0000'
        else:
            return '#000000'
```

8. Dump as Json format.

```Python
import json
from collections import namedtuple
Car = namedtuple('Car' , 'color mileage')
my_car = Car('red', 3812.4)
json.dumps(my_car._asdict())
```

9. Different methods inside a class. 

```Python
class MyClass:
    def method(self):
        return 'instance method called', self

    @classmethod
    def classmethod(cls):
        return 'class method called', cls
    
    @staticmethod
    def staticmethod():
        return 'static method called'


obj = MyClass()
print(MyClass.method(obj))
print(MyClass.classmethod(cls))
print(MyClass.staticmethod())
```


## Chapter 5: Common Data Structures in Python

1. Ordered dictionary.

```Python
import collections
d = collections.OrderedDict(one=1, two=2, three=3)
print(d)
``` 

2. Set to default values for missing keys for dictionary.

```Python
from collections import defaultdict
dd = defaultdict(list)
dd['dogs'].append('Rufus')
print(dd)
```

3. Merge two dicts together.

```Python
from collections import ChainMap
dict1 = {'one': 1, 'two': 2}
dict2 = {'three': 3, 'four': 4}
chain = ChainMap(dict1, dict2)
```

4. Read-only dicts.

```Python
from types import MappingProxyType
writable = {'one': 1, 'two': 2}
read_only = MappingProxyType(writable)
```

















