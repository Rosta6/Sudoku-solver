class Solver
    def initialize(sudokuPath)

        @initSudoku = loadSudoku(sudokuPath)


        printSudoku()
    end

    #loading sudoku to the hash
    def loadSudoku(filename)
        content = {}
        File.foreach(filename).with_index do |line, line_num|
            content.store(line_num,line.split(" "))
         end
        content
    end

    #print actual sudoku to the cmd
    def printSudoku()
        @initSudoku.each do |line_num, content|
            puts "#{line_num}: #{content.join(', ').gsub(","," ")}"
        end
        
    end
end