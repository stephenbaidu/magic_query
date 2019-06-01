require_relative 'magic_query/version'
require_relative 'magic_query/parser'

module MagicQuery
  def self.valid?(query)
    Parser.new(query).valid?
  end

  def self.matched?(query, values = {})
    Parser.new(query).matched?(values)
  end
end
