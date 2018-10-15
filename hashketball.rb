def game_hash
game_hash = {home:
             {team_name:"Brooklyn Nets" , colors:["Black","White"] , players:
               {"Alan Anderson" =>
                 {number: 0, shoe: 16, points: 22, rebounds: 12,
                  assists: 12, steals: 3, blocks: 1, slam_dunks: 1},
               "Reggie Evans" =>
                 {number: 30, shoe: 14, points: 12, rebounds: 12,
                  assists: 12, steals: 12, blocks: 12, slam_dunks: 7},
               "Brook Lopez" =>
                 {number: 11, shoe: 17, points: 17, rebounds: 19,
                  assists: 10, steals: 3, blocks: 1, slam_dunks: 15},
               "Mason Plumlee" =>
                 {number: 1, shoe: 19, points: 26, rebounds: 12,
                  assists: 6, steals: 3, blocks: 8, slam_dunks: 5},
               "Jason Terry" =>
                 {number: 31, shoe: 15, points: 19, rebounds: 2,
                  assists: 2, steals: 4, blocks: 11, slam_dunks: 1}
               }
             },

           away:
             {team_name:"Charlotte Hornets" , colors: ["Turquoise", "Purple"] , players:
               {"Jeff Adrien" =>
                 {number: 4, shoe: 18, points: 10, rebounds: 1,
                  assists: 1, steals: 2, blocks: 7, slam_dunks: 2},
              "Bismak Biyombo" =>
                {number: 0, shoe: 16, points: 12, rebounds: 4,
                 assists: 7, steals: 7, blocks: 15, slam_dunks: 10},
              "DeSagna Diop" =>
                {number: 2, shoe: 14, points: 24, rebounds: 12,
                 assists: 12, steals: 4, blocks: 5, slam_dunks:5},
              "Ben Gordon" =>
                {number: 8, shoe: 15, points: 33, rebounds: 3,
                 assists: 2, steals: 1, blocks: 1, slam_dunks: 0},
              "Brendan Haywood" =>
                {number: 33, shoe: 15, points: 6, rebounds: 12,
                 assists: 12, steals: 22, blocks: 5, slam_dunks: 12}
               }
             }
          }
end


##Helper method that does most of the iterations to retrieve team info at various level
def team_info(player_name='')
 players_and_stats = []
 all_stats_array=[]
 game_hash.each do |team, team_details|
   yield team_details if block_given? # This will yield team_details hash for calling methods that need team info.
   if team_details.is_a?(Hash)
      team_details.each do |team_identifier_name, team_identifier_value|
        if team_identifier_value.is_a?(Hash)
           team_identifier_value.each do |stats_name,stats_value|
             players_and_stats << [stats_name,stats_value]
           end
         end
       end
     end
 end


 if player_name.empty?
   players_and_stats.each_with_index do |ele, i|
      all_stats_array << players_and_stats[i][1] #This will return an array of hashes of all players
   end
   return all_stats_array
 else
   players_and_stats.each_with_index do |ele|
     return ele.last if ele.first == player_name ##this will return a hash of statistics for a given player
   end

 end

end


##Implementing scores retrieval methods
def num_points_scored(player_name)
 team_info(player_name)[:points]
end


##Implementing Shoe size
def shoe_size(player_name)
 team_info(player_name)[:shoe]
end



##Implementing team_colors method
def team_colors(team_name)
  team_info do |team_details| #calling team_info method with do block. This will receive team details hash yielded by the method.
    if team_details[:team_name] == team_name
      return team_details[:colors]
    end
  end
end


##Implementing team names
def team_names
  teams=[]
  team_info do |team_details|
    teams << team_details[:team_name]
  end
  return teams
end


##Implementing player_numbers
def player_numbers(team_name)
  jersey_nums = []
  team_info do |team_details|
    if team_details[:team_name] == team_name
      team_details[:players].values.each {|num| jersey_nums << num[:number]}
    end
  end
 return jersey_nums
end


##Implementing player_stats
def player_stats(name)
 team_info(name)
end


#Implementing Big shoe rebound
def big_shoe_rebounds
team_info.max_by {|h| h[:shoe]}[:rebounds]#h[:shoe] returns a hash of stats with the biggest shoe size
end
