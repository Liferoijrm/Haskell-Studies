-- ======= EXERCICIOS 1 ======= --

{-
Defina as seguintes funções
- showExpr :: Expr -> String
- toList :: List t -> [t]
- fromList :: [t] -> List t
- depth :: Tree t -> Int
- colapse :: Tree t -> [t]
- mapTree :: (t -> u) -> Tree t -> Tree u
-}

-- esse instance não precisa se já tiver usando deriving
instance Show Expr where
    show (Lit n) = show n
    show (Add e1 e2) = "(" ++ show e1 ++ ") + (" ++ show e2 ++ ")"
    show (Sub e1 e2) = "(" ++ show e1 ++ ") - (" ++ show e2 ++ ")"

-- se tivesse deriving:
-- showExpr :: Expr -> String
-- showExpr e = show e
-- ou direto show e
-- ex: O resultado de show (Add (Lit 10) (Lit 20)) é "Add (Lit 10) (Lit 20)"

toList :: List t -> [t]
toList Nil = []
toList (Cons a l) = a : toList l

fromList :: [t] -> List t
fromList [] = Nil
fromList (a:as) = Cons a (fromList as)
-- fromlist = foldr Cons Nil
        
depth :: Tree t -> Int
depth NilT = 0
depth (Node n t1 t2) = 1 + max (depth t1) (depth t2)

colapse :: Tree t -> [t]
colapse NilT = []
colapse (Node n t1 t2) = n:(colapse t1 ++ colapse t2)
-- colapse t1 ++ [n] ++ colapse t2 seria melhor

mapTree :: (t -> u) -> Tree t -> Tree u
mapTree _ NilT = NilT
mapTree f (Node n t1 t2) = Node (f n) (mapTree f t1) (mapTree f t2)

-- ======= TEORIA ======= --

{-
diferente do uso de "type", que apenas cria apelidos para tipos, "data" define novos tipos de dados, 
e novos construtores de tipos.
-}

-- tipos enumerados (como enums, usam "|" para separar os possíveis valores)
data Estacao =  Inverno | Verao |
                Outono | Primavera

data Temp = Frio | Quente

-- permitem casamento de padrões
clima :: Estacao -> Temp
clima Inverno = Frio
clima _ = Quente

-- registros (funcionam como structs, mas usam construtores)
type Name = String
type Age = Int
data People = Person Name Age

-- Person é o construtor do tipo de dados People. Algo assim: 
-- Person :: Name -> Aqe -> People
--
-- usado assim:
-- Person ”José” 22 
-- ou 
-- pessoa :: People
-- pessoa = Person ”José” 22 

{-
CONSTRUTORES COMO ARGUMENTOS
- os construtores podem ser usados para casamento de padrões em funções
- basta usar (), pois é um único argumento composto
-}

-- define o tipo Shape como algo construído por um dos construtores e pelos seus parâmetros
data Shape = Circle Float
            | Rectangle Float Float

isRound :: Shape -> Bool
isRound (Circle _) = True
isRound (Rectangle _ _) = False

area :: Shape -> Float
area (Circle r) = pi*r*r
area (Rectangle h w) = h * w

{-
TIPO RECURSIVO
- define um tipo de forma indutiva (caso base e definições a partir disso)
- parece com a estrutura sintática de wffs em lógica formal
-}

data Expr = Lit Int        -- Um valor literal (ex: 5) é uma expressão
          | Add Expr Expr  -- A soma de DUAS expressões é uma expressão
          | Sub Expr Expr  -- A subtração de DUAS expressões é uma expressão

-- eval é a função de avaliação que avalia a expressão matemática de forma recursiva

eval :: Expr -> Int
eval (Lit n) = n
eval (Add e1 e2) = (eval e1) + (eval e2)
eval (Sub e1 e2) = (eval e1) - (eval e2)

{-
TIPO POLIMÓRFICO (Generics)
- permite criar estruturas de dados com quaisquer tipos (Trees de Int, Float, Char etc, por exemplo)
-}

-- não importa o tipo contido no par, ele continua sendo um par (pair<int,char> em C++, por exemplo)
-- só é necessário primeiro informar o tipo, nesse caso (mas poderia ser data Pair t u = Pair t u)
data Pair t = Pair t t

sixSeven :: Pair Int
sixSeven = Pair 6 7

-- posso definir uma lista que aceita qualquer tipo, basta informar
data List t = Nil 
            | Cons t (List t) 

listaVazia :: List String
listaVazia = Nil

addNameInList :: List String -> String -> List String
addNameInList as s = Cons s as

-- posso definir uma tree com nodes de qualquer tipo
data Tree t = NilT 
            | Node t (Tree t) (Tree t) -- um nó é composto por valor atual e as duas subárvores

{-
DERIVANDO INSTÂNCIAS DE CLASSES (Deriving - Metaprogramação)
- Classes (Type Classes) no haskell funcionam como interfaces: listas de assinaturas de métodos (funções) 
a serem implementados por cada classe (Data Type ou Instância) que herda (deriva) daquela interface (Type Class)

- overloading das funções de uma Type Class (vários comportamentos para uma assinatura)

- por exemplo: a classe Eq possui a assinatura da função (==) e (/=). Então toda função que derivar
daquela Type Class deve ensinar ao haskell como implementar (==) e (/=) corretamente para o seu tipo. 
com deriving, o compilador faz isso automaticamente. Sem deriving, é responsabilidade do programador.

- Outras Type Classes: Show (função show, parecido com toString()), Ord((<), (>), (<=), (>=), min, max)

definição de uma Type Class:
class Eq t where
    (==) :: t -> t -> Bool -- sendo o "t" o tipo da instância que derivará da classe

- não precisa definir Type Classes padrão
- São instâncias de Eq os tipos primitivos e as listas e tuplas de instâncias de Eq
-}


 
data List2 t = Nil2 
            | Cons2 t (List2 t)
            deriving (Eq,Ord,Show)
{-
- aqui, o deriving, em tempo de compilação, gera um bloco de código "instance" para cada Typeclass

ex:
instance (Eq t) => Eq (List2 t) where
    Nil2 == Nil2 = True
    (Cons2 x xs) == (Cons2 y ys) = x == y && xs == ys
    _ == _ = False

- sem deriving, ou para definir outro tipo de comparação, o programador deve escrever algo assim na mão
-}

{-
para tipos concretos (não polimórficos), temos:

instance Eq Expr where
    (Lit n1)     == (Lit n2)     = n1 == n2
    (Add e1 e2)  == (Add f1 f2)  = e1 == f1 && e2 == f2
    (Sub e1 e2)  == (Sub f1 f2)  = e1 == f1 && e2 == f2
    _            == _            = False
-}

{-
MAYBE TYPE (Tratamento de Erros e Tipos Opcionais)
- data Maybe t = Just t | Nothing deriving (Eq, Ord, Show)
- Representa a POSSIBILIDADE de um valor ou a sua AUSÊNCIA (erro/falha).

COMPONENTES:
- Just t: "A caixa com o valor". Sucesso da operação.
- Nothing: "Caixa vazia". Falha, valor não encontrado ou erro.

VANTAGENS:
- Robustez: Força o tratamento de erros em tempo de compilação.
- Segurança: Elimina o erro de "ponteiro nulo" (NullPointerException).

FORMA DE USO:
1. Pattern Matching:
   case resultado de func of
     Just x  -> "Trata valor x"
     Nothing -> "Trata o erro"

2. Funções Parciais: Transforma funções que não funcionam para toda entrada 
   (ex: divisão por zero ou busca em lista) em funções totais e seguras.
-}

saldo :: String -> [(String,Float)] -> Maybe Float
saldo _ [] = Nothing
saldo person ((p,s):pss)
        | person == p = Just s
        | otherwise = saldo person pss

maria :: Maybe Float
maria = saldo "Maria" [("Jose", 10), ("Maria",20)] -- Just 20.0
pedro :: Maybe Float
pedro = saldo "Pedro" [("Jose", 10), ("Maria",20)] -- Nothing