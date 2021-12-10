Board = Class{}

function Board:init(xoffset, yoffset)

    -- top left corner of the board
    self.xoffset = xoffset
    self.yoffset = yoffset
    self.cells = {}
    self.pencilMode = false
    -- create all cells
    i = 0
    puzzle = {
        {4,1,5,0,6,9,0,7,0},
        {0,0,3,0,0,1,0,2,0},
        {0,0,0,4,0,3,5,0,0},
        {6,7,2,1,0,0,0,0,4},
        {8,3,0,0,0,0,0,5,7},        
        {5,0,0,0,0,8,0,1,3},        
        {2,8,0,0,0,7,1,0,6},        
        {0,9,6,0,0,0,0,4,5},        
        {1,5,0,6,0,0,8,0,0},        
        }
    for kx, x in pairs(puzzle) do
        for ky, value in pairs(x) do
            table.insert(self.cells, Cell(i, kx - 1, ky - 1, self.xoffset, self.yoffset, value))    
            i = i + 1 
        end
    end

end

function Board:toggleMode()
    self.pencilMode = not self.pencilMode
end

function Board:update(dt)
end

function Board:getCurrentSelection()
    for k, cell in pairs(self.cells) do
        if cell.selected then
            return k
        end
    end
    return 40
end

function Board:insertSolution(num, index)
    cell = self.cells[index]
    isvalid = self:isValid(cell.row, cell.col, num)
    cell:input(num, isvalid, self.pencilMode)
end

function Board:render()
    for k, cell in pairs(self.cells) do
        cell:render()
    end
end

function Board:isValid(row, col, num)
    -- don't consider zero a wrong input because
    -- zero is a blank cell
    if num == 0 then
        return true
    end
    
    xb = math.floor(row / 3) * 3
    yb = math.floor(col / 3) * 3
    for k, cell in pairs(self.cells) do
        -- check if solution is same and the cell is not the same as parameter cell
        -- converting the row col to string for easy comparison of row,col combination
        if cell.solution == num and row .. col ~= cell.row .. cell.col then
            if cell.col == col or cell.row == row then
                return false
            end
            if inList(cell.row, {xb, xb + 1, xb + 2}) and inList(cell.col, {yb, yb + 1, yb + 2}) then
                return false
            end
        end
    end
    return true
end

