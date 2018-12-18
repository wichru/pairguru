class TitleBracketsValidator < ActiveModel::Validator
  BRACKET_PAIRS = { '[' => ']', '{' => '}', '(' => ')' }

  def validate(record)
    string = record.title

    if !empty_brackets?(string)
      record.errors.add(string, "brackets cannot be empty")
    elsif !closed_brackets?(string)
      record.errors.add(string, "brackets cannot be open or in wrong order")
    end
  end

  private

  def empty_brackets?(string)
    %w[ () [] {} ].none?(&string.method(:include?))
  end

  def closed_brackets?(string)
    string.chars.each_with_object([]) do |char, bracket_stack|
      if BRACKET_PAIRS.keys.include? char
        bracket_stack << char
      elsif BRACKET_PAIRS.values.include? char
        if bracket_stack.empty? || char != BRACKET_PAIRS[bracket_stack.last]
          return false
        else
          bracket_stack.pop
        end
      end
    end.empty?
  end
end
