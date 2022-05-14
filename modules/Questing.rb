def questgiver
  @player.interacting_with
end

def questgiver_welcome
  loop do
    system "cls"
    puts questgiver.image
    puts questgiver.greeting
    choice = @prompt.select("Choose an action:", ["Browse Quests", "Leave"])
    case choice
    when "Browse Quests"
      display_quests
    else
      questgiver_goodbye
      break
    end
  end
end

def display_quests
  system "cls"
  puts "-----#{questgiver.name}-----"
  puts

  available_quests = questgiver.quests - @player.quests
  choices = available_quests.map { |quest| quest.name }.push("Go Back")
  choice = @prompt.select("Choose a quest:", choices)

  unless choice == "Go Back"
    quest = questgiver.quests.find { |quest| quest.name == choice}
    @player.accept_quest(quest)
  end
end

def questgiver_goodbye
  system "cls"
  puts questgiver.image
  puts questgiver.goodbye
  sleep 1
end