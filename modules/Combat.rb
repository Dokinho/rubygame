def enemy
  @player.interacting_with
end

def fight_intro
  system "cls"
  puts enemy.image
  puts "You are fighting #{enemy.name}!"
  sleep 2
  fight
end

def fighter_stats
  puts "#{@player.name}   HP: #{@player.health} / #{@player.max_health}     VS     #{enemy.name}   HP: #{enemy.health} / #{enemy.max_health}"
end

def player_turn
  puts @player.image
  puts "#{@player.name}'s turn"

  choices = @player.abilities.map { |ability| ability.name }.push("Run Away")
  choice = @prompt.select("Choose an action:", choices )

  if choice == "Run Away"
    system "cls"
    puts "You have run away from the enemy!"
    sleep 1
    return "Run"
  else
    ability =  @player.abilities.find { |ability| ability.name == choice}
    ability.activate(enemy)

    puts "#{@player.name} dealt #{@player.damage} damage to #{enemy.name}"
    sleep 1
  end
end

def enemy_turn
  puts enemy.image
  puts "#{enemy.name}'s turn"
  sleep 1
  enemy.deal_damage(@player)
  puts "#{enemy.name} dealt #{enemy.damage} damage to #{@player.name}"
  sleep 1
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
    
    if @player.dead
      deadman = true
      defeat
    elsif enemy.dead
      deadman = true
      victory
    end
  end
end

def victory
  puts "You killed #{enemy.name}!"
  @map.remove_object(enemy)
  sleep 2
end

def defeat
  puts "Ah sheesh...you died"
  puts "You will respawn"
  sleep 2
  # Player respawn is handled in "State", not here
end