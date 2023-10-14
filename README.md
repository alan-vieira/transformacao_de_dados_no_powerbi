# Transformação de Dados no Power BI
## Descrição
Transformação de dados no Power BI com a base MySQL conectada do MS Azure.

## Banco de dados MySQL na Azure
Após a criação da instância na Azure para MySQL, o banco azure_company foi criado e integrado ao Power BI para recerber as transformações.

## Transformações de dados no Power BI
1. O cabeçalhos e os tipos de dados foram ajustado ao longo das tranformações no projeto.
2. Após o carregamento dos dados as colunas de metadata foram removidas de todas as tabelas.
3. Os IDs tiveram o tipo alterado para inteiro.
4. A coluna Salary da tabela employee teve o tipo alterado para número decimal fixo, ficando de acordo com o banco.
5. O único valor nulo encontrado corresponde ao colaborador que não possue gerente e é gerente.

![Seperação da coluna que compone o endereço](img/.png)

6. Verificação do número de horas por projeto.

![Seperação da coluna que compone o endereço](img/.png)

7. O endereço da tabela employee foi separado em outras colunas: Anumber, Astreet, Acity, Astate.
   
![Seperação da coluna que compone o endereço](img/1.png)

8. Foi criada uma consulta para as tabelas employee e departament com o axílio de uma querry do banco enviada para o Power BI.
```sql
-- agrupamento da coluna employeer com departament
select concat(Fname, " ", Minit, " ", Lname) as Name, Dname as Departament from employee as e
	inner join departament as d on e.Dno = d.Dnumber;
```
9. Para a junção dos colaboradores e gerentes com seus respectivos nomes, foi criada uma consulta no Power BI com axílio de uma querry.
```sql
-- agrupamento da coluna employeer com manager
select concat(e.Fname, " ", e.Minit, " ", e.Lname) as Employeer, concat(m.Fname, " ", m.Minit, " ", m.Lname) as Manager
from employee as e
left join employee as m on e.Super_ssn = m.Ssn;
```
10. As colunas que compõem o nome do colaborador (Ename) na tabela employee foram mescladas.

![Seperação da coluna que compone o endereço](img/1.png)

11. As tabelas departament e dept_locations foram unidas para posteriormente terem as colunas Dname e Dlocation mescladas. A tabela desnecessário foi removida.

![Junção das colunas que formam o nome e a localização](img/2.png)
