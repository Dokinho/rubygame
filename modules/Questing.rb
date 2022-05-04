def questgiver
  @player.interacting_with
end

def questgiver_welcome
  loop do
    system "cls"
    puts questgiver.greeting
    choice = @prompt.select("Choose an action:", ["Browse Quests", "Leave"])
    choice == "Browse Quests" ? display_quests : questgiver_goodbye; break
  end
end

def display_quests
  system "cls"
  puts "-----#{questgiver.name}-----"
  puts

  choices = questgiver.quests.map { |quest| quest.name }.push("Go Back")
  choice = @prompt.select("Choose a quest:", choices)

  unless choice == "Go Back"
    quest = questgiver.quests.find { |quest| quest.name == choice}
    @player.accept_quest(quest)
  end
end

def questgiver_goodbye
  system "cls"
  puts questgiver.goodbye
  sleep 2
end