# encoding: utf-8
require 'sinatra'

def prepare_values(input)
  a, b = input.split('*')
  "#{'1' * a.to_i}*#{'1' * b.to_i}"
end

def markov(string, replacement)
  f = true
  i = 0
  log = ''
  while f do
    f = false
    replacement.each do |e|
      if (string != string.gsub(e[0], e[1]))
        log += "#{string} -> #{string.gsub(e[0], e[1])}\n"
        f = true
        string.gsub!(e[0], e[1])
        break
      end
    end
  end

  [string, log]
end

def composition(input)
  replacement = []
  replacement[0] = '*11', 'A*1'
  replacement[1] = '*1', 'A'
  replacement[2] = '1A', 'A1B'
  replacement[3] = 'BA', 'AB'
  replacement[4] = 'B1', '1B'
  replacement[5] = 'A1', 'A'
  replacement[6] = 'AB', 'B'
  replacement[7] = 'B', '1'

  output = "-> #{prepare_values(input)}\n"
  result = markov(prepare_values(input), replacement)
  output += result[1]
  output += "Output: #{result[0]}\n"
  output += "Result: #{result[0].length}\n"

  output
end

get '/' do
  erb :index
end

post '/' do
  @result = composition(params[:input])
  erb :index
end
