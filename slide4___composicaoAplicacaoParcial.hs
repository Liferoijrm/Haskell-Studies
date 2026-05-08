-- ======= EXERCICIOS 1 ======= --

{-
Dada uma função f do tipo t -> u -> v, defina uma expressão da forma
- (\... -> ...)

para uma função do tipo u -> t -> v que se comporta como f 
mas recebe seus argumentos na ordem inversa
-}

invertArgs :: (t -> u -> v) -> (u -> t -> v)
invertArgs f = (\a b -> f b a)


-- ======= EXERCICIOS 2 ======= --

{-
Use aplicação parcial para definir a função
addNum
-}

addNum :: Int -> (Int -> Int)
addNum x = (+) x
-- poderia ser:
-- (+)
-- (+x) ou (x+) (section)
-- x + (erro de sintaxe -> operador binário não pode ficar solto)

-- ======= TEORIA ======= --

{-
COMPOSIÇÃO DE FUNÇÕES

- operadores: . ou >.>

(.) :: (u -> v) -> (t -> u) -> (t -> v)
-pega duas funções e une em uma

(f . g) x = f(g(x))
(f >.> g) x = g(f(x))

=======

EXPRESSÃO LAMBDA

funcao sem nome (anônima), usada direto no lugar de uma funcao normal

\m -> 3 + m
significa uma funcao que recebe m e retorna 3 + m

ex:
(\m -> 3 + m) 10
= 13

ex2: 
comp2 :: (t -> u) -> (u -> u -> v) -> (t -> t -> v)
comp2 f g = (\x y -> g (f x) (f y))

OBS: muito usado para substituir "Where" em funções

======= 

FUNCAO COM PARAMETRO FIXO (CLOSURE)

def:
addNum n = (\m -> n + m)

significa:

addNum recebe n
devolve uma funcao que recebe m
essa funcao usa n "guardado" de antes

ex:
(addNum 5) 10
= 15

exp:
n fica fixo dentro da lambda, m varia depois

======

APLICAÇÕES PARCIAIS E CURRYING

// Currying: estrutura da linguagem haskell. Uma função com varios argumentos, na verdade
é uma cadeia de funcoes de 1 argumento. FUnções só possuem 1 argumento 

ex:
f :: a -> b -> c
na verdade é:
f :: a -> (b -> c) (associativo à direita)

- f recebe a e devolve uma funcao que espera b

// Aplicação parcial: uso do currying de forma favorável, consiste em usar uma funcao 
sem passar todos os argumentos, de forma a obter uma "função parcial" como retorno

ex:
defina f x y = x + y
depois, defina g = f 3
g agora eh uma funcao: g y = 3 + y, fixa o primeiro argumento e cria nova funcao

IDEIA CENTRAL

cada argumento "consome" uma funcao, argumento a argumento [f a b é f a, depois f' b, depois ...]
sobra sempre uma funcao ate receber tudo
permite criar funcoes novas facilmente a partir de outras

======

SECTIONS (SEÇÕES DE OPERADORES)

atalhos para criar funções parciais a partir de operadores de 2 argumentos (+, >, <, *, ++, : etc)

quando você passa uma section para uma função como map/filter/foldr, você está passando uma 
lambda expression disfarçada, de forma concisa e clara

(+2)	    =>	\x -> x + 2
(2+)	    =>	\x -> 2 + x
(>2)	    =>	\x -> x > 2
(3:)	    =>	\xs -> 3 : xs
(++ "\n")	=>	\s -> s ++ "\n"

e quando aplica:
map (+1)	=>	map (\x -> x + 1) 

e quando compõe funções:
map (+1) >.> filter (>0)
- primeiro mapeira pra mais 1, depois filtra só os maiores que 0

ou

getEvens = filter ((==0).(‘mod‘ 2))
- quando vai filtrar, 
-}