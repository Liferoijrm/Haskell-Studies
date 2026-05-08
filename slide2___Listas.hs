-- ======= EXERCICIOS 1 ======= --

{-
Quantos elementos existem nessas listas?
- [2,3] [[2,3]]
R: 2 e 1

Qual o tipo da lista [[2,3]]?
R: [[Int]]

Qual o resultado da avaliação de:
- [2,4..9]
R: [2, 4, 6, 8]
- [2..2]
R: [2]
- [2,7..4]
R: [2]
- [10,9..1]
R: [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
- [10..1]
R: []
-}

-- ======= EXERCICIOS 2 ======= --

{-
- somar os valores de uma lista
sumList :: [Int] -> Int

- dobrar os elementos de uma lista
double :: [Int] -> [Int]

- pertencer: checar se um elemento está na lista
member :: [Int] -> Int -> Bool

- filtragem: apenas os números de uma string
digits :: String -> String

- soma de uma lista de pares
sumPairs :: [(Int,Int)]->[Int]
-}

sumList :: [Int] -> Int
sumList [] = 0
sumList (a:as) = a + sumList as -- "as" é só um nome para a lista, poderia ser "l" ou outro nome


double :: [Int] -> [Int]
double [] = []
double (a:as) = (2*a):double as

--member :: [Int] -> Int -> Bool
--member [] n = False
--member (a:as) n
--    | a == n = True
--    | otherwise = member as n

digits :: String -> String
digits [] = []
digits (a:as)
    | isDigit a = a:digits as
    | otherwise = digits as

isDigit :: Char -> Bool
isDigit c = c >= '0' && c <= '9'

sumPairs :: [(Int,Int)]->[Int]
sumPairs [] = []
sumPairs ((x,y):as) = (x+y):sumPairs as

-- ======= EXERCICIOS 3 ======= --

{-
Redefina as funções utilizando compreensão de listas
- member :: [Int] -> Int -> Bool
- books :: Database -> Person -> [Book]
- borrowers :: Database -> Book ->[Person]
- borrowed :: Database -> Book -> Bool
- returnLoan :: Database -> Person -> Book -> Database
-}

type Person = String
type Book = String
type Database = [(Person, Book)]

exampleBase :: Database
exampleBase =
    [("Alice","Postman Pat"),
    ("Anna","All Alone"),
    ("Alice","Spot"),
    ("Rory","Postman Pat")]

isNotEmpty :: [t] -> Bool
isNotEmpty [] = False
isNotEmpty _ = True -- padrão coringa (wildcard pattern), significa "qualquer coisa"

member :: [Int] -> Int -> Bool
member as n = isNotEmpty [a | a <- as, a == n] 
-- member as n = or [a == n | a <- as]
-- esse outro jeito geraria uma lista de booleanos [False, True, ...]
-- or pode operar sobre uma lista inteira (como um fold)
-- or = foldr (||) False

books :: Database -> Person -> [Book]
books db p = [b | (n,b) <- db, n == p]

borrowers :: Database -> Book -> [Person]
borrowers db b = [p | (p,t) <- db, t == b]

borrowed :: Database -> Book -> Bool
borrowed db b = isNotEmpty [t | (p,t) <- db, t == b]

returnLoan :: Database -> Person -> Book -> Database
returnLoan db p b = [(n, t) | (n, t) <- db, (n, t) /= (p, b)]

-- ======= TEORIA ======= --

-- quando o tipo não está claro, haskell assume o tipo mais geral possível 

list :: [Int]
list = [1,2,3,4]

tupleList :: [([Int],Bool)]
tupleList = [([5], True),([7, 1], True)]

-- sinônimos de tipos:
-- type String = [Char]
-- [] é uma lista de qualquer tipo.

-- construtor de listas (chamado de "cons"):
-- (:) :: t -> [t] -> [t] 
-- [2,3,4,5] é o mesmo que 2:3:4:5:[], avaliado como 2:(3:(4:(5:[]))) em O(1) para cada elemento inserido

-- listas resumidas (somente para tipos da classe Enum):
-- [x..y] = [x, x+1, ..., y]
-- 
-- soma de 1 em 1 até que 
-- o valor seja estritamente maior que y
-- não necessariamente inclui y
-- não tem versão decrescente

-- [x, y..z] = [x, x+r, ..., z]
--
-- soma (ou subtrai se decrescente) de r em r até que 
-- o valor seja estritamente maior que z (ou estritamente menor se decrescente)
-- sendo r = y - x
-- não necessariamente inclui z

-- funções importantes
-- concatenar: (++) :: [t] -> [t] -> [t]
-- comprimento: length :: [t] -> Int


-- funções de sort e insert estão disponíveis em import Data.List
-- sort:: [Int] -> [Int]
-- insert :: Int -> [Int] -> [Int]

-- polimorfismo: aceitar vários tipos como parâmetros, independer do tipo do parâmetro para operar

-- ====== LISTAS POR COMPREENSÃO ====== -- 
{-
Compreensões de listas
- Usadas para definir listas em função de outras listas (pattern matching):

doubleList :: [Int] -> [Int]
doubleList xs = [2*a|a <- xs]
E: recebe a lista xs e retorna uma lista cujo cada valor vale 2*a, sendo a um elemento de xs

doubleIfEven :: [Int] -> [Int]
doubleIfEven xs = [2*a|a <- xs, isEven a]
E: recebe a lista xs e retorna uma lista cujo cada valor vale 2*a, sendo a um elemento de xs que seja par
-}