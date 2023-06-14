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











