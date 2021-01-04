Progamação Lógica
3MIEIC04
C-Note_5
Code by Carlos Lousada (up201806302) & José David Rocha (up201806371)

Para resolver um dado problema, deve ser chamado o predicado solver(+Puzzle, +Soma), sendo o Puzzle uma lista de linhas, sendo cada linha uma lista de cada dígito do puzzle e Soma a soma de cada linha e cada coluna.
Exemplos de teste:
solver([[7,2,2],[2,2,6],[2,6,2]],100).
solver([[2,1,3],[2,6,3],[2,2,6]],500).
solver([[5,2,1,2],[2,9,4,5],[2,4,8,2],[1,4,7,1]],100).
solver([[3,7,8,4,1],[4,7,6,7,6],[1,2,8,5,5],[4,2,2,8,7],[2,5,6,1,2]],50).

Para gerar um problema aleatório, deve ser chamado o predicado generate(+Size, +Soma), sendo Size um inteiro representativo do número de linhas e colunas (por exemplo 3 para um puzzle 3x3) e Soma a soma de cada linha e cada coluna.
Exemplos de teste:
generate(3,100).
generate(3,500).
generate(4,100).
generate(5,50).
