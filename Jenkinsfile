pipeline {
  agent any
   stages {
    stage ('Build') {
      steps {
        sh '''#!/bin/bash
        python3 -m venv test3
        source test3/bin/activate
        pip install pip --upgrade
        pip install -r requirements.txt
        export FLASK_APP=application
        flask run &
        '''
     }
   }
    stage ('test') {
      steps {
        sh '''#!/bin/bash
        source test3/bin/activate
        py.test --verbose --junit-xml test-reports/results.xml
        ''' 
      }
    
      post{
        always {
          junit 'test-reports/results.xml'
        }
       
      }
    }
     stage ('Clean') {
      agent{label 'awsDeploy'}
      steps {
        sh '''#!/bin/bash
        ps aux | grep -i "gunicorn" | tr -s " " | head -n 1 | cut  -d " " -f 2 > pid.txt
        kill $(cat pid.txt)
        cd
        rm -rf ./deploy1
        '''
      }
    } 
    stage ('Deploy') {
      agent{label 'awsDeploy'}
      steps {
      keepRunning {
        sh '''#!/bin/bash
        pip install -r requirements.txt
        pip install gunicorn
        ls
        python3 -m gunicorn -w 4 application:app -b 0.0.0.0 --daemon
        '''
       }
      }
    } 
  }
}
