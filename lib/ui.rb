# User-friendly UI
class UI
  def yesno_prompt(message)
    print message + ' Y\n?'
    input = $stdin.gets
    input[0].downcase == 'n'
  end

  def puts(message)
    $stdout.puts message
  end
end
