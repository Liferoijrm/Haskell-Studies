{- OLHAR ISSO DEPOIS, A PARTIR DA PÁGINA 16 DO SLIDE
CLASSES DERIVADAS E HERANÇA (Type Classes Avançadas)
- Herança: Uma classe pode exigir outra como pré-requisito.
  Ex: "class Eq t => Ord t" significa que para ser Ord, o tipo DEVE ser Eq primeiro.
- Métodos Padrão: A classe pode definir funções baseadas em outras (ex: (>=) definido usando (>)).

RESTRIÇÕES E INSTÂNCIAS:
- Restrições Múltiplas: (Ord t, Visible t) => Exige que 't' implemente ambas as interfaces.
- Instância de Tuplas: instance (Eq t, Eq u) => Eq (t,u)
  Define que um par é igual se os seus dois elementos (de tipos possivelmente diferentes) forem iguais.
- Herança Múltipla: Uma classe pode herdar de várias simultaneamente.

CLASSES PREDEFINIDAS IMPORTANTES:
1. Enum t: Tipos que podem ser enumerados em sequências (listas).
   - Sintaxe: [n .. m] (de n até m), [n, m .. k] (com passo definido pela diferença n-m).
2. Show / Read: 
   - show: Converte valor em String.
   - read: Converte String em valor (o oposto de show).
3. Num / Fractional:
   - Num: Interface para tipos numéricos básicos (Int, Integer, Float).
   - Fractional: Interface para tipos que suportam divisão fracionária (Float, Double).

POLIMORFISMO DE SOBRECARGA:
- Ao definir "rep n ch = ch : rep (n-1) ch", o Haskell infere:
  rep :: (Num a, Eq a) => a -> b -> [b]
- Isso permite que 'n' seja qualquer tipo numérico (Int, Float, etc), não apenas Int.
-}