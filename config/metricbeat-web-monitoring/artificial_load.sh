for i in {1..100}
do
  mysql -uubuntu -pelastic < /home/ubuntu/scripts/mysql_load.sql &> /dev/null
  for i in {1..5}
  do
    curl -s localhost/short_delay -o /dev/null &
  done
done
