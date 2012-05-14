require 'conway/rules/under_population'
require 'conway/rules/stability'
require 'conway/rules/over_population'
require 'conway/rules/reproduction'
require 'conway/rules/default'

module Conway
  class Rules
    attr_accessor :rules

    def initialize(rules=[UnderPopulation.new,
                          Stability.new,
                          OverPopulation.new,
                          Reproduction.new,
                          Default.new])
      self.rules = rules
    end

    def apply(cell, neighbors)
      rules.map do |rule|
        next_cell = rule.apply(cell, neighbors)
        break next_cell if next_cell
      end
    end

  end
end
