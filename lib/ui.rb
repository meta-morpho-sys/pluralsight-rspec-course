# User-friendly UI
class UI
  # returns true or false depending on user's input
  def wanna_bet?(message)
    print message + ' Y/n? '
    input = $stdin.gets
    y_or_n  = input[0].downcase
    y_or_n != 'n'
  end

  def puts(message)
    $stdout.puts message
  end
end
