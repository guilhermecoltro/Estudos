class Jacobi
	
	attr_accessor :error
	attr_accessor :matrix
	attr_accessor :results
	attr_accessor :solutions

	#Initializing the Class
	def initialize(error, matrix, results, shoot)
		@error = error
		@matrix = matrix
		@results = results
		@solutions = []

		if !checkStricklyDD(@matrix)
			puts "Erro - The Matrix isn't strictly diagonally dominant!"
			exit
		end
		
		if shoot.length != @matrix.length
			puts "Erro - Ititial Shoot size!"
			exit
		else
			@solutions[0] = shoot
		end

	end


	#Mounting Solutions Matrix
	def mountSolutions
		
		i = 0
		k = 1

		begin
			@solutions[k] = []

			for j in 0...@matrix.length do

				@solutions[k][j] = applyFunction(@results[j], getAdjacency(@matrix[j], j), @matrix[j][j], k-1, j)

			end

			if (i+1) == @matrix.length
				i = 0
			else
				i += 1
			end

			k += 1

		end while checkError(getMaxError(k-1))

	end

	#Function that Receives a line of @matrix, and a index(k), who get de Adjacency numbers in that line and return an array
	def getAdjacency(line, k)

		array = []

		for i in 0...line.length do
			if k != i
				array.push(line[i])
			end
		end

		return array
	end

	#Function to Sum All Array for the recurrence equation
	def sumAllArray(adjacency, index, central)
		value = 0
		i = 0

		adjacency.each do |e|
			if i == central
				i+=1
			end

			value += (e*@solutions[index][i])

			i+=1
		end

		return value
	end

	#Function to Apply the RecurrencesEquations
	def applyFunction(s, adjacency, c, index, central)
		return (Float(s - sumAllArray(adjacency, index, central))/c)
	end

	#Function to check if the number is Greater than error
	def checkError(n)
		if n > @error
			return true
		else
			return false
		end
	end

	def getMaxError(index)

		if index == 0
			return 1
		end

		array = []

		for i in 0...@solutions[index].length do
			array[i] = (@solutions[index][i] - @solutions[index-1][i]).abs
		end

		greater = array[0]

		for j in 1...array.length do
			if array[j] > greater
				greater = array[j]
			end
		end

		return greater

	end

	def showSolutions
		print "K\t"

		for x in 0...@solutions[0].length do
			print "         X"+(x+1).to_s+"       \t"
		end

		print "Erro\n"

		for i in 0...@solutions.length do
			print i.to_s+"\t"

			@solutions[i].each do |e|
				print "%.20f" % e.to_f+"\t"
			end
			print "%.20f" % getMaxError(i).to_f+"\t"			
			print "\n"
		end
	end

	#method to check if the matrix is strictly diagonally dominant
	def checkStricklyDD(m)
		line = []
		sum = 0

		for i in 0...m.length do
			line = getAdjacency(m[i], i)

			for j in 0...line.length do
				sum += line[j].abs
			end

			if m[i][i].abs <= sum
				return false
			end

			line = []
			sum = 0
		end

		return true

	end

end

$a = []
$r = []
$c = []
$e = 0

def ptInput

	begin
		puts "CALCULO DE SISTEMAS LINEARES UTILIZANDO O METODO DE GAUSS-JACOBI"
		puts " "
		
		puts "*** Criacao da Matriz a partir do Sistema ***"
		puts "Quantas Variaveis possuem o Sistema?\n"
		vars = gets.chomp.to_i

		for i in 0...vars do
			$a[i] = []
			for j in 0...vars do
				puts "Digite o valor de A[#{i+1}][#{j+1}]"
				$a[i][j] = gets.chomp.to_i
			end

			puts "Digite o resultado da equacao #{i+1}"
			$r[i] = gets.chomp.to_i
		end

		puts " "
		puts "*** Instancia do Chute inicial ***"

		for i in 0...vars do
			puts "Digite o valor de X#{i+1} para o chute inicial"
			$c[i] = gets.chomp.to_i
		end

		puts " "
		puts "*** Atribuicao de um erro ***"
		puts "Digite o valor do erro (Exemplo: 0.00001) - UTILIZE PONTOS AO INVES DE VIRGULAS"
		$e = gets.chomp.to_f

		system "clear"

		puts "*** Confirmacao dos dados ***"
		puts" "

		for i in 0...vars do
			print "|\t"

			for j in 0...vars do
				print $a[i][j].to_s+"\t"
			end

			print "|"

			if i == (vars/2).to_i
				print "*"
			else
				print " "
			end

			print "| X#{i+1} \t|"

			if i == (vars/2).to_i
				print "="
			else
				print " "
			end

			print "|\t #{$r[i]}\t |\t"

			if i == (vars/2).to_i
				print "X0 = "
			else
				print "     "
			end

			print "|\t #{$c[i]}\t |"

			print "\n"
		end
		puts " "
		print "\t\te = %.20f" % $e.to_f+"\n"
		puts " "
		puts "Os dados estao corretos? [s] Sim \t [n] Nao"
		ans = gets.chomp
	end while ans != "s"
end

def engInput
	
	begin
		puts "CALCULATION OF LINEAR SYSTEMS USING GAUSS-JACOBI METHOD"
		puts " "
		
		puts "*** Creation of Matrix from System ***"
		puts "How Many Variables have the System?\n"
		vars = gets.chomp.to_i

		for i in 0...vars do
			$a[i] = []
			for j in 0...vars do
				puts "Input the value of A[#{i+1}][#{j+1}]"
				$a[i][j] = gets.chomp.to_i
			end

			puts "Input the result of the equation #{i+1}"
			$r[i] = gets.chomp.to_i
		end

		puts " "
		puts "*** Instance of the Initial Shoot ***"

		for i in 0...vars do
			puts "Input the value of the X#{i+1} for the initial shoot"
			$c[i] = gets.chomp.to_i
		end

		puts " "
		puts "*** Assignment of an error ***"
		puts "Input the value of the error (Example: 0.00001) - USE ITEMS INSTEAD OF COMMAS"
		$e = gets.chomp.to_f

		system "clear"

		puts " "
		puts "*** Data Confirmation ***"
		puts" "

		for i in 0...vars do
			print "|\t"

			for j in 0...vars do
				print $a[i][j].to_s+"\t"
			end

			print "|"

			if i == (vars/2).to_i
				print "*"
			else
				print " "
			end

			print "| X#{i+1} \t|"

			if i == (vars/2).to_i
				print "="
			else
				print " "
			end

			print "|\t #{$r[i]}\t |\t"

			if i == (vars/2).to_i
				print "X0 = "
			else
				print "     "
			end

			print "|\t #{$c[i]}\t |"

			print "\n"
		end
		puts " "
		print "\t\te = %.20f" % $e.to_f+"\n"
		puts " "
		puts "The data are correct? [y] Yes \t [n] No"
		ans = gets.chomp
	end while ans != "y"
end

system "clear"

puts "Please, select the language: [1] English \t [2] Portuguese"

lang = gets.chomp.to_i

system "clear"

if  lang == 1
	engInput
else
	ptInput
end

j = Jacobi.new($e,$a, $r, $c)

#j = Jacobi.new(0.0001, [[10, 2, -3, 2], [2, -15, 3, -2], [1, -3, 20, 2], [2, 2, -1, 30]], [32, -59, -38, 160], [0,0,0,0])

j.mountSolutions
j.showSolutions