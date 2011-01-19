class RuleSet
  def apply(cell, neighbors)
    live_neighbors_count = neighbors.count {|n| n.alive? }
    case cell
    when LiveCell
      evaluate_live_cell(cell, live_neighbors_count)
    when DeadCell
      evaluate_dead_cell(cell, live_neighbors_count)
    end
  end

  private

  def evaluate_dead_cell(cell, live_neighbors_count)
    if live_neighbors_count == 3
      LiveCell.new
    else
      DeadCell.new
    end
  end

  def evaluate_live_cell(cell, live_neighbors_count)
    if live_neighbors_count < 2
      DeadCell.new
    elsif live_neighbors_count > 3
      DeadCell.new
    else
      LiveCell.new
    end
  end
end
