#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"

echo ""

echo "Total number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo ""
echo "Total number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals + opponent_goals) FROM games")"

echo ""
echo "Average number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT AVG(winner_goals) FROM games")"

echo ""
echo "Average number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals), 2) FROM games")"

echo ""
echo "Average number of goals in all games from both teams:"
echo "$($PSQL "SELECT AVG(winner_goals + opponent_goals) FROM games")"

echo ""
echo "Most goals scored in a single game by one team:"
echo "$($PSQL "SELECT MAX(GREATEST(winner_goals, opponent_goals)) FROM games")"

echo ""
echo "Number of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT COUNT(*) FROM games WHERE winner_goals > 2")"

echo ""
echo "Winner of the 2018 tournament team name:"
echo "$($PSQL "SELECT name FROM games JOIN teams ON games.winner_id = teams.team_id WHERE round = 'Final' AND year = 2018")"

echo ""
echo "List of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "SELECT DISTINCT name FROM teams WHERE team_id IN (
  SELECT winner_id FROM games WHERE round='Eighth-Final' AND year=2014
  UNION
  SELECT opponent_id FROM games WHERE round='Eighth-Final' AND year=2014
) ORDER BY name")"

echo ""
echo "List of unique winning team names in the whole data set:"
echo "$($PSQL "SELECT DISTINCT name FROM games JOIN teams ON games.winner_id = teams.team_id ORDER BY name")"

echo ""
echo "Year and team name of all the champions:"
echo "$($PSQL "SELECT year || '|' || name FROM games JOIN teams ON games.winner_id = teams.team_id WHERE round = 'Final' ORDER BY year")"


echo ""
echo "List of teams that start with 'Co':"
echo "$($PSQL "SELECT name FROM teams WHERE name LIKE 'Co%'")"

echo ""
