# KEY VARIABLE RECALL & EXECUTION
deploycheck() {
  dcheck=$(docker ps --format '{{.Names}}' | grep "plexautoscan")
  if [[ "$dcheck" == "plexautoscan" ]]; then
    run1
  else run2; fi
}
run1() {
docker stop plexautoscan
docker rum plexautoscan
rm -rf /opt/appdata/plexautoscan
rm -rf mkdir -p /var/plexguide/pgscan
}
run2() {
exit 1
}