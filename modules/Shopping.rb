def shopp
  @player.interacting_with
end
  
def shop_welcome
  loop do
    system "cls"
    puts shopp.image
    puts shopp.greeting
    choice = @prompt.select("Choose an action:", ["Buy Items", "Sell Items", "Leave"])
    
    case choice
    when "Buy Items" then buy
    when "Sell Items" then sell
    when "Leave"
      shop_goodbye
      break
    end
  end
end

def buy
  loop do
    system "cls"
    puts "-----#{shopp.name}-----"
    puts

    choices = shopp.inventory.map { |item| item.name }.push("Leave")
    choice = @prompt.select("Buy an item:", choices)

    if choice == "Leave"
      break
    else
      item = shopp.inventory.find { |item| item.name == choice}
      puts @player.buy_item(item)
      sleep 1
    end
  end
end

def sell
  loop do
    system "cls"
    puts "-----#{shopp.name}-----"
    puts

    choices = @player.inventory.map { |item| item.name }.push("Go Back")
    choice = @prompt.select("Sell an item:", choices)

    if choice == "Go Back"
      break
    else
      item = @player.inventory.find { |item| item.name == choice}
      puts @player.sell_item(item)
      sleep 1
    end
  end
end

def shop_goodbye
  system "cls"
  puts shopp.image
  puts shopp.goodbye
  sleep 1
end