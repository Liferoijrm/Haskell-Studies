import Data.List
-- ====== Questão 1 ====== --
{-
Defina uma função que retorne o maior entre quatro inteiros.
maior4 :: Int -> Int -> Int -> Int -> Int
-}

maior4 :: Int -> Int -> Int -> Int -> Int
maior4 a b c d = max (max a b) (max c d) 

-- ====== Questão 2 ====== --
{-
Defina uma função que receba uma nota e retorne a menção do aluno. A nota é um valor
do tipo Float entre 0.0 (inclusive) e 10.0 (inclusive) e a menção é uma string. Considere a
seguinte tabela para tradução da menção:
Intervalo da nota Menção
De 9 a 10 => "SS"
De 7 a 8.9 => "MS"
De 5 a 6.9 => "MM"
De 3 a 4.9 => "MI"
converterNotaParaMencao :: Float -> String
-}

converterNotaParaMencao :: Float -> String
converterNotaParaMencao n 
    | n >= 9 = "SS"
    | n >= 7 = "MS"
    | n >= 5 = "MM"
    | n >= 3 = "MI"
    -- teria "II", mas a questão não pediu
    | otherwise = "SR"

-- ====== Questão 3 ====== --
{-
Implemente funções que satisfaçam a cada um dos requisitos abaixo:
a) Retorna a diferença entre duas listas. O resultado é uma lista.
b) Retorna a interseção entre duas listas. O resultado é uma lista.
c) Retorna a união entre duas listas (pode haver repetição de elementos). O resultado
é uma lista.
d) Retorna a união entre duas listas (não há repetição de elementos). O resultado é
uma lista.
e) Retorna o último elemento de uma lista.
f) Retorna o n-ésimo elemento de uma lista.
g) Inverte uma lista.
h) Ordena uma lista em ordem descrescente, removendo as eventuais repetições de
elementos.
i) Retorna um booleano indicando se uma lista de inteiros é decrescente ou não.
Proponha 3 soluções: usando sort; usando apenas recursão; usando fold, map
e zip.
-}

-- a) 
-- (aqui o tipo tem que ser instância de Eq, sinalizado por Eq t =>)

subList :: Eq t => [t] -> [t] -> [t]
subList as bs = [x | x <- as, not (elem x bs)]

-- b)

intersectList :: Eq t => [t] -> [t] -> [t]
intersectList as bs = [x | x <- as, elem x bs]

-- c)

concatList :: Eq t => [t] -> [t] -> [t]
concatList as bs = as ++ bs

-- d)

uniteList :: Eq t => [t] -> [t] -> [t]
uniteList as bs = as ++ subList bs as

-- e)

lastElem :: [t] -> t
lastElem [x] = x
lastElem (a:as) = lastElem as

-- f)
-- não tá segura, n pode exceder o limite, mas serve

nElem :: [t] -> Int -> t
nElem (a:as) 0 = a
nElem (a:as) n = nElem as (n-1)

-- g)

reverseList :: [t] -> [t]
reverseList [] = []
reverseList (a:as) = reverseList as ++ [a]

-- h)
-- tem que ter Ord e Eq por causa do maximum (por isso só Ord)
-- o "x /= m" já garante que os elementos serão únicos
-- tem que usar "where" porque se não o máximo vai mudar toda vez

orderList :: Ord t => [t] -> [t]
orderList [] = []
orderList as = orderList [x | x <- as, x /= m] ++ [m]
    where m = maximum as

-- i)
-- 1. Lá em cima tem "import Data.List"

isDecreasing :: [Int] -> Bool
isDecreasing as = as == reverse(sort as)

-- 2.

isDecreasing2 :: [Int] -> Bool
isDecreasing2 [] = True
isDecreasing2 [x] = True
isDecreasing2 (a:b:as)
    | a >= b = isDecreasing2 (b:as)
    | otherwise = False

-- 3.

compPair :: (Int, Int) -> Bool
compPair (a, b) = a >= b

isDecreasing3 :: [Int] -> Bool
isDecreasing3 (a:as) = foldr (&&) (True) (map compPair (zip (a:as) as))

-- ====== Questão 4 ====== --
{-
Defina uma função que recebe uma lista de strings como entrada e computa uma lista de
pares de (String, Int) representando o histograma (o número de ocorrência) de seus
elementos:

histograma :: [String] -> [(String,Int)]
-}

count :: String -> [String] -> Int
count a as = length [x | x <- as, x == a]

histograma :: [String] -> [(String, Int)]
histograma [] = []
histograma (a:as) = (a, 1 + count a as) : histograma [x | x <- as, x /= a] 

-- ====== Questão 5 ====== --
{-
Defina a função myZipWith, que tem como parâmetros uma função binária (que tem
dois parâmetros) e duas listas, retornando uma lista de valores resultantes da aplicação dessa
função nos elementos correspondentes dessas listas:

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
-}

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith f (a:as) (b:bs) = f a b : myZipWith f as bs
myZipWith f _ _ = []

-- ====== Questão 6 ====== --
{-
Resolva em Haskell o seguinte problema: a partir de duas notas das provas de cada aluno,
determinar a lista dos alunos aprovados, com suas respectivas médias. O resultado deve estar
ordenado crescentemente pela média aritmética das notas. A aprovação ocorre se, e somente
se, tal média é maior ou igual a 5.0.

aprovadosOrdemDeMedia :: [(String,Float,Float)] -> [(String,Float)]
-}

aprovadosOrdemDeMedia :: [(String,Float,Float)] -> [(String,Float)]
aprovadosOrdemDeMedia l = sortBy (\(_, n1) (_, n2) -> compare n1 n2) (filter (\(_, nota) -> nota >= 5.0)(map aproved l))

aproved :: (String,Float,Float) -> (String,Float)
aproved (s, n1, n2) = (s, (n1+n2)/2)

-- teste: [("Jonas",3.0,7.0), ("MIguelicia",0.0,1.7), ("Rafael Moleiro",3.0,7.54), ("LEO",1.2,10.0), ("SOJA",10.0,9.0), ("Mago",0.0,5.0)]

-- ====== Questão 7 ====== --
{-
Considere a representação de matrizes como lista de listas em que cada elemento da lista é
uma lista que representa uma linha da matriz. Com base nisso, determine as seguintes
funções:

a) some duas matrizes de inteiros
somaMatricial :: [[Int]] -> [[[Int]] -> [[[Int]]

b) compute a transposta de duas matrizes de inteiros
matrizTransposta :: [[Int]] -> [[Int]]
-}

-- a)

somaMatricial :: [[Int]] -> [[Int]] -> [[Int]]
somaMatricial m1 m2 = zipWith (zipWith (+)) m1 m2

-- b)

matrizTransposta :: [[Int]] -> [[Int]]
matrizTransposta [] = []
matrizTransposta ([]:_) = []
matrizTransposta m = map head m : matrizTransposta (map tail m)

-- ====== Questão 8 ====== --
{-
Com relação aos slides de Tipos Algébricos, estenda o tipo Expr para poder também
representar multiplicação. Altere também a definição da função de avaliação eval
-}

data Expr = Lit Int
          | Add Expr Expr
          | Sub Expr Expr
          | Mul Expr Expr

eval :: Expr -> Int
eval (Lit n) = n
eval (Add e1 e2) = (eval e1) + (eval e2)
eval (Sub e1 e2) = (eval e1) - (eval e2)
eval (Mul e1 e2) = (eval e1) * (eval e2)

-- ====== Questão 9 ====== --
{-
Crie a função foldTree, que recebe uma função e uma árvore polimórfica binária como
parâmetros, e retorna o valor resultante de acumular a aplicação dessa função por todos os
nós da árvore.
-}

data Tree t = NilT
            | Tree t (Tree t) (Tree t) 

foldTree :: (t -> t -> t) -> Tree t -> t -> t
foldTree f NilT ac = ac
foldTree f (Tree n t1 t2) ac = f n (foldTree f t1 (foldTree f t2 ac))

-- ====== Questão 10 ====== --
{-
Defina uma função que some os elementos de uma árvore binária que armazena inteiros
em seus nós. Resolva o exerício de duas formas diferentes: 

a) usando a função foldTree definida acima; 

b) sem usar a função foldTree
-} 

-- a)

foldIntTree :: Tree Int -> Int 
foldIntTree t = foldTree (+) t 0 

-- b)

foldIntTree2 :: Tree Int -> Int 
foldIntTree2 NilT = 0
foldIntTree2 (Tree n t1 t2) = n + foldIntTree t1 + foldIntTree t2

-- ====== Questão 11 ====== --
{-
Refaça o Exercício 2, usando um tipo algébrico para modelar a menção. Discuta, em no
máximo quatro linhas, vantagens e desvantagens da soluções.
-} 

data Mencao = SS
            | MS
            | MI
            | MM
            | SR

converterNotaParaMencao2 :: Float -> Mencao
converterNotaParaMencao2 n
    | n >= 9 = SS
    | n >= 7 = MS
    | n >= 5 = MI
    | n >= 3 = MM
    -- teria "II", mas a questão não pediu
    | otherwise = SR

-- > dessa forma, o tipo "Mencao" funciona como um enum, de forma que não é possível adicionar
-- outras menções que não são as definidas pelo enum, exatamente com a sintaxe descrita. Em contrapartida,
-- exige maior esforço inicial para converter dados externos e requer que o tipo derive instâncias
-- como Show ou Eq para operações simples de exibição ou comparação.
