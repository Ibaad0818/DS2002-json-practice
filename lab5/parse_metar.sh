curl -s "https://aviationweather.gov/api/data/metar?ids=KMCI&format=json&taf=false&hours=12&bbox=40%2C-90%2C45%2C-85" > aviation.json

echo "Receipt Times:"
jq -r '.[].receiptTime' aviation.json | head -n 6

temps=$(jq -r '.[].temp' aviation.json)
sum=0
count=0

for temp in $temps; do
  sum=$(echo "$sum + $temp" | bc)
  count=$((count + 1))
done

average=$(echo "scale=2; $sum / $count" | bc)
echo "Average Temperature: $average"

cloudy_count=$(jq -r '.[].cloud' aviation.json | grep -vc "CLR")
total=$(jq -r '.[].cloud' aviation.json | wc -l)

if [ "$cloudy_count" -gt $((total / 2)) ]; then
  echo "Mostly Cloudy: true"
else
  echo "Mostly Cloudy: false"
fi
