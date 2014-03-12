#!/bin/bash

clear

echo "*******************************"
echo "*      AUTOMATIC BACKUP       *"
echo "*******************************"

echo ""


#VARIÁVEIS DE CONFIGURAÇÃO


	#Variável apontando diretório raiz dos arquivos de Backup
	diretorioraiz=/home/username/

	#Variáveis contendo Usuário e Senha, respectivamente, do banco de dados
	user=shellscript
	pass=llehs

#FIM VARIÁVEIS DE CONFIGURAÇÃO



# Função Utilizada para criar o diretório dos backups e o arquivo de log
#
# @author Guilherme Barbosa

function criaDiretorios()
{
	echo "...Verificando Diretórios de Backup e Arquivo de Log..."
	echo ""

	diretorioBKP="$diretorioraiz"/MySQLDumpFiles
	arquivoBKP="$diretorioBKP"/messages_backup.log

	#CRIANDO DIRETÓRIO RAIZ DE BACKUPS
	if [ ! -d "$diretorioBKP" ]; then
		mkdir "$diretorioBKP"
	fi


	#CRIANDO SUBDIRETÓRIOS DE BACKUPS
	if [ ! -d "$diretorioBKP"/1 ]; then
		mkdir "$diretorioBKP"/1
	fi

	if [ ! -d "$diretorioBKP"/2 ]; then
		mkdir "$diretorioBKP"/2
	fi

	if [ ! -d "$diretorioBKP"/3 ]; then
		mkdir "$diretorioBKP"/3
	fi

	if [ ! -d "$diretorioBKP"/4 ]; then
		mkdir "$diretorioBKP"/4
	fi

	if [ ! -d "$diretorioBKP"/5 ]; then
		mkdir "$diretorioBKP"/5
	fi

	if [ ! -d "$diretorioBKP"/6 ]; then
		mkdir "$diretorioBKP"/6
	fi

	if [ ! -d "$diretorioBKP"/7 ]; then
		mkdir "$diretorioBKP"/7
	fi


	#CRIANDO ARQUIVO DE LOGS
	if [ ! -e "$arquivoBKP" ]; then
		touch "$arquivoBKP"
	fi
}

# Função Utilizada para Alimentar o arquivo de Logs conforme forem gerados os Backups
#
# @author Guilherme Barbosa

function alimentaLog()
{

	echo "...Alimentando Arquivo de Log..."
	echo ""

	case $(date +%u) in
		1) diasem="Segunda-feira" ;;
		2) diasem="Terça-feira" ;;
		3) diasem="Quarta-feira" ;;
		4) diasem="Quinta-feira" ;;
		5) diasem="Sexta-feira" ;;
		6) diasem="Sabado" ;;
		7) diasem="Domingo" ;;
	esac

	echo "Backup de $diasem efetuado no dia $(date +%d)/$(date +%m)/$(date +%y) as $(date +%T) salvo na pasta $(date +%u)" >> "$diretorioraiz"/MySQLDumpFiles/messages_backup.log

	echo "...Backup efetuado com sucesso..."
	echo ""
	echo "#################################"
	echo ""
}


# Função Utilizada para Criar os arquivos de Dumps a partir de um array contendo todas as databases acessadas por aquele usuário
#
# @author Guilherme Barbosa

function criaDump()
{

	echo "...Criando arquivo Dump no Banco de dados..."
	echo ""

	case $(date +%u) in
		1) diabac="1" ;;
		2) diabac="2" ;;
		3) diabac="3" ;;
		4) diabac="4" ;;
		5) diabac="5" ;;
		6) diabac="6" ;;
		7) diabac="7" ;;
	esac

	for i in ${banco[@]}
	do
		if [ -e "$diretorioraiz"/MySQLDumpFiles/$diabac/$i.sql.gz ]; then
			rm "$diretorioraiz"/MySQLDumpFiles/$diabac/$i.sql.gz
		fi
		
		mysqldump -u $user -p$pass $i | gzip > "$diretorioraiz"/MySQLDumpFiles/$diabac/$i.sql.gz
	done
}






#Iniciando Programa

criaDiretorios

for db in $(mysql --user=$user --password=$pass -e 'show databases' -s --skip-column-names|grep -vi information_schema|grep -vi performance_schema| grep -vi mysql);
do 
	banco[count]=$db
	let count++
done

criaDump
alimentaLog
