module MagicQuery
  class Parser
    ARITHMETIC_OPERATORS = %w[eq lt gt lteq gteq noteq].freeze
    ALL_OPERATORS = (
      ARITHMETIC_OPERATORS + %w[always is isnot in notin]
    ).freeze

    def initialize(query)
      @query = query
      @values = {}
    end

    def valid?
      conditions.all? { |e| condition_valid?(e) }
    end

    def matched?(values = {})
      all_valid = conditions.all? { |e| condition_valid?(e) }
      return nil unless all_valid

      @values = values
      conditions.all? { |e| condition_matched?(e) }
    end

    private

    attr_reader :query, :values

    def conditions
      query.split(' AND ').map(&:strip)
    end

    def condition_valid?(condition)
      variable_operator_operand(condition) != false
    end

    def condition_matched?(condition)
      variable, operator, operand = variable_operator_operand(condition)
      # special case for always matched queries
      return true if operator == 'always'

      value = values[variable.to_sym]
      value ||= values[variable]
      return false if value.nil?

      if operator == 'is'
        operand == value
      elsif operator == 'isnot'
        operand != value
      elsif operator == 'in'
        operand.include?(value)
      elsif operator == 'notin'
        !operand.include?(value)
      elsif ARITHMETIC_OPERATORS.include?(operator)
        if operator == 'eq'
          value == operand
        elsif operator == 'lt'
          value < operand
        elsif operator == 'gt'
          value > operand
        elsif operator == 'lteq'
          value <= operand
        elsif operator == 'gteq'
          value >= operand
        elsif operator == 'noteq'
          value != operand
        end
      else
        false
      end
    end

    def variable_operator_operand(condition)
      # Split on first dot(.) and first space
      variable, operator, operand = condition.strip.split(/[.,\s]/, 3)
      return false unless !variable.nil? && ALL_OPERATORS.include?(operator)

      # Format operand into valid ruby type
      formatted_operand =
        if %w[is isnot].include?(operator)
          operand
        else
          format_operand(operand, operator)
        end

      [variable, operator, formatted_operand]
    end

    def format_operand(operand, operator)
      return format_inop_operand(operand) if %w[in notin].include?(operator)
      return operand.to_f if ARITHMETIC_OPERATORS.include?(operator)

      false
    end

    def format_inop_operand(operand)
      if operand.include?('..')
        Range.new(*operand.split('..').map(&:to_i))
      elsif operand.include?(',')
        operand.split(',')
      else
        false
      end
    end
  end
end
