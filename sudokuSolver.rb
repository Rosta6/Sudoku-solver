# My sudoku solver
# created by Rostislav Kubín 2020

require_relative "libs/Solver.rb"

# init method
sd = Solver.new("sudoku.txt")

# solving sudoku

    sd.printSudoku(sd.initSudoku)
    sd.solveSudoku()
    puts
    sd.printSudoku(sd.tempSudoku)