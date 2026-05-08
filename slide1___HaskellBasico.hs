import Data.Char
-- ======= EXERCICIOS 1 ======= --

{-
Defina as seguintes funções:
    fatorialfat :: Int -> Int
    
    all4Equal :: Int -> Int -> Int -> Int -> Bool
    – compara se quatro números são iguais

    howManyEqual :: Int -> Int -> Int -> Int
    – usando allEqual (definida abaixo), retorna quantos parâmetros são iguais
-}

fatorialfat :: Int -> Int
fatorialfat n 
    | n > 1 = n * fatorialfat(n-1)
    | otherwise = 1

{- também pode ser:
fatorialfat :: Int -> Int
fatorialfat 0 = 1
fatorialfat n = n * fatorialfat (n - 1)
-}

all4Equal :: Int -> Int -> Int -> Int -> Bool
all4Equal a b c d = (a == b) && (a == c) && (a == d)

howManyEqual :: Int -> Int -> Int -> Int
howManyEqual a b c 
    | allEqual a b c = 3 
    | (a == b) || (a == c) || (b == c) = 2
    | otherwise = 0 

-- ======= EXERCICIOS 2 ======= --

{-
Defina uma função que dado um valor
inteiro s e um número de semanas n retorna
quantas semanas de 0 a n tiveram venda
igual a s (usando uma função sales que diga quantas vendas houveram naquela semana).
-}

salesSearch :: Int -> Int -> Int
salesSearch s 0
    | s == sales 0 = 1
    | otherwise = 0
salesSearch s n
    | s == sales n = 1 + salesSearch s (n-1) -- lembre-se de colocar parênteses! Precedência em haskell faria (salesSearch s n) - 1
    | otherwise = 0 + salesSearch s (n-1)

-- ======= EXERCICIOS 3 ======= --

{-
Defina makeSpaces :: Int -> String
- produz um string com uma quantidade n de espaços

Defina pushRight :: Int -> String -> String
- adiciona n espaços a uma string (utilizando makeSpaces)
-}

makeSpaces :: Int -> String
makeSpaces 0 = ""
makeSpaces n = " " ++ makeSpaces (n-1) -- "++" é uma função que concatena strings

pushRight :: Int -> String -> String
pushRight n s = makeSpaces n ++ s

-- ======= EXERCICIOS 4 ======= --

{-
Defina a função averageSales :: Int -> Float
- dado um número de semanas n, retorna a média de vendas das semanas de 0 a n.
-}

averageSales :: Int -> Float
averageSales n = fromIntegral(totalSales n) / fromIntegral(n+1)
-- fromIntegral converte número para tipo mais geral, porque "/" não aceita Int
-- para divisão inteira, temos que usar "div"

-- ======= EXERCICIOS 5 ======= --

-- fórmula de bhaskara (depois)

-- ======= TEORIA ======= --

-- definições de tipo e atribuição de valores constantes
answer :: Int
answer = 42

greater :: Bool
greater = answer > 71

yes :: Bool
yes = True

-- definições de tipos das funções e de comportamento [<nome> <input> = <output>]

square :: Int -> Int
square x = x * x

allEqual :: Int -> Int -> Int -> Bool
allEqual n m p = (n == m) && (m == p)

-- recebe n m, dois inteiros, e, a depender da relação entre eles, dá um output diferente 
-- <nome> <input> = 
--     | <condição> = <output>
--     | <condição> = <output>

maxi :: Int -> Int -> Int
maxi n m 
    | n >= m = n
    | otherwise = m

-- casamento de padrões e recursão 
-- sales dá a quantidade de vendas na semana n, total soma as vendas da semana 0 à semana n

sales :: Int -> Int
sales 0 = 3
sales 1 = 5
sales 2 = 3
sales 3 = 7
sales 4 = 3

totalSales :: Int -> Int
totalSales 0 = sales 0
totalSales n = totalSales (n-1) + sales n

-- myOr usa casamento de padrões nas entradas para definir o resultado

myOr :: Bool -> Bool -> Bool
myOr True x = True
myOr False x = x

-- funções que usam caracteres e strings (Unicode!)

offset :: Int
offset = ord 'A' - ord 'a'  -- ord: converte caracter para seu código numérico. 
                            -- nessa "função", temos um retorno constante

capitalize :: Char -> Char
capitalize ch = chr (ord ch + offset) -- chr: converte o código Unicode para o caracter

isDigit :: Char -> Bool
isDigit ch = (ch >= '0') && (ch <= '9') -- compara código Unicode

-- isDigit, ord, chr estão disponíveis na seguinte biblioteca:
-- import Data.Char

-- funções padrão de ponto flutuante

-- ceiling, floor, round :: Float -> Int
-- fromIntegral :: Int -> Float

-- tuplas

addPair :: (Int,Int) -> Int
addPair (x,y) = x+y

-- sinonimos de tipos (podem criar pseudo-registros usando tuplas, mas não criam tipo novo de fato)

type Name = String
type Age = Int
type Phone = Int
type Person = (Name, Age, Phone)

-- definições locais

sumSquares :: Int -> Int -> Int
sumSquares x y = sqX + sqY
    where 
        sqX = x * x
        sqY = y * y

{-
sumSquares x y = sq x + sq y
    where sq z = z * z

sumSquares x y = let 
    sqX = x * x
    sqY = y * y
    in sqX + sqY
-}

-- Maiúsculas: Tipos e Construtores
-- Minúsculas: funções e argumentos