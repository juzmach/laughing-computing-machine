# encoding: utf-8
class Validator
  def self.not_empty? (string)
    if string.nil?
      return {result: false, message: "cannot be null"}
    elsif string.empty?
      return {result: false, message: "cannot be empty"}
    else
      return {result: true, message: "is not empty"}
    end
  end

  def self.shorter_than? (requirement,string)
    if string.nil?
      return {result: false, message: "cannot be null"}
    elsif string.length < requirement
      return {result: true, message: "is shorter"}
    else
      return {result: false, message: "cannot be longer than #{requirement}"}
    end
  end

  def self.longer_than? (requirement, string)
    if string.nil?
      return {result: false, message: "cannot be null"}
    elsif string.length > requirement
      return {result: true, message: "is longer"}
    else
      return {result: false, message: "cannot be shorter than #{requirement}"}
    end
  end

  def self.not_below_zero? (number)
    if number < 0
      return {result: false, message: "cannot be below zero"}
    else
      return {result: true, message: "is not below zero"}
    end
  end
end