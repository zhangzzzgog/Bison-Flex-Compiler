# Bison-Flex-Compiler

## Introduction
This is a simple compiler for a simple language. The language is a simple arithmetic language that can handle addition, subtraction, multiplication, and division. The compiler is written in C++ and uses Bison and Flex to generate the parser and lexer.

## How to run
To run the compiler, you need to have Bison and Flex installed on your machine. You can install them using the following commands:
```
sudo apt-get install flex bison
```

After installing Bison and Flex, you can run the following commands to compile the compiler:
```
bison -d mytool.y
flex -omytool.yy.c mytool.l
gcc mytool.tab.c mytool.yy.c -o mytool -ll
./mytool
```

## Example
The following is an example of the input and output of the compiler:

    ```
    Input:
    3 == 2
    Output:
    Output: FALSE, 1, 0
    ```
    
    ```
    Input:
    3 > 2
    Output:
    Output: TRUE, 1, 0
    ```
    
    ```
    Input:
    3 > 2 && 10 > 1
    Output:
    Output: TRUE, 2, 0
    ```
    
    ```
    Input:
    3 > 2 && 10 > 12
    Output:
    Output: FALSE, 2, 0
    ```
    
    ```
    Input:
    3 < 2 && 10 > 12
    Output:
    Output: FALSE, 2, 1
    ```
    
    ``` 
    Input:
    ( 3 <= 2 || 13 <= 19 ) && 1 < 2
    Output:
    Output: TRUE, 3, 0
    ```
    
    ```
    Input:
    ( 3 >= 2 || 13 <= 19 ) && 1 < 2
    Output:
    Output: TRUE, 3, 1
    ```
    
    ```
    Input:
    ( 3 >= 2 || 13 <= 19 ) || 1 < 2
    Output:
    Output: TRUE, 3, 2
    ```
    
    ```
    Input:
    ! ( 3 > 2 )
    Output:
    Output: FALSE, 1, 0
    ```
    
    ``` 
    Input:
    ! ( 3 > 2 || ( 13 < 19 || 1 < 2 ) )
    Output:
    Output: FALSE, 3, 2
    ```
    
    ```
    Input:
    3 >= 2 || 13 <= 19 && 1 < 2
    Output:
    Output: TRUE, 3, 2
    ```
    
    ```
    Input:
    3 <= 2 || 13 >= 19 && 1 < 2
    Output:
    Output: FALSE, 3, 1
    ```

## Grammar
The grammar of the language is as follows:

    ```
    E -> E == E
    E -> E > E
    E -> E < E
    E -> E >= E
    E -> E <= E
    E -> E && E
    E -> E || E
    E -> ! E
    E -> ( E )
    E -> NUM
    ```
## AutoTest
The autotest script is a simple script that runs the compiler on a set of test cases and compares the output with the expected output. The autotest script is written in Python and can be run using the following command:
```
python script.py
```
