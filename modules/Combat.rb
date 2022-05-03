def enemy
  @player.interacting_with
end

def fight_intro
  system "cls"
  puts "You are fighting #{enemy.name}!"
  sleep 2
end

def fighter_stats
  puts "#{@player.name}   HP: #{@player.health} / #{@player.max_health}"
  puts
  puts "         VS"
  puts
  puts "#{enemy.name}   HP: #{enemy.health} / #{enemy.max_health}"
end

def player_turn
  puts "#{@player.name}'s turn"

  choices = @player.abilities.map { |ability| ability.name }.push("Run Away")
  choice = @prompt.select("Choose an action:", choices )

  if choice == "Run Away"
    system "cls"
    puts "You have run away from the enemy!"
    sleep 2
    return "Run"
  else
    ability =  @player.abilities.find { |ability| ability.name == choice}
    ability.activate(enemy)

    puts "#{@player.name} dealt #{@player.damage} damage to #{enemy.name}"
    sleep 2
  end
end

def enemy_turn
  puts "#{enemy.name}'s turn"
  sleep 2
  enemy.deal_damage(@player)
  puts "#{enemy.name} dealt #{enemy.damage} damage to #{@player.name}"
  sleep 2
end

def fight
  turn = 0
  deadman = false

  until deadman do
    system "cls"
    turn +=1
    fighter_stats
    puts

    if turn.odd?
      break if player_turn == "Run"
    else
      enemy_turn
    end
    
    if @player.health <= 0
      deadman = true
      defeat
    elsif enemy.health <= 0
      deadman = true
      victory
    end
  end
end

def victory
  puts "You killed #{enemy}!"
  sleep 2
end

def defeat
 puts "Ah sheesh...you died"
 puts "You will respawn"
 sleep 2
end