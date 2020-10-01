class Solver
    attr_reader :initSudoku, :tempSudoku


    def initialize(sudokuPath)
        @initSudoku = loadSudoku(sudokuPath)
        @tempSudoku = {}
    end

    #loading sudoku to the hash
    def loadSudoku(filename)
        content = {}
        File.foreach(filename).with_index do |line, line_num|
            content.store(line_num,line.split(" ").map{|x| x.to_i})
         end
        content
    end

    #print actual sudoku to the cmd
    def printSudoku(sudoku)
        sudoku.each do |line_num, content|
            puts "#{line_num}: #{content.join(', ').gsub(","," ")}"
        end
        
    end

    # function for row vals
    def rowVals(row_index, column_index)
        pos = [*1..9]
        @tempSudoku[row_index].each do |val|
            pos -= [val]
        end
        pos
    end

    # function for column vals
    def colVals(row_index, column_index)
        pos = [*1..9]
        (0...9).each do |i|
            pos -= [@tempSudoku[i][column_index]]
        end
        pos
    end

    # function for square vals
    def squareVals(row_index, column_index)
        # tady se musím nutně podívat do správného čtverce!
        shiftX = 0
        shiftY = 0
        pos = [*1..9]
        # zjistím si posun do správného čtverce pomocí dělení 3
        shiftX = ((row_index.to_f/3.0).floor)*3
        shiftY = ((column_index.to_f/3.0).floor)*3
        (0...3).each do |x|
            (0...3).each do |y|
                pos -= [@tempSudoku[shiftX + x][shiftY + y]]
            end
        end
        pos
    end

    # function for possible vals array
    def possibleVals(row_index, column_index, used = [])
        # podívám se co může být v řádku, co může být ve spouci a co může být ve čtverci a udělám průsečík
        # row
        rowAry = rowVals(row_index, column_index)
        colAry = colVals(row_index, column_index)
        sqrAry = squareVals(row_index, column_index)

        # udělám průnik polí
        vals = (rowAry & colAry & sqrAry)
        vals -= used
        vals
    end

    # trySolve
    def trySolve()
        @tempSudoku.each do |key, row|
            row.each.with_index do |val, val_index|
                if val == 0
                    # zapíšu si možné hodnoty do pole
                    vals = possibleVals(key, val_index)
                    # pro každou hodnotu zkusím najít řešení
                    vals.each do |value|
                        @tempSudoku[key][val_index] = value
                    end
                end
            end
        end
        true
    end

    # maim method for solving sudoku
    def solveSudoku()

        #budu to řešit rekurzivně, pojedu po řádku a budu tipovat čísla
        # uložím si initSudoku do tempu
        @tempSudoku = @initSudoku

        # procházím tempSudoku a hledám nulu, což je prázdná pozice
        trySolve()

    end

end