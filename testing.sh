  #!/bin/bash
  pip install -r requirements.txt
  pip install gunicorn
  python3 -m gunicorn -w 4 application:app -b 0.0.0.0 --daemon 
