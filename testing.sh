  #!/bin/bash
 
ps aux | grep -i "gunicorn" | tr -s " " | head -n 1 | cut  -d " " -f 2 > pid.txt
kill $(cat pid.txt)
