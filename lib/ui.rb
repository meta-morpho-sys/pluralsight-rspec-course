# User-friendly UI
class UI
  def wanna_bet_prompt(message)
    print message + ' Y/n? '
    input = $stdin.gets
    y_or_n  = input[0].downcase
    y_or_n != 'n'
  end

  def puts(message)
    $stdout.puts message
  end
end
