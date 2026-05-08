-- ======= EXERCICIOS 1 ======= --

{-
Use a função maxFun para implementar a função que retorna o maior número de vendas 
de uma semana de 0 a n semanas
- maxSales :: Int -> Int

Implemente uma função que, dada uma outra função f, verifica se f é crescente
em um intervalo de 0 a n
- isCrescent :: (Int -> Int) -> Int -> Bool
-}

maxi :: Int -> Int -> Int
maxi a b
    | a >= b = a
    | otherwise = b

maxFun :: (Int -> Int) -> Int -> Int
maxFun f 0 = f 0
maxFun f n = maxi (maxFun f (n-1)) (f n)

-- basta passar essa função que retorna as vendas daquela semana e um n para maxFun calcular 
-- qual foi o maior número de vendas de uma semana
sales :: Int -> Int
sales 0 = 3
sales 1 = 5
sales 2 = 3
sales 3 = 7
sales 4 = 3

isCrescent :: (Int -> Int) -> Int -> Bool
isCrescent f 0 = True
isCrescent f n 
    | isCrescent f (n-1) = f n >= f (n-1)
    | otherwise = False
-- isCrescent f n = f n > f (n-1) && isCrescent f (n-1) 
-- mais idiomático e otimizado
{-
Sempre que você tem um guard que retorna um booleano e um otherwise = False, você 
geralmente pode substituir essa estrutura inteira por uma expressão lógica simples 
usando && (E lógico).
-}

-- ======= EXERCICIOS 2 ======= --

{-
Defina as seguintes funções sobre listas
– eleva os itens ao quadrado (mapping)
– retorna a soma dos quadrados dos itens (folding)
– manter na lista todos os itens maiores que zero (filtering)
-}

sqr :: Int -> Int
sqr a = a*a

mapSqrs :: [Int] -> [Int]
mapSqrs l = map sqr l
-- ou melhor, mais idiomático: mapSqrs = map sqr

sumSqrs :: [Int] -> Int
sumSqrs l = foldr (+) 0 (mapSqrs l)

filterPos :: [Int] -> [Int]
filterPos l = filter (>0) l
-- ou melhor, mais idiomático: filterPos = filter (>0)

-- ======= TEORIA ======= --

-- polimorfismo: operar independente do tipo (polimorfismo por generalização)

{-
MAP
- map aplica uma função (transformação) a cada elemento de uma lista e retorna a lista modificada

- recebe função e lista e retorna lista
map :: (a -> b) -> [a] -> [b]
ou
map f l = [f a | a <- l]

- ex:
map (*2) [1,2,3]
= [2,4,6]

================

FILTER
- filter seleciona elementos que satisfazem uma condição (função booleana) e retorna a lista só dos que satisfazem

- recebe função e lista e retorna lista
filter :: (a -> Bool) -> [a] -> [a]
ou
filter p l = [a | a <- l, p a]

ex:
filter even [1,2,3,4]
= [2,4]

================

FOLDR

- foldr reduz uma lista a um único valor usando uma função (acumulador)

- recebe uma função que condensa 2 elementos em 1 e uma lista e retorna o elemento condensado
- começa pela direita da lista
foldr :: (a -> b -> b) -> b -> [a] -> b

ex:
foldr (+) 0 [1,2,3]
= 6

OBS: existem operadores "op" específicos (and, or, sum, product, concat, maximum, minimum etc) que 
encapsulam um processo de fold.
- quando há um "op" com uma lista como argumento, acontece um fold de op sobre essa lista
ex: or [False, True, False] = True
-}